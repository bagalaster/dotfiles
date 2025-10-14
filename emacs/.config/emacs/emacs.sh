#!/usr/bin/env zsh

# https://github.com/pierre-rouleau/pel/blob/master/doc/emacs-daemon.rst.txt

socket_file=$(lsof -c Emacs | grep server | tr -s " " | cut -d' ' -f8)
emacs=/Applications/Emacs.app/Contents/MacOS/Emacs
emacsclient=/Applications/Emacs.app/Contents/MacOS/bin-arm64-11/emacsclient

if [[ $socket_file == "" ]]; then
    echo "Starting Emacs Daemon..."
    $emacs --chdir /Users/macbagwell --daemon
fi

$emacsclient -c -n


