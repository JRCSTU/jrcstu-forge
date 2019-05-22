# Recipes for co2mpas-dependencies with missing packages

## Instructions
Create and activate a new development environment::

    conda create -n co2dev
    conda activate co2dev

I recommend to use these conda-channels for your dev environment:


```
conda config --env --remove-key channels  conda-forge   # (optional) clean existing keys

conda config --env --append channels  defaults
conda config --env --append channels  conda-forge
conda config --env --append channels  bioconda
conda config --env --prepend channels ankostis
conda config --env --prepend channels local
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
