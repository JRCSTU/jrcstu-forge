::@echo off
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
.\Library\bin\conda install -y %co2progs%

:: Clean packages kept by constructor.yaml: keep_pkgs: true
::rmdir /S/Q pkgs/*.tar.bz2
