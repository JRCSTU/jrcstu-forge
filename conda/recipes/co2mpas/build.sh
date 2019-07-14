#!/bin/bash
mkdir -p "$PREFIX/Menu"
cp "$RECIPE_DIR/menu.json" "$PREFIX/Menu/co2mpas.json"
cp "$RECIPE_DIR/menu.ico" "$PREFIX/Menu/co2mpas.ico"

"$PYTHON" -m pip install . --no-deps --ignore-installed -vv || exit 1