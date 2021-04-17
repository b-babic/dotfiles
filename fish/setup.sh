#!/bin/sh

DIR=$(dirname "$0")
cd "$DIR"

. ../scripts/symlinks.sh

SOURCE="$(realpath .)"
DESTINATION="$(realpath ~/.config/fish)"

ascii_font()
{
  echo '    _____      __            __         ____  '
  echo '   / __(_)____/ /_     _____/ /_  ___  / / /  '
  echo '  / /_/ / ___/ __ \   / ___/ __ \/ _ \/ / /   '
  echo ' / __/ (__  ) / / /  (__  ) / / /  __/ / /    '
  echo '/_/ /_/____/_/ /_/  /____/_/ /_/\___/_/_/     '
  echo '                                              '
  echo '        awesome fish shell setup              '
  echo '                                              '
  echo '                                              '
}

ascii_font

mkdir -p "$DESTINATION/functions"
mkdir -p "$DESTINATION/customs"
mkdir -p "$DESTINATION/completions"
mkdir -p "$DESTINATION/conf.d"

find * -name "*fish*" | while read fn; do
    symlink "$SOURCE/$fn" "$DESTINATION/$fn"
done

clear_broken_symlinks "$DESTINATION"
