if [[ $(git rev-parse --abbrev-ref HEAD) == "master" ]]; then
  git checkout demo && git cherry-pick master && git push origin demo && git checkout master
fi
