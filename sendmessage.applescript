on run {targetBuddy, targetMessage}
    tell application "Messages"
        set targetService to 1st service whose service type = Jabber
        set myid to id of targetService
        set myrecipient to buddy targetBuddy of targetService
        set mytext to targetMessage
        send mytext to myrecipient
        -- display dialog myrecipient
    end tell
end run