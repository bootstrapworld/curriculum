#!/bin/sh

git checkout -B travistmp

git config --global user.email "${GH_USER_EMAIL}"
git config --global user.name "${GH_USER_NAME}"

FILES_TO_COMMIT="css html jpg pdf png"

git add index.html README.html asciidoctor.css

for f in $FILES_TO_COMMIT; do
  find distribution -name \*.$f | xargs git add -f
done

git commit -a -m "committed at $(date)"

git push --force "https://${GH_TOKEN}@${GH_REF}" travistmp:gh-pages > /dev/null 2>&1

echo The whole tree!
ls -R
