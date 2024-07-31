#!/usr/bin/env bash
#####################################
# Created by Silent-Mobius AKA Alex M. Schapelle
# Purpose: entry point script for docker containers on jenkins shallow dive course
# Date: 19/11/2022
# Version: 0.2.291
set -x
set -o errexit
set -o pipefail
####################################
. /etc/os-release
PROJECT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SEPERATOR='-------------------------'


function main(){

  note "[+] Starting System provision"
  docker_install
  docker_image_build

  # printf "\n%s \n# %s\n %s\n" $SEPERATOR "Installing Docker-Compose " $SEPERATOR
  # sudo curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  # sudo chmod +x /usr/local/bin/docker-compose
  sudo usermod -aG docker ${USER} # need to verify who is the user

  note '[+] Please relogin with "sudo su - $USER" command to gain access to docker group'
}

function note(){
    printf "%s\n# %s\n%s" "$SEPERATOR" "$@" "$SEPERATOR"
}


function docker_install(){
  sudo apt-get update -y
  sudo apt-get install -y \
      apt-transport-https \
      ca-certificates \
      curl \
      gnupg \
      lsb-release
  curl -L get.docker.com | sudo bash 
}

function docker_image_build(){
  sudo docker compose build -f $PROJECT/docker-compose.yml .
}
#####
# Main
#####
main "$@"
