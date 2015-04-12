#!/bin/bash

DIR="${BASH_SOURCE%/*}"
source "${DIR}/sp_lib.sh"
source "${DIR}/helper.sh"


if [ "${#}" -eq 0 ];then
    showHelp
fi

PLAY=false
ARTIST=false
song=""
artist=""
while [ $# -ge 1 ]; do
    #statements
    case $1 in
        -h|--help)
            noargs "$#" "$1"
            showHelp
            shift
            ;;
        -pp|--playpause) 
            noargs "$#" "$1"
            runspotify playpause
            shift
            ;;
        -q|--quit) 
            noargs "$#" "$1" 
            runspotify quit
            shift
            ;;
        --pause)
            noargs "$#" "$1"
            runspotify pause
            shift
            ;;
        -p|--play)
            if [ -z "$2" ];then
                runspotify play
            fi
            PLAY=true
            ARTIST=false
            shift
            ;;
        -a|--artist)
            shift
            ARTIST=true
            PLAY=false
            ;;
        -n|--next)
            noargs "$#" "$1"
            runspotify next track
            shift
            ;;
        -pr|--previous)
            noargs "$#" "$1"
            runspotify previous track
            shift
            ;;
        -r|--repeat)
            noargs "$#" "$1"
            repeating=$(runspotify repeating)
            if [ "${repeating}" == true ];then
                runspotify set repeating to false
            else
                runspotify set repeating to true
            fi
            repeating=$(runspotify repeating)
            echo "Will spotify now repeat? ${repeating}"
            shift
            ;;
        -v|--volume)
            regex='^[0-9]+$'
            if [[ "$2" =~ $regex ]];then
                runspotify set volume to "$2"
            fi
            if [ "$2" = "up" ];then
                shift
                vol=$(runspotify sound volume)
                if [ -z "$2" ];then
                    newvol=$(echo "${vol}+10"|bc)
                    echo "Volume is now ${newvol}"
                    runspotify set sound volume to "${newvol}"
                elif [[ "$2" =~ $regex ]]; then
                    newvol=$(echo "${vol}+$2"|bc)
                    runspotify set sound volume to "${newvol}"
                    echo "Volume is now ${newvol}"
                    shift
                else
                    echo "Specify only integers with up or keep it empty"
                fi
            fi
            if [ "$2" = "down" ];then
                regex='^[0-9]+$'
                shift
                vol=$(runspotify sound volume)
                if [ -z "$2" ];then
                    newvol=$(echo "${vol}-10"|bc)
                    echo "Volume is now ${newvol}"
                    runspotify set sound volume to "${newvol}"
                elif [[ "$2" =~ $regex ]]; then
                    newvol=$(echo "${vol}-$2"|bc)
                    runspotify set sound volume to "${newvol}"
                    echo "Volume is now ${newvol}"
                    shift
                else
                    echo "Specify only integers with up or keep it empty"
                fi
            fi
            shift
            ;;
        *)
            if [ ${PLAY} == true ];then
                if [ -z "${song}" ];then
                    song="$1"
                else
                    song="${song}+$1"
                fi
            fi
            if [ ${ARTIST} == true ];then
                if [ -z "${artist}" ];then
                    artist="$1"
                else
                    artist="${artist}+$1"
                fi
            fi

            shift
            ;;
    esac
done
if [ ! -z "${song}" ] && [ ! -z "${artist}" ];then
    song_by_track_artist "${song}" "${artist}"
fi
if [ ! -z "${song}" ];then
    song_by_track "${song}"
fi
#echo "${song}"
#echo "${artist}"
#echo "${BASH_SOURCE%/*}"
#echo "${PWD}"