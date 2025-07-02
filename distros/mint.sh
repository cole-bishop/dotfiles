#!/bin/bash
# Run from distro directory

stow -S mint -t $HOME
(cd common && stow -S home -t $HOME)