#!/bin/bash
set -ex
mkdir -p builds
rev=$(git rev-parse HEAD | head -c10)
builddir="livegrep-$rev"
mkdir -p "$builddir"
cp -a web doc README.md COPYING "$builddir"
mkdir -p "$builddir/bin"
cp -a $(bazel query '//src/tools/... union //cmd/...' | sed -e s,^/,bazel-bin, -e s,:,/, -e s,/tool-,/,) "$builddir/bin"
tar -czf "builds/$builddir.tgz" "$builddir"
