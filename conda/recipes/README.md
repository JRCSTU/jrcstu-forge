# Recipes for co2mpas-dependencies with missing packages

## Instructions
Ensure that conda is latest, and that *base* env has `conda-build` & `conda-verify` 
(suggested  by conda-build warn).

Create and activate a new development environment::

    # `ripgrep` suggested by conda-build warn for faster prefix-searches.
    conda create -n co2dev ripgrep 
    conda activate co2dev

I recommend to use these conda-channels for your dev environment:


```
# (optional) clean existing keys
conda config --remove-key channels

conda config --append channels  defaults
conda config --append channels  conda-forge
conda config --append channels  bioconda
conda config --prepend channels ankostis
conda config --prepend channels local
```

And verify that you end up with that:


```
conda config --env --get channels

--add channels 'bioconda'   # lowest priority
--add channels 'conda-forge'
--add channels 'defaults'
--add channels 'ankostis'
--add channels 'local'   # highest priority
```

TIP:
    You may assign these channels permanently to your user's configurations, and 
    not having to redo them on each new environment, by removing the `--env` option.

Then build all recipes, pining a recent enough numpy (untested for all but the `co2sim` package):

    conda build recipes/* --numpy '1.15*'


## Build & Upload cross-platform recipes
(VERY ROUGH)

Build any missing recipes in `../recipes` and ensure that all pure-python dependencies
EXIST FOR AT LEAST ONE NON `noarch` architecture, (e.g. `linux-64`), so that
you can use this command, suggested by [this blog](https://medium.com/@Amet13/building-a-cross-platform-python-installer-using-conda-constructor-f91b70d393),
to convert all built packages to all the other architectures:

```bash
cd ${miniconda-dir}
for plat in           linux-32  win-64 win-32  osx-64; do
    conda convert  -f --platform $plat  linux-64/*.tar.bz2
done

for plat in  linux-64 linux-32  win-64 win-32  osx-64; do
    anaconda upload --force $plat/*.tar.bz2
done
```
