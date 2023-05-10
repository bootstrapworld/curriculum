#!/bin/bash
 
# Keep an eye on lessons/, pathways/, shared/, and lib/shared.less
# Rebuild if a file ending in adoc, less, css, md, or txt is modified
fswatch -or \
    ./lessons ./pathways ./shared ./lib/shared.less \
    -e ".*" \
    -i "\\.adoc$" -i "\\.less$" -i "\\.css$" -i "\\.md$" -i "\\.txt$" -i "\\.shtml$" \
    | xargs -n1 -I{} sh -c "make -j 32 && echo Auto-Rebuild Complete!"
