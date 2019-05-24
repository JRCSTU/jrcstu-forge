for /R pkgs %%i in (co2*.tar.bz2) do (
    echo conda install -y %%i
)
