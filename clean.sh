docker images | awk '{if($1 == "workspace"){print $3}}' | xargs -I x sudo docker rmi -f x
