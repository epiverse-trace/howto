# using strategy to make these packages visible to renv
# https://carpentries.github.io/sandpaper/articles/building-with-renv.html#adding-new-packages-to-the-cache
library(cli)
library(downlit)
library(xml2)
# on EpiEstim, 
# prefer the GitHub over the CRAN version
# for weekly estimation