#!/bin/sh

[ ! `which vim` ] && sudo aptitude install vim
cp -rf .vim* .neocon .unite ~/
