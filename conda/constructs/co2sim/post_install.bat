@echo off
:: Explicitly move noarch packages into `Lib/site-packages` as a workaround to
:: [this issue][i86] with lack of `constructor` support for `noarch` packages.
::
:: From https://github.com/openturns/otconda/blob/master/post_install.bat
:: See also https://github.com/conda/constructor/issues/86#issuecomment-330863531
IF EXIST site-packages (
    echo Move noarch packages
    xcopy /E /Y /Q site-packages\* Lib\site-packages
    rmdir /S/Q site-packages
)

:: Conda-install `noarch` packages for which  entry-points & menus are needed.
::
for %%i in (co2mpas co2dice co2gui) do (
    conda install -y pkgs\%%i
)
conda install pkgs co2mpas %* 
:co2mpas

call :heredoc co2dice >Library/bin/co2dice.bat && goto co2dice
@echo off 
python -m co2dice %* 
:co2dice

call :heredoc co2gui >Library/bin/co2gui.bat && goto co2gui
@echo off 
python -m co2gui %* 
:co2gui

call :heredoc datasync >Library/bin/datasync.bat && goto datasync
@echo off 
python -m co2mpas.datasync %* 
:datasync

:: From https://github.com/ContinuumIO/menuinst/wiki/Menu-Shortcut-Config-Structure
call :heredoc menuitems >Menu/co2mpas.json && goto menuitems
{
    "menu_name": "CO2MPAS",
    "menu_items":
        [
            {
                "pywscript": "${PREFIX}/Lib/site-packages/co2gui/__main__.py",
                "name": "co2gui"
            },
            {
                "pyscript": "${PREFIX}/Lib/site-packages/xonsh/__main__.py",
                "name": "console",
                "workdir": "${USERPROFILE}",
 			},
            {
                "webbrowser": "https://co2mpas.io",
                "name": "co2mpas documentation"
            }
        ]
}
:menuitems

:: Rebuild menu-items
python Lib/_nsis.py mkmenus

:: End of main script
goto :EOF

:: ########################################
:: ## Heredoc function
:: ## From https://stackoverflow.com/a/15032476/548792
:: ########################################
:heredoc <uniqueIDX>
setlocal enabledelayedexpansion
set go=
for /f "delims=" %%A in ('findstr /n "^" "%~f0"') do (
    set "line=%%A" && set "line=!line:*:=!"
    if defined go (if #!line:~1!==#!go::=! (goto :EOF) else echo(!line!)
    if "!line:~0,13!"=="call :heredoc" (
        for /f "tokens=3 delims=>^ " %%i in ("!line!") do (
            if #%%i==#%1 (
                for /f "tokens=2 delims=&" %%I in ("!line!") do (
                    for /f "tokens=2" %%x in ("%%I") do set "go=%%x"
                )
            )
        )
    )
)
goto :EOF