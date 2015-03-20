#!/bin/bash
#sudo mandb
apropos . | sed 's/ (.*//' | sort -u > ~/.cache/man_list

