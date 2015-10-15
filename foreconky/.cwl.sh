#!/bin/bash
DIR=$(dirname $(readlink -e $0))

conky -c $DIR/.conky/Theme-component1
conky -c $DIR/.conky/Theme-component2
