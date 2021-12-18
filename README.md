# regardons-ailleurs

- Actu (Fact Checking)
- Dossier
- Analyse (chart)

## website generation

```
hugo --minify
hugo serve
```

## R markdown build
```
./build_rmarkdown_pages.sh
```

## R requirement

```
renv
texlive-bin
texlive-core
texlive-latexextra

# Update magick policy in /etc/ImageMagick-7/policy.xml file
# <policy domain="delegate" rights="read|write" pattern="gs" />
```