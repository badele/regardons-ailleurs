#!/usr/bin/env bash

find docs -name "*.rmd" -exec rm -rf {} \;
Rscript build_rmarkdown_pages.R