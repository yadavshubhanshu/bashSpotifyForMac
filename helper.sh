#!/bin/bash

function showHelp {
    echo "Usage:"
    echo "${0} <command>"
    echo "Commands:"
    echo
    echo "  play                            # Resume playback where Spotify last left off."
}

function noargs {
    if [ "$1" -gt 1 ]; then
        echo " $2 does not take any arguments."
        echo "Use -h or --help for more info on how to use this."
        exit
    fi
}
