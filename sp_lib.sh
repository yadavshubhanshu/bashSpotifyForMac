#!/bin/bash


#echo "Hello World $@ $#"
function runspotify {
#echo "$@"
osascript <<EOF
    tell application "Spotify"
        $@
    end tell
EOF
}

function play_track {
    #echo ${data}
    while IFS=$',' read -r song artist uri  ; do
        songs+=("${song}")
        artists+=("${artist}")
        uris+=("${uri}")
    done <<< "${data}"
    echo "${uris[@]}"
    length=$(echo ${#songs[@]})
    for (( i = 0; i < ${length}; i++ )); do
        echo "[$(echo "${i}+1"|bc)] ${songs[${i}]} by ${artists[${i}]}"
    done
    while true; do
        read -p "Enter the song number to play or press q to quit: " number
        if [ "${number}" = "q" ]; then
            break
        elif [ "${number}" -gt 0 ] && [ "${number}" -le ${length} ]; then
            spotifyuri="${uris[$(echo "${number}-1"|bc)]}"
            #echo "the number selected is ${number}"
            #echo "the spotify uri is ${spotifyuri}"
            runspotify play track "\"${spotifyuri}\""
            break
        else
            echo "Select a number between 1 and ${length}"
        fi
    done
}

function song_by_track {
    data=$(curl -X GET "https://api.spotify.com/v1/search?q=track:dead&type=track" \
    -H "Accept: application/json" | ./parse_json.py)
}


function song_by_track_artist {
    data=$(curl -X GET "https://api.spotify.com/v1/search?q=track:"$1"+artist:"$2"&type=track" \
    -H "Accept: application/json" | ./parse_json.py)
    echo "${data}"
    play_track "${data}"
}

#play_track