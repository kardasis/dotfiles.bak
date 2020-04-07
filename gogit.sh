#! /bin/bash


url_path=$(git remote -v | \
  awk '/git@github.com:/ && /(fetch)/ {print $2}' | \
  awk 'BEGIN  {FS = ":"} {print $2}' | \
  awk '{FS = "."} {print $1}')
full_url=https://github.com/$url_path


open -a "/Applications/Google Chrome.app" $full_url
