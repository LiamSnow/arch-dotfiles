#!/bin/bash

html=$(cat html_template.html)

css=$(cat assets/github.css)

html=${html/\$THEME_CSS\$/$css}

echo "$html" > html.html
