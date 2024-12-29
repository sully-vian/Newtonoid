#!/bin/bash

# Remove all lines containing only ";;" and remove ";;" at the end of lines in ml files of bin and lib directories

find lib bin -type f -name "*.ml" | while read -r file; do
    # Remove lines containing only ";;" and spaces/tabs
    sed -i '/^[[:space:]]*;;[[:space:]]*$/d' "$file"
    # remove ";;" at the end of lines
    sed -i 's/;;$//g' "$file"
done
