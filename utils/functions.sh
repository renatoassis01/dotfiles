function docker_deep_clean() {
    echo "Removing exited containers..."
    echo "============================="
    docker ps --filter status=dead --filter status=exited -aq | xargs docker rm -v
    echo ""
    echo "Removing unused images..."
    echo "========================="
    docker images --no-trunc | grep '<none>' | awk '{ print $3 }' | xargs docker rmi
    echo ""
    echo "Removing unused volumes..."
    echo "=========================="
    docker volume ls -qf dangling=true | xargs docker volume rm
    echo ""
    echo "Done."
}

function open-pull-request () {
    
    if [ -z "$1" ]
    then
      echo "title pull request is required"
    else
      title="${@}"
      branch=$(git rev-parse --abbrev-ref HEAD)
      repo=$(basename `git remote get-url origin`)
      result=$(aws codecommit create-pull-request --title "$title" --targets repositoryName="$repo",sourceReference="$branch",destinationReference=develop)
      prid=$(echo $result | jq '.pullRequest.pullRequestId' | bc)
      echo "https://console.aws.amazon.com/codesuite/codecommit/repositories/${repo}/pull-requests/${prid}/changes" 
    fi

}

function remove-bg-image () {
 if [ -z "$1" ]
  then
      echo "path image is required"
  else
  filename=`basename $1`
  result="result_$filename"
  color=$( convert "$1" -format "%[pixel:p{0,0}]" info:- )
  convert "$1" -alpha off -bordercolor $color -border 1 \
    \( +clone -fuzz 30% -fill none -floodfill +0+0 $color \
       -alpha extract -geometry 200% -blur 0x0.5 \
       -morphology erode square:1 -geometry 50% \) \
    -compose CopyOpacity -composite -shave 1 "result_$filename"
    echo -e "save on $(pwd)/$result"
    fi
}


