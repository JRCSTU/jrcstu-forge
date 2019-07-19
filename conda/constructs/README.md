# Anaconda's Constructor profiles

The specs are contained in `CO2MPAS/constructor.yaml` file.

NOTE: As of 19 July 2019, it must run with latest conda & **pre-production "v3" constructor**.
See https://github.com/conda/constructor/issues/257#issuecomment-511442170

Run in WINDOWS:

```bash
conda create -y -n cstor
conda activate cstor
git clone https://github.com/conda/constructor --branch v3
pip install -e constructor
constructor --version   # must be 3.0.0
constructor ./CO2MPAS --conda-exe <conda-downloaded-from-the-link-above> 
```

## Tip:

To experiment with menu-items, run this command from the base-folder of the installed-exe 
and all json files `Menu/` will populate the *Windows* Start-menu items:

    python Lib/_nsis.py mkmenus


## Known Limitations

- When the installation executable is run multiple times with a different target each time,
  (practically installing many co2mpases), the *start-menu* items point the last one (expected).
  But uninstalling anyone of them, removes the *start-menu* items regardless of their target.
  although, all co2mpas installations continue to work fine.
  
  Solution: change to the installation folder and rerun the `./pkgs/post_install.bat` script.
