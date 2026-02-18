center_text() {

  local term_width=$(tput cols)

  local text="$1"



  # Find longest line

  local max=0

  while IFS= read -r line; do

    (( ${#line} > max )) && max=${#line}

  done <<< "$text"



  # Calculate padding

  local padding=$(( (term_width - max) / 2 ))



  # Print centered block

  while IFS= read -r line; do

    printf "%*s%s
" $padding "" "$line"

  done <<< "$text"

}

#!/usr/bin/env bash

# -------- COLORS --------
BLUE="\033[38;5;111m"
WHITE="\033[38;5;245m"
RESET="\033[0m"

# -------- CENTER FUNCTION --------

# -------- DIVIDER --------
divider() {
  printf "%*s\n" "$(tput cols)" "" | tr " " "─"
}

# -------- ASCII LOGO --------
LOGO="
███╗   ██╗███████╗██╗  ██╗██╗   ██╗███████╗
████╗  ██║██╔════╝╚██╗██╔╝██║   ██║██╔════╝
██╔██╗ ██║█████╗   ╚███╔╝ ██║   ██║███████╗
██║╚██╗██║██╔══╝   ██╔██╗ ██║   ██║╚════██║
██║ ╚████║███████╗██╔╝ ██╗╚██████╔╝███████║
╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝
"

# -------- DRAW SCREEN --------
draw_screen() {
  clear
  echo
  echo -e "$BLUE"
  center_text "$LOGO"
  echo -e "$WHITE"
  center_text "Weyland-Yutani Unified Command Interface"
  echo
  divider
  echo

  center_text "1) Fleet Registry"
  center_text "2) Mother Mainframe"
  center_text "3) Command Centre"
  center_text "4) Tactical Bridge"
  center_text "5) Hyperspace"
  center_text "6) Fast2"
  center_text "7) Thinkfast"
  center_text "8) Weyland1"
  center_text "9) Exit"

  echo
  divider
  echo -e "$RESET"
}

# -------- MAIN LOOP --------
while true; do
  draw_screen
  echo
  read -p "Select Option > " choice

  case $choice in
    1) ships ;;
    2) mother ;;
    3) cmdcentre ;;
    4) cmdcentre-bridge ;;
    5) space ;;
    6) fast2 ;;
    7) thinkfast ;;
    8) weyland1 ;;
    9) clear; exit ;;
    *) echo "Invalid option"; sleep 1 ;;
  esac
done
