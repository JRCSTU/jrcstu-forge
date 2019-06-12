# Anaconda's Constructor profiles

The specs are contained in `CO2MPAS/constructor.yaml` file.

```bash
conda create -n cstor constructor=2.3.0
conda activate cstor
constructor ./co2sim --verbose
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
