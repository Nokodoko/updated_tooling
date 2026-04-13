alias olc='ollama run codellama:latest'
alias ol13='ollama run llama2:13b'
alias ol70='ollama run llama2:70b'
alias ol7='ollama run llama2:7b'
alias oll='ollama run llama2:latest'
alias olu='ollama run llama2-uncensored:latest'

alias ol='ollama ls'

olr(){
  ollama run $(ollama ls | flist 'AIs'| awk '{print $1}')
}

_olp_list(){
  local model_dir disk_avail ram_avail
  if [[ -d /var/lib/ollama ]]; then
    model_dir=/var/lib/ollama
  else
    model_dir=$HOME/.ollama/models
  fi
  disk_avail=$(df -B1 "$model_dir" 2>/dev/null | awk 'NR==2{print $4}')
  ram_avail=$(awk '/MemAvailable/{print $2*1024}' /proc/meminfo)

  _hr(){ local b=$1 s=BKMGTP i=0; while (( b >= 1024 && i < 5 )); do b=$((b/1024)); ((i++)); done; printf "%d%s" "$b" "${s:$i:1}"; }

  local disk_avail_hr=$(_hr "$disk_avail")
  local ram_avail_hr=$(_hr "$ram_avail")

  (
    curl -sf https://ollama.com/api/tags | jq -r '.models[] | "\(.name)\t\(.size)"'
    ollama ls 2>/dev/null | tail -n +2 | awk '{
      sz=$3; unit=$4;
      if(unit~/^GB/) sz=sz*1024*1024*1024;
      else if(unit~/^MB/) sz=sz*1024*1024;
      else if(unit~/^KB/) sz=sz*1024;
      printf "%s\t%.0f\n",$1,sz
    }'
  ) | sort -t$'\t' -k1,1 -u | while IFS=$'\t' read -r name size; do
    local sz=${size:-0}
    local sz_hr=$(_hr "$sz")
    local disk_ok="✓" ram_ok="✓"
    (( sz > disk_avail )) 2>/dev/null && disk_ok="✗"
    (( sz > ram_avail )) 2>/dev/null && ram_ok="✗"
    printf "%s\t%s  disk[%s %s free]  ram[%s %s free]\n" \
      "$name" "$sz_hr" "$disk_ok" "$disk_avail_hr" "$ram_ok" "$ram_avail_hr"
  done
}

olp(){
  local cache=/tmp/.olp-list-$$
  _olp_list > "$cache"
  local selected
  selected=$(tv \
    --source-command="cat $cache" \
    --source-output='{split:\t:0}' \
    --input-prompt="Pull model> " \
    --no-sort)
  rm -f "$cache"
  [[ -z "$selected" ]] && return 0
  echo "Pulling $selected ..."
  ollama pull "$selected"
}
