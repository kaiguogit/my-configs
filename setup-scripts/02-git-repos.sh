#!/bin/bash

ssh git@git-van.corp.fortinet.com 2fa_verify

REPO=~/build/fos-ci/fortios-ci
if [ ! -d $REPO/.git ]; then
    mkdir -p $REPO
    git clone git@git-van.corp.fortinet.com:fos/fortios-ci.git $REPO
fi
REPO=~/build/neutrino/neutrino

if [ ! -d $REPO/.git ]; then
    mkdir -p $REPO
    git clone git@git-van.corp.fortinet.com:neutrino/neutrino.git $REPO
fi

REPO=~/build/tapestry/tapestry

if [ ! -d $REPO/.git ]; then
    mkdir -p $REPO
    git clone git@git-van.corp.fortinet.com:neutrino/tapestry.git $REPO
fi

REPO=~/build/devtools
if [ ! -d $REPO/.git ]; then
    git clone "ssh://kguo@gerrit.fortinet.com:29418/devtools" && (cd "devtools" && mkdir -p `git rev-parse --git-dir`/hooks/ && curl -Lo `git rev-parse --git-dir`/hooks/commit-msg https://gerrit.fortinet.com/tools/hooks/commit-msg && chmod +x `git rev-parse --git-dir`/hooks/commit-msg)
fi

