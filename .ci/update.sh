#!/bin/sh

rm -rf qb64

# Clone the QB64 repository
git clone https://github.com/qb64team/qb64.git --depth=1 --branch=${{ steps.extract_branch.outputs.branch }}
cd qb64

# Get rid of GUI components
# QB64 errors (for some reason) when you include an empty file when compiling via CLI
echo "" > ./source/ide/ide_methods.bas
echo "" > ./source/ide/ide_global.bas

# Bootstrap
./.ci/bootstrap.sh lnx
./.ci/compile.sh

# Get rid of .git, .github, .ci
rm -rf ./.*

# Copy folder to repo root
cd ..
cp -rf ./qb64/* ./
rm -rf ./qb64
