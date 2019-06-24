#!/usr/bin/env bash
rm -rf target/zip
mkdir -p target/zip
cp -r target/$1 target/zip
cp -r code-deploy/appspec.yml target/zip
cp -r code-deploy/exec target/zip
sed -i "s/RELEASE_VERSION/$3/g" target/zip/exec/service_after_install.sh
cd target/zip && zip -r ../$2 *
cd ..