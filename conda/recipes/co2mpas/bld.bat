if not exist "%PREFIX%\Menu" mkdir "%PREFIX%\Menu"
copy "%RECIPE_DIR%\menu.json" "%PREFIX%\Menu\co2mpas.json"
copy "%RECIPE_DIR%\menu.ico" "%PREFIX%\Menu\co2mpas.ico"

"%PYTHON%" -m pip install . --no-deps --ignore-installed -vv
if errorlevel 1 exit 1