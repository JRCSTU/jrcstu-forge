::@echo off
:: Explicitly move noarch packages into `Lib/site-packages` as a workaround to
:: #86 with lack of `constructor` support for `noarch` packages.
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
.\Library\bin\conda install -y %co2progs%

:: Clean packages kept by constructor.yaml: keep_pkgs: true
:: but keep those conda-installed, needed for the #86 workround, 
:: so that menu-items can be rebuilt if another co2mpas is uninstalled.
md pkgs.new
xcopy /Y /F  pkgs\co2*.tar.bz2 pkgs.new\
xcopy /Y /F pkgs\post_install.bat pkgs.new\
:: Run them in a single pipe or else, 
:: this files gets deleted, and move can't run!
rd /s /q pkgs && move pkgs.new pkgs
