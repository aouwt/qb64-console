#!/bin/sh

rm -rf qb64

# Clone the QB64 repository
git clone https://github.com/qb64team/qb64.git --depth=1
cd qb64

# Get rid of GUI components
> ./source/ide/ide_methods.bas
> ./source/ide/ide_global.bas

# Bootstrap
./.ci/bootstrap.sh lnx
./.ci/compile.sh

# Get rid of .git, .github, .ci
rm -rf ./.*

# Copy folder to repo root
cd ..
cp -rf ./qb64/* ./
rm -rf ./qb64
