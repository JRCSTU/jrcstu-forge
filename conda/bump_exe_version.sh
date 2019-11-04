#!/bin/bash
#
# Utility to search'n replace the EXE's version in recipes & constructor.
#
# SYNTAX:
#   bump_exe_version.sh <old-version>  <new-version>
#
# TIP:
#   Remember to COMMIT modified files afterwards!
#
# Example: ./bump_exe_version.sh  4.1.5  4.1.6
#

my_dir=`dirname "$0"`
cd "$my_dir"

if [ $# -ne 2 ]; then
    echo "BAD nargs($#)!"
    head -n9 $0 | tail +4 | sed 's/^# \?//'  # Print help from above
    exit -1
fi
old_ver=$1
new_ver=$2

for tfile in recipes/co2exe/*  constructs/CO2MPAS/construct.yaml; do
    if grep -q "$old_ver" "$tfile"; then
        echo "SEDing $tfile..."
        sed -i "s/$old_ver/$new_ver/g"  "$tfile"
    fi
done