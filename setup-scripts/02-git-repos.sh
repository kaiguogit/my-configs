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
