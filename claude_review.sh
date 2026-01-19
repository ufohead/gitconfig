#!/bin/bash

function cr() {
    # --- 1. 檢查 Git 環境 ---
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        echo "❌ 請在 Git 目錄下執行。"
        return 1
    fi

    # --- 2. 處理參數 ---
    local TARGET_STR=""
    if [ "$#" -eq 0 ]; then
        TARGET_STR="HEAD"
    else
        TARGET_STR="$*"
    fi

    local PROMPT_COMMAND="/review ${TARGET_STR}"
    local PROJECT_NAME=$(basename $(git rev-parse --show-toplevel))
    local FILE_TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
    local TEMP_FILE="/tmp/claude_review_temp.txt"

    # --- [新增功能] 嘗試取得線上 URL (PR 或 Commit) ---
    local ONLINE_URL=""

    # 檢查是否安裝了 GitHub CLI (gh)
    if command -v gh &> /dev/null; then
        # 嘗試 1: 取得當前分支關聯的 PR URL
        ONLINE_URL=$(gh pr view --json url -q .url 2>/dev/null)

        # 嘗試 2: 如果找不到 PR (可能還沒開)，改抓 Commit URL
        if [ -z "$ONLINE_URL" ]; then
             # 取得 Commit Hash
             local COMMIT_HASH=$(git rev-parse HEAD)
             # 取得 Repo URL (移除 .git 結尾)
             local REPO_URL=$(gh repo view --json url -q .url 2>/dev/null)
             if [ -n "$REPO_URL" ]; then
                ONLINE_URL="${REPO_URL}/commit/${COMMIT_HASH}"
             fi
        fi
    fi

    # --- 3. 準備內容 ---
    echo "🚀 正在執行: claude \"$PROMPT_COMMAND\" ..."

    # 寫入標題 (給 Evernote 捷徑抓取用)
    echo "[${PROJECT_NAME}] Review: ${TARGET_STR}" > "$TEMP_FILE"

    # 寫入 Metadata (內文開頭)
    echo "Time: ${FILE_TIMESTAMP}" >> "$TEMP_FILE"
    echo "Target: ${TARGET_STR}" >> "$TEMP_FILE"

    # 如果有抓到 URL，就寫入
    if [ -n "$ONLINE_URL" ]; then
        echo "Link: ${ONLINE_URL}" >> "$TEMP_FILE"
    fi

    echo "----------------------------------------" >> "$TEMP_FILE"
    echo "" >> "$TEMP_FILE"

    # --- 4. 執行 Claude ---
    # 去除顏色碼並追加到暫存檔
    claude "$PROMPT_COMMAND" | sed 's/\x1b\[[0-9;]*m//g' | tee /dev/tty >> "$TEMP_FILE"

    # --- 5. 呼叫 Mac 捷徑 ---
    echo ""
    echo "🐘 正在呼叫捷徑匯入 Evernote..."

    # 傳送給捷徑
    cat "$TEMP_FILE" | shortcuts run "Save to Evernote"

    # --- 6. 清理 ---
    rm "$TEMP_FILE"
    echo "✅ 完成！筆記已建立。"
}
