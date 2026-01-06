#!/bin/bash
# 核心同步逻辑：确保双仓一致性
function start_change() {
    git checkout main
    git pull upstream main
    git checkout -b "feature-${CHANGE_ID}"
    git push origin "feature-${CHANGE_ID}"
    push upstream "feature-${CHANGE_ID}"
}

function sync_main() {
    git checkout main
    git pull upstream main
    git push origin main
    echo "Main branch synchronized across both remotes."
}