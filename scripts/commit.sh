# Created by Declan Mullen
# Git repository can be found at: https://github.com/declancm/git-commit-script

#!/usr/bin/env bash

if git rev-parse --git-dir > /dev/null 2>&1; then
    gitBranch=$(git rev-parse --abbrev-ref HEAD)
    gitDirectory=$(git rev-parse --show-toplevel)
    cd $gitDirectory
    gitRemote=$(git remote)
    git add .
    wait
    # git commit -a -m "auto commit @ `date -u +'%Y-%m-%d %H:%M:%S'` UTC"
    if [ $# -ne 0 ] && [ -z "$1" ]
    then
        git commit -a -m "Auto Commit: `date -u +'%b %d %H:%M:%S %Y'` UTC"
    else
        git commit -a -m "$1"
    fi
    wait
    git push $gitRemote $gitBranch
    cd $OLDPWD
else
    printf "You are not inside a git repository."
    exit 1
fi
