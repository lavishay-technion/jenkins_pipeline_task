## Other than Docker installation, each pipeline requires the following: 
    - pipeline 1 - hunspell
    - pipeline 2 - codespell, shellcheck
    - pipeline 3 - python3-poetry, python3-pytest, python3-dev
    - pipeline 4 - docker, docker-ce, docker-ce-cli, containerd.io, docker-compose, dnf-plugins-core (Rocky), apt-transport-https, ca-certificates, curl,  gnupg, lsb-release

## All scripts are checking the installation status on the workers, and if a package doesn't exist, it will automatically install it
## The installation happens according to the OS - Ubuntu/Alpine/Rocky
