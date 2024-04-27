#!/bin/bash

update_tasks() {
    notion_database_id="XXXXXXXXXXXXX"
    url="https://api.notion.com/v1/databases/${notion_database_id}/query"
    token="Bearer XXXXXXXXXXXXXXX"
    
    response=$(curl -s -X POST -H "Authorization: ${token}" -H "Notion-Version: 2022-06-28" -H "Content-Type: application/json" "${url}")
    if [ -n "$(echo "${response}" | jq '.results')" ]; then
        not_started_count=0
        in_progress_count=0
        for row in $(echo "${response}" | jq -r '.results[] | @base64'); do
            status_name=$(echo "${row}" | base64 -d | jq -r '.properties.Status.status.name')
            echo "${status_name}"
            if [ "${status_name}" = "Not started" ]; then
                (( not_started_count++ ))
            elif [ "${status_name}" = "In progress" ]; then
                (( in_progress_count++ ))
            fi
        done
        
        update_discord_channel_title "0000000000000000000" "還有${not_started_count}件事沒人做"
        update_discord_channel_title "0000000000000000000" "${in_progress_count}件事處理中"
    else
        echo "Error: Unable to retrieve data from Notion API."
        return -1  # Error code
    fi
}

test() {
    update_discord_channel_title "0000000000000000000" "Testing"
}

update_discord_channel_title() {
    channel_id="$1"
    new_title="$2"
    url="https://discord.com/api/v10/channels/${channel_id}"
    token="Bot XXXXXXXXXXX.XXXXXX.XXXXXXXXXXXXXXXXXXXXXXXXXX"
    
    response=$(curl -s -X PATCH -H "Authorization: ${token}" -H "Content-Type: application/json" -d "{\"name\": \"${new_title}\"}" "${url}")
    updated_title=$(echo "${response}" | jq -r '.name')
    echo "Channel title updated successfully: ${updated_title}"
}

update_tasks
