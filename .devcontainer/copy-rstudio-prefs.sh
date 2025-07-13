#!/bin/bash

mkdir -p /home/rstudio/.config/rstudio
cp /rstudio-prefs.json /home/rstudio/.config/rstudio/rstudio-prefs.json
chown -R rstudio:rstudio /home/rstudio/.config
