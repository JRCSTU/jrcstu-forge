if not exist "%PREFIX%\Menu" mkdir "%PREFIX%\Menu" && ^
copy "%RECIPE_DIR%\menu.json" "%PREFIX%\Menu\co2exe.json" && ^
copy "%RECIPE_DIR%\menu.ico" "%PREFIX%\Menu\co2wui.ico" && ^
copy "%RECIPE_DIR%\menu.ico" "%PREFIX%\Menu\co2mpas.ico" && ^
copy "%RECIPE_DIR%\www.ico" "%PREFIX%\Menu\www.ico" && ^
copy "%RECIPE_DIR%\folder.ico" "%PREFIX%\Menu\folder.ico" && ^
copy "%RECIPE_DIR%\console.ico" "%PREFIX%\Menu\console.ico" && ^
