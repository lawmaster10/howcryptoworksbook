# Pandoc with a full TeX Live (xelatex) plus DejaVu fonts.
# DejaVu covers every non-ASCII glyph used in the book
# (arrows, math relations, superscripts, accents, curly quotes).
# Image is published for amd64 only; on arm64 hosts it runs under emulation.
FROM --platform=linux/amd64 pandoc/latex:latest

RUN apk add --no-cache font-dejavu fontconfig \
    && fc-cache -f
