:: Explicitly move noarch packages into `lib/python?.?/site-packages` as a
:: workaround to [this issue][i86] with lack of `constructor` support for
:: `noarch` packages.
:: From https://github.com/openturns/otconda/blob/master/post_install.sh
::
:: [i86]: https://github.com/conda/constructor/issues/86#issuecomment-330863531
if [[ -e site-packages ]]; then
    COPY /E site-packages/* $PREFIX/lib/python?.?/site-packages/
    RD /S site-packages
fi
