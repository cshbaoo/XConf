#!/bin/bash

handler() {
  local dir=$1
  local entry="${dir}/index.ts"

  if [ -e $entry ]; then
    rm -f $entry
  fi

  files=$(ls $dir)
  for f in $files; do
    local filename=${f%.*}
    local ext=${f##*.}

    if [ -d "$dir/$f" -o $ext == 'ts' -o $ext == 'tsx' ]; then
      echo "export * from './${filename}';" >>$entry
    fi

    if [ -d "$dir/$f" ]; then
      handler "$dir/$f"
    fi
  done
}
