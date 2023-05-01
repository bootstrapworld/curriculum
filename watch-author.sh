#!/bin/bash
 
fswatch -or \
    ./lessons ./pathways ./shared ./lib/shared.less \
    -e ".*" \
    -i "\\.adoc$" -i "\\.less$" -i "\\.css$" -i "\\.md$" -i "\\.txt$" -i "\\.shtml$" \
    | xargs -n1 -I{} sh -c "make -j 32 && echo Auto-Rebuild Complete!"
