#!/bin/sh

git config --global user.email ds26gte@gmail.com
git config --global user.name "Dorai Sitaram"

cd docs
git commit -m "committed at $(date)" adocex.html
cd ..

git remote rm origin
#git remote add origin https://${GITHUB_TOKEN}@github.com/ds26gte/curr-reorg >/dev/null 2>&1
#git push origin master --quiet
echo remotely adding origin to regular repo
git remote add origin https://${GITHUB_TOKEN}@github.com/ds26gte/curr-reorg
echo push to regular repo
git push origin master
