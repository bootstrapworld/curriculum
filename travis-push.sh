#!/bin/sh

git checkout -B travistmp

git config --global user.email "${GH_USER_EMAIL}"
git config --global user.name "${GH_USER_NAME}"

FILES_TO_COMMIT="css html jpg pdf png"

git add index.html README.html asciidoctor.css

for f in $FILES_TO_COMMIT; do
  find distribution -name \*.$f | xargs git add -f
  find . -name .htaccess | xargs git add -f
done

echo Committing to travistmp...

git commit -a -m "committed at $(date)"

echo Pushing to gh-pages...

git push --force "https://${GH_TOKEN}@${GH_REF}" travistmp:gh-pages > /dev/null 2>&1

echo git push --force "https://${GH_TOKEN}@${GH_REF}" travistmp:gh-pages

#echo The whole tree!
#ls -R
