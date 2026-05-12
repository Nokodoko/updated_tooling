# --- Context-optimized Claude Code launcher ---
# --disallowedTools removes tool descriptions from the model's context,
# saving ~7.5k tokens (~3.75%) at session start.
# Subagents still get their own full tool sets via their agent definitions.
# Tools removed: WebSearch, WebFetch, NotebookEdit (rarely needed by main orchestrator)
# Chrome (--no-chrome by default): removed via flag, saves ~5.6k tokens
#
# Use 'ccc' or 'claude --chrome' when browser automation is needed.
# Use 'cf' (claude-full) to launch with all tools and no restrictions.

alias c='claude --no-chrome --disallowedTools WebSearch WebFetch NotebookEdit'
alias cs='claude --no-chrome --disallowedTools WebSearch WebFetch NotebookEdit'
alias csb='CLAUDE_CONFIG_DIR=$HOME/.claude-business claude --permission-mode bypassPermissions --no-chrome --disallowedTools WebSearch WebFetch NotebookEdit'
alias ccc='claude --permission-mode bypassPermissions --chrome'
alias csr='claude --resume --permission-mode bypassPermissions --no-chrome --disallowedTools WebSearch WebFetch NotebookEdit'
alias cf='claude'  # claude-full: all tools, no restrictions

# claude-business: isolates entire config dir (creds, projects, memory) for the business OAuth token.
# First run: `cb` then `/login` to populate ~/.claude-business/.credentials.json.
# Personal `c` / `cs` / etc. continue to use ~/.claude/ untouched.
alias cb='CLAUDE_CONFIG_DIR=$HOME/.claude-business claude --no-chrome --disallowedTools WebSearch WebFetch NotebookEdit'
alias cbs='CLAUDE_CONFIG_DIR=$HOME/.claude-business claude --permission-mode bypassPermissions --no-chrome --disallowedTools WebSearch WebFetch NotebookEdit'
alias ccb='CLAUDE_CONFIG_DIR=$HOME/.claude-business claude --permission-mode bypassPermissions --chrome'
alias csrb='CLAUDE_CONFIG_DIR=$HOME/.claude-business claude --resume --permission-mode bypassPermissions --no-chrome --disallowedTools WebSearch WebFetch NotebookEdit'

function ccp() {
  claude -p --no-chrome --disallowedTools WebSearch WebFetch NotebookEdit "$@"
}

function claude_sessions() {
    python ~/programming/python_projects/claude_sessions.py
}

function claude_sessions_business() {
    python ~/programming/python_projects/claude_sessions.py --business
}

function claude_sessions_sidecar() {
    python ~/programming/python_projects/claude_sessions.py --sidecar
}

function claude_delete_session() {
    python ~/programming/python_projects/claude_delete_session.py
}

function ai_floater() {
    python ~/programming/python_projects/claude_sessions_floater.py
}

# claude_quick (uses reduced context)
function cq() {
    local prompt="$*"
    if [ -z "$prompt" ]; then
        echo "Usage: cq <your prompt here>"
        return 1
    fi
    claude --no-chrome --disallowedTools WebSearch WebFetch NotebookEdit "$prompt"
}

# claude with model selector via flisty
function csm() {
    local model
    model=$(printf '%s\n' \
        claude-opus-4-6 \
        claude-sonnet-4-6 \
        claude-haiku-4-5-20251001 \
        gemini-2.5-pro \
        gemini-2.5-flash \
        | flisty 'Claude Code Models')
    [[ -z "$model" ]] && return 1
    claude --permission-mode bypassPermissions --no-chrome \
        --disallowedTools WebSearch WebFetch NotebookEdit \
        --model "$model"
}

function aid(){
    local prompt="/dir_instructions"
    claude -p --verbose --permission-mode bypassPermissions "$prompt"
}

# cms — select model engine + model via terminal lister, then exec claude against it
function cms() {
  emulate -L zsh
  local lister engine model key
  local -a engines=( ollama-monty )
  local -a models

  for cand in tv fzf gum; do
    command -v $cand >/dev/null && lister=$cand && break
  done
  [[ -z $lister ]] && { print -u2 "cms: need tv, fzf, or gum"; return 127 }

  _cms_pick() {  # $1=label, rest=items; prints chosen item or empty on cancel
    local label=$1; shift
    case $lister in
      tv)  tv --inline --no-preview --source-command "printf '%s\n' $*" ;;
      fzf) print -l -- "$@" | fzf --prompt "$label: " ;;
      gum) gum choose "$@" ;;
    esac
  }

  engine=$(_cms_pick engine $engines) || return 130
  [[ -z $engine ]] && return 130

  case $engine in
    ollama-monty)
      key=$(<~/.config/litellm/.master_key)
      curl -fs --max-time 2 http://127.0.0.1:4000/health/liveliness >/dev/null \
        || { print -u2 "cms: litellm proxy at :4000 unreachable (try: systemctl --user start litellm)"; return 5 }
      models=( $(curl -fs --max-time 3 http://monty:11434/api/tags 2>/dev/null \
        | /usr/bin/jq -r '.models[].name' 2>/dev/null \
        | /usr/bin/grep -viE '^(mxbai-embed|nomic-embed|embeddinggemma|all-minilm)|-tools(:|$)' \
        | /usr/bin/sort -u) )
      [[ ${#models} -eq 0 ]] && { print -u2 "cms: monty:11434 unreachable or returned no models"; return 5 }
      model=$(_cms_pick model $models) || return 130
      [[ -z $model ]] && return 130
      export ANTHROPIC_BASE_URL=http://127.0.0.1:4000
      export ANTHROPIC_API_KEY=$key
      export ANTHROPIC_MODEL=$model
      exec claude --model $model --permission-mode bypassPermissions --append-system-prompt "$(cat ~/.config/cms/append-system-prompt.md 2>/dev/null)" "$@"
      ;;
  esac
}
