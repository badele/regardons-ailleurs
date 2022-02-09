#!/usr/bin/env bash

IMGSIZE=2048

# Draw map
Rscript generator/stationnement_genant_villes.R

# Resize image and create montage
mkdir -p /tmp/resized
mogrify -path /tmp/resized -resize ${IMGSIZE}x${IMGSIZE} "/tmp/osm_*"
montage /tmp/resized/osm_* -geometry 2048x2048+2+2 -background "#404040"  /tmp/result.png

# Add title
convert /tmp/result.png -background "#2c2c2c" -fill "#DDDDDD" \
        -pointsize 248 label:'Carte du top 16 des stationnements gênants en France' \
        +swap  -gravity Center -append  /tmp/vigilo.png