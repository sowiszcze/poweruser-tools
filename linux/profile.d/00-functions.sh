#!/bin/bash
echoerr() { echo "$@" >&2; }

envload() {
  if test -f "$1"; then
    echo "Loading environment variables based on file $1"
    export $(grep -v '^#' "$1" | xargs -d '\n')
    echo "Environment variables successfully loaded"
    return 0
  else
    echoerr "Environment file not present at select location"
    echoerr "Variables were not loaded"
    return 1
  fi
}

envunload() {
  if test -f "$1"; then
    echo "Unloading environment variables based on file $1"
    unset $(grep -v '^#' "$1" | sed -E 's/(.*)=.*/\1/' | xargs)
    echo "Environment variables successfully unloaded"
    return 0
  else
    echoerr "Environment file not present at select location"
    echoerr "No variables were unloaded"
    return 1
  fi
}

compose-latest() {
  COMPOSE_FILE=""
  COMPOSE_DEFAULT_NAMES="compose docker-compose"
  COMPOSE_DEFAULT_EXTENSIONS="yaml yml"
  # read on default Compose file paths at
  # https://docs.docker.com/compose/intro/compose-application-model/#the-compose-file

  if [ $# -gt 1 ]; then
    echoerr "Unsupported number of arguments: $#"
    return 1
  elif [ $# -eq 1 ]; then
    COMPOSE_FILE=$1
    if ! test -f "$COMPOSE_FILE"; then
      echoerr "Compose file $COMPOSE_FILE does not exist"
      return 2
    fi
  else
    for NAME in $COMPOSE_DEFAULT_NAMES
    do
      for EXTENSION in $COMPOSE_DEFAULT_EXTENSIONS
      do
        if test -f "$NAME.$EXTENSION"; then
          COMPOSE_FILE="$NAME.$EXTENSION"
        fi
      done
    done
    if [ ${#COMPOSE_FILE} -eq 0 ]; then
      echoerr "Compose file missing"
      return 2
    fi
  fi

  COMPOSE_FILE="$(realpath "$COMPOSE_FILE")"
  BASE_DIR="$(dirname "$COMPOSE_FILE")"

  ENV_PRELOADED=$(! [ "$MACHINE_DOMAIN" = "" ]; echo $?)
  if [ $ENV_PRELOADED -ne 0 ]; then
    envload "/srv/stacks/.env"
    if [ $? -ne 0 ]; then
      echoerr "There was an error loading master environment"
      return 4
    fi
  fi

  if test -f "$BASE_DIR/.env"; then
    envload "$BASE_DIR/.env"
  fi
  if test -f "$BASE_DIR/stack.env"; then
    envload "$BASE_DIR/stack.env"
  fi

  docker compose -f "$COMPOSE_FILE" config -q
  if [ $? -ne 0 ]; then
    echoerr "Aborting due to an invalid compose file $COMPOSE_FILE"
    if test -f "$BASE_DIR/.env"; then
      envunload "$BASE_DIR/.env"
    fi
    if test -f "$BASE_DIR/stack.env"; then
      envunload "$BASE_DIR/stack.env"
    fi
    if [ $ENV_PRELOADED -ne 0 ]; then
      envunload "/srv/stacks/.env"
    fi
    return 8
  fi

  docker compose -f "$COMPOSE_FILE" pull --policy always

  # we can supress `No resource` warnings with --log-level error, but then we'd miss on other info
  docker compose -f "$COMPOSE_FILE" down --remove-orphans
  if [ $? -ne 0 ]; then
    echoerr "Aborting due to an error during docker compose down"
    if test -f "$BASE_DIR/.env"; then
      envunload "$BASE_DIR/.env"
    fi
    if test -f "$BASE_DIR/stack.env"; then
      envunload "$BASE_DIR/stack.env"
    fi
    if [ $ENV_PRELOADED -ne 0 ]; then
      envunload "/srv/stacks/.env"
    fi
    return 16
  fi

  # from this point on we no longer care that much about result as we're on the finish line
  docker compose -f "$COMPOSE_FILE" up -d
  FAILED=$([ $? -ne 0 ]; echo $?)
  if test -f "$BASE_DIR/.env"; then
    envunload "$BASE_DIR/.env"
  fi
  if test -f "$BASE_DIR/stack.env"; then
    envunload "$BASE_DIR/stack.env"
  fi
  if [ $ENV_PRELOADED -ne 0 ]; then
    envunload "/srv/stacks/.env"
  fi
  if [ $FAILED -eq 0 ]; then
    echoerr "Deployment failed"
    return 32
  fi

  echo "Deployment finished"
  return 0
}
