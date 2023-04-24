#! /usr/bin/env bash

# Author:       Author
# Date:         March 05 2023 at 03:48:25 AM
# Description:  <>

ext="jpeg"               # file extension of the files you want to rename
format="%07d.$ext"      # output format eg. %02d.png -> 00.png
k=1                     # initial value
for i in *.$ext; do
  new=$(printf $format "$k")
  mv -i -- "$i" "$new"
  let k=k+1
done
