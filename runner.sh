#!/bin/bash

# shellcheck disable=SC2034
previous_path=$(pwd)
# shellcheck disable=SC2164
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
# shellcheck disable=SC2164
cd "$parent_path"
# shellcheck disable=SC2207
# shellcheck disable=SC2006
RUNNER_ENVS=(`env | grep "^RUNNER_" | awk -F '=' '{print $1}' | awk '!/ENTRYPOINT/'`)

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
PURPLE='\033[0;35m'
NC='\033[0m'

for runner_env in ${RUNNER_ENVS[*]}
do
  script_file=$(echo "$runner_env.sh" | tr '[:upper:]' '[:lower:]' | sed "s/runner_//")
  script_enabled=$(printenv "$runner_env")
  # shellcheck disable=SC2001
  short_env=$(echo "$runner_env" | sed "s/RUNNER_//")

  if test -f "$script_file"; then
    if [[ $script_enabled == "1" ]]; then
      echo -e "${YELLOW}[.] $short_env${NC}"

      error_output=$(echo "$short_env.out" | tr '[:upper:]' '[:lower:]')
      rm -f "$error_output"
      cd ..

      # Run script
      bash runner/"$script_file" 2> "runner/$error_output"

      cd - &> /dev/null || exit
      # shellcheck disable=SC2015
      [[ -s "$error_output" ]] &&
      echo -e "${RED}[-] $short_env [Errors]${NC}" ||
      (echo -e "${GREEN}[+] $short_env${NC}")
      cat "$error_output"
      rm -f "$error_output"
    else
      echo -e "${RED}[-] $short_env [Disabled]${NC}"
    fi
  else
    echo -e "${RED}[-] $short_env [Not exist]${NC}"
  fi
done

if [ ${#RUNNER_ENVS[@]} -eq 0 ]; then
  echo -e "${RED}Runners not found${NC}"
fi

entrypoint=$(env | grep "^RUNNER_ENTRYPOINT" | awk -F '=' '{print $1}')

if test -z "$entrypoint"; then
  echo -e "${RED}Entrypoint not found${NC}"
  exit
fi

entrypoint_script=$(printenv "$entrypoint")
# shellcheck disable=SC2001
short_env=$(echo "$entrypoint" | sed "s/RUNNER_//")

echo -e "${PURPLE}[+] $short_env${NC}"

if [[ $(pwd) == *"runner" ]]; then
    cd ..
fi

bash runner/"$entrypoint_script"
