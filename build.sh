GIT_REV=$(git log --pretty=format:'%h' -n 1)
docker images | grep $GIT_REV
if test $? == 0; then
  exit
fi

# That will untag :latest, but will leave git rev in place.
docker rmi workspace:latest

docker buildx build . -t workspace:$GIT_REV -t workspace:latest
