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