#!/bin/sh

# Explicitly move noarch packages into `lib/python?.?/site-packages` as a
# workaround to [this issue][i86] with lack of `constructor` support for
# `noarch` packages.
# From https://github.com/openturns/otconda/blob/master/post_install.sh
#
# [i86]: https://github.com/conda/constructor/issues/86#issuecomment-330863531
if [[ -e site-packages ]]; then
    cp -r site-packages/* $PREFIX/lib/python?.?/site-packages
    rm -r site-packages
fi

conda install -y co2*.tar.bz2

## Clean packages kept by constructor.yaml: keep_pkgs: true
#rm -f pkgs/*.tar.bz2