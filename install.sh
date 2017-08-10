#!/bin/bash

# default package manager
pman=apt
install_opt=install

get_pman () {
  echo -n "input package manager : "
  read pman
  echo -n "input install option : "
  read install_opt
  #echo "package manager : $pman"
}

if [ '$(uname)' == 'Darwin' ]; then
  pman=brew
  which $pman || get_pman
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
  pman=apt-get
  which $pman || get_pman
elif [ "$(expr substr $(uname -s) 1 10)" == 'MINGW32_NT' ]; then
  pman=choco
  where $pman || @powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
else
  echo "Your platform ($(uname -a)) is not suported."
  exit 1
fi

# install packages
$pman $install_opt vim

