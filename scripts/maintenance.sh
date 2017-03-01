#!/bin/bash
#and3k-sunrise on bitbucket some items for repo maintenance borrowed 

egencache --repo necromancy --update-use-local-desc $@
egencache --repo necromancy --update-manifests --sign-manifests=y $@
