GIT_REV=$(git log --pretty=format:'%h' -n 1)
docker images | grep $GIT_REV
if test $? == 0; then
  exit
fi

docker buildx build . --tag workspace:$GIT_REV
