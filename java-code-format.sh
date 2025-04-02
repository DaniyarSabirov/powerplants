#!/usr/bin/env bash

./mvnw --batch-mode spotless:apply >/dev/null || {
  echo "java-code-format.sh: mvnw spotless:apply failed"
  exit 1
}

