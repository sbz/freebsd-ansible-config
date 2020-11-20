#!/bin/sh

[ ! -f $(which pytest) ] && {
    sudo pkg install -g py??-pytest
}

pytest -v test_laptop.py
