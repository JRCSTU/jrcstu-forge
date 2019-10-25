#!/bin/bash
mkdir -p "$PREFIX/Menu" &&
cp "$RECIPE_DIR/menu.json" "$PREFIX/Menu/co2exe.json" &&
cp "$RECIPE_DIR/menu.ico" "$PREFIX/Menu/co2wui.ico" &&
cp "$RECIPE_DIR/menu.ico" "$PREFIX/Menu/co2mpas.ico" &&
cp "$RECIPE_DIR/www.ico" "$PREFIX/Menu/www.ico" &&
cp "$RECIPE_DIR/folder.ico" "$PREFIX/Menu/folder.ico" &&
cp "$RECIPE_DIR/console.ico" "$PREFIX/Menu/console.ico" || exit 1