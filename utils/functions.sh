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
      aws codecommit create-pull-request --title "$@" --targets repositoryName=$(basename `git remote get-url origin`),sourceReference=$(git rev-parse --abbrev-ref HEAD),destinationReference=develop
    fi

}




