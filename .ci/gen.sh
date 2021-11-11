#!/bin/sh
git clone https://github.com/QB64Team/QB64 --depth=1 --branch=$1; cd QB64
# QB64 errors (for some reason) when you include an empty file when compiling via CLI
echo "" > ./source/ide/ide_methods.bas
echo "" > ./source/ide/ide_global.bas

sed -i 's/\n$CONSOLE/\n$CONSOLE:ONLY/g' ./source/qb64.bas

./.ci/bootstrap.sh lnx
./.ci/compile.sh
rm -rf ./.github ./.ci ./.git
for F in .; do
  cp -rf "$F" "../$F"
done

cd ..
# rm -rf ./QB64 #debug
