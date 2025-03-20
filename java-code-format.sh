#!/usr/bin/env bash

set -e

./mvnw --batch-mode spotless:apply >/dev/null || {
  echo "java-code-format.sh: mvnw spotless:apply failed"
  exit 1
}
