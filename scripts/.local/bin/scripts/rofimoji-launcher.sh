#!/usr/bin/env bash

dir="$HOME/.config/rofi/launchers/type-1"
theme='style-6'

## Run
rofimoji \
    --action copy \
    --selector \
        rofi --selector-args \
          "-theme ${dir}/${theme}.rasi"
