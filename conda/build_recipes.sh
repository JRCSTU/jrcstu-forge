#!/bin/bash
#
# Needs `conda-build` etc installed. 

my_dir=`dirname "$0"`
cd "$my_dir"

# Exit immediately on errors (make it `set +e` to cancel)
set -e

for pack in recipes/*; do
    echo -e "\n+++ Bulding $pack..."

    ## Due to --skip-existing, it will not build if already in (any) channel.
    #  To force build. bump `build/number` in the respective `meta.yaml`.
    conda build \
        --skip-existing \
        --user $ANACONDA_USER \
        --token $ANACONDA_TOKEN \
        $pack
done
