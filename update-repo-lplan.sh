# last modified 2025-05-20

TOPDIR=$(pwd)

cd distribution/en-us/lessons

for d in *; do
  if test -d "$d"; then
    mod_lplan="$d/index.adoc-mod"
    repo_pointer="$d/.repodir.txt.kp"
    if test -f "$mod_lplan" -a -f "$repo_pointer"; then
      cp -p "$mod_lplan" $TOPDIR/$(cat $repo_pointer)/index.adoc
    fi
  fi
done
