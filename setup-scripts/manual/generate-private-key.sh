#!/bin/bash

# https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
ssh-keygen -t rsa -b 4096 -C "kguo@fortinet.com"
ssh-keygen -t ed25519 -C "git@kaiguo.ca"