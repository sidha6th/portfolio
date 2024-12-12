#!/bin/bash

# Exit if no task name is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <task_name>"
  exit 1
fi

TASK_NAME=$1

# Define functions for tasks
run_gen() {
  echo "Running fluttergen..."
  fluttergen -c pubspec.yaml
}

run_build() {
  echo "Building..."
}

unknown_task() {
  echo "Unknown task: $TASK_NAME"
  echo "Available tasks: gen, build"
  exit 1
}

# Handle tasks
case "$TASK_NAME" in
  gen)
    run_gen
    ;;
  build)
    run_build
    ;;
  *)
    unknown_task
    ;;
esac


# gen - to generate assets
# build - to create release build