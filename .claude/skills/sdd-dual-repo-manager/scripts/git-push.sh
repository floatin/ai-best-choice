#!/bin/bash
# 核心同步逻辑：确保双仓一致性

function push_main(commit_message) {
    git commit "feat:"+commit_message
    git push upstream main
    git push origin main
    echo "已将代码分别提交到远端和本地的代码仓."
}