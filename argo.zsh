### ArgoCD Tooling ###

# Login to ArgoCD (SSO via gRPC-web)
function argologin(){
  argo app list --grpc-web &>/dev/null && echo "Already authenticated." && return
  argo login argocd.ops.sbe-vision.com --grpc-web --sso
}

# Interactive app selector: list apps -> fzf -> run command on selection
# Usage: als <command>  (e.g., als argo app get, als argo app sync)
function als(){
  argo app list --grpc-web | awk 'NR>1 {split($1,a,"/"); print a[2]}' | fzf | xargs -I {} "$@" {}
}

# Quick app status check
function argostat(){
  local app="${1:?Usage: argostat <app-name>}"
  argo app get "$app" --grpc-web -o json | jq '{name: .metadata.name, status: .status.sync.status, health: .status.health.status, revision: .status.sync.revision}'
}

# Sync a specific app with prune; fail loudly on timeout
function argosync(){
  local app="${1:?Usage: argosync <app-name>}"
  argo app sync "$app" --grpc-web --prune --timeout 120 || { echo "ERROR: sync failed for $app" >&2; return 1; }
}

# List all apps with sync/health status (table format)
function argolist(){
  argo app list --grpc-web -o json | jq -r '.items[] | [.metadata.name, .status.sync.status, .status.health.status] | @tsv' | column -t -s $'\t' -N "APP,SYNC,HEALTH"
}

# Show recent app history (last 5 revisions, header excluded)
function argohist(){
  local app="${1:?Usage: argohist <app-name>}"
  argo app history "$app" --grpc-web | tail -n +2 | head -5
}

# Diff: show what would change on sync
function argodiff(){
  local app="${1:?Usage: argodiff <app-name>}"
  argo app diff "$app" --grpc-web
}
