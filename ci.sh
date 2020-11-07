#!/bin/bash
set -euo pipefail

BASH_VER="${BASH_VER-
  latest 5.0.3 4.4.23 3.0.22
}"

for v in $BASH_VER
  do <<< '
    echo "[ bash:$v | $(date) ]"
    bash --version
    bash a/$1 2>&1 | sed "s/^./$BASH_VERSION | \\0/"
    echo
    ' docker run --rm -v "$PWD:/a:ro" -i -e "v=$v" "bash:$v" -s - test_assert.sh
  done
