library(knitr)

files <- list.files(pattern="\\.rmd",recursive=TRUE)
for (filename in files) {
    fmarkdown <- gsub("\\.rmd$",".md",filename)
    figfolder <- gsub("\\.rmd$","/",gsub("content/","",filename))

    cat(paste0("Build ",filename),sep="\n")

    # Configure Markdown
    knitr::opts_chunk$set(
    fig.path=figfolder
    )
    knitr::opts_knit$set(
    base.dir = "static/images/",
    base.url = "/images/"
    )

    # Build markdown
    knit(filename, output=fmarkdown, quiet=TRUE)
}