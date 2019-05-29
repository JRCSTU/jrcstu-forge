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
