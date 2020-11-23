#!/bin/sh

[ ! -f "$(which pytest)" ] && {
    sudo pkg install -g py??-pytest py??-testinfra
}

pytest -v test_laptop.py
