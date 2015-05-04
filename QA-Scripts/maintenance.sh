#!/bin/bash
#and3k-sunrise on bitbucket some items for repo maintenance borrowed 

egencache --repo Templar-overlay --update-use-local-desc $@
egencache --repo Templar-overlay --update-manifests --sign-manifests=y $@
