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

:: Conda-install `noarch` packages for which entry-points & menus are needed.
::
set co2progs=
for /R pkgs %%i in (co2*.tar.bz2) do call set co2progs=%%co2progs%% "%%i"
conda install -y %co2progs%
::rmdir /S/Q pkgs/*tar.bz2

:: Syntax in https://github.com/ContinuumIO/menuinst/wiki/Menu-Shortcut-Config-Structure
call :heredoc menuitems >Menu/co2mpas-3.0.0.json && goto menuitems
{
    "menu_name": "CO2MPAS-3.0.0",
    "menu_items":
        [
            {
                "pywscript": "${PREFIX}/Lib/site-packages/co2gui/__main__.py",
                "name": "co2gui",
                "icon": "${MENU_DIR}/CO2MPAS_logo.ico"
            },
            {
                "script": "${PREFIX}/python.exe",
                "scriptarguments": ["-m", "xonsh"],
                "name": "CO2MPAS console",
                "workdir": "${USERPROFILE}",
                "icon": "${MENU_DIR}/xonsh.ico"
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