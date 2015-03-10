#!/bin/bash
#sudo mandb
apropos . | sed 's/ (.*//' | sort -u > ~/.volatile/man_list

