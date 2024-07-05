#!/usr/bin/env bash
set -eEuo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

python3.11 -m venv "$SCRIPT_DIR/venv"
"$SCRIPT_DIR/venv/bin/python" -m pip install deptry 
"$SCRIPT_DIR/venv/bin/python" -m pip install -e "$SCRIPT_DIR/company.foo"
"$SCRIPT_DIR/venv/bin/python" -m pip install -e "$SCRIPT_DIR/company.bar"

echo "Running deptry on company.bar..."
# deptry fails with pyproject.toml not being found when ROOT isn't ".", bug?
#"$SCRIPT_DIR/venv/bin/python" -m deptry "$SCRIPT_DIR/company.bar" 
$(cd "$SCRIPT_DIR/company.bar" && "$SCRIPT_DIR/venv/bin/python" -m deptry .)
