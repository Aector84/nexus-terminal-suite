#!/usr/bin/env bash

ACCESS="nostromo"
GREEN="\033[38;5;34m"
RESET="\033[0m"

center_block() {
  termwidth=$(tput cols)
  blockwidth=62   # hardcoded width of banner
  padding=$(( (termwidth - blockwidth) / 2 ))
  for line in "${BANNER[@]}"; do
    printf "%*s%s\n" "$padding" "" "$line"
  done
}

BANNER=(
"██╗    ██╗███████╗██╗   ██╗██╗      █████╗ ███╗   ██╗██████╗"
"██║    ██║██╔════╝╚██╗ ██╔╝██║     ██╔══██╗████╗  ██║██╔══██╗"
"██║ █╗ ██║█████╗   ╚████╔╝ ██║     ███████║██╔██╗ ██║██║  ██║"
"██║███╗██║██╔══╝    ╚██╔╝  ██║     ██╔══██║██║╚██╗██║██║  ██║"
"╚███╔███╔╝███████╗   ██║   ███████╗██║  ██║██║ ╚████║██████╔╝"
" ╚══╝╚══╝ ╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝ "
)

clear
printf "\033[?25l"
echo
center_block
echo
echo
printf "%*sBIOMETRIC AUTHENTICATION REQUIRED\n" $(( ( $(tput cols) - 34 ) / 2 )) ""
echo
printf "%*sENTER FLEET ACCESS CODE:\n" $(( ( $(tput cols) - 24 ) / 2 )) ""

read -s CODE
echo

if [ "$CODE" != "$ACCESS" ]; then
  echo
  printf "%*sACCESS DENIED\n" $(( ( $(tput cols) - 13 ) / 2 )) ""
  sleep 2
  printf "\033[?25h"
  exit
fi

clear
echo
center_block
echo
printf "%*sWEYLAND-YUTANI FLEET REGISTRY\n" $(( ( $(tput cols) - 30 ) / 2 )) ""
echo
echo
echo

OPTIONS=()

for cmd in fast2 thinkfast weyland1 cmdcentre cmdcentre-bridge stealth stealth2; do
  if command -v "$cmd" &> /dev/null; then
    OPTIONS+=("$cmd")
  fi
done

OPTIONS+=("CLASSIFIED PROJECT")
OPTIONS+=("Exit")

CHOICE=$(printf "%s\n" "${OPTIONS[@]}" | \
fzf --height=40% --layout=reverse --border --prompt="Select Vessel > ")

case "$CHOICE" in
  Exit)
    clear
    ;;
  CLASSIFIED\ PROJECT)
    read -sp "Secondary Clearance Code: " CODE
    echo
    if [[ "$CODE" == "LV426" ]]; then
      weyland1
    else
      echo "Clearance Denied."
      sleep 1.5
    fi
    ;;
  *)
    if command -v "$CHOICE" &> /dev/null; then
      $CHOICE
    fi
    ;;
esac

printf "\033[?25h"

