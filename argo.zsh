function als(){
  argo app list | awk '{print $1}' | awk -F / '{print $2}'| fzf |xargs -I {} $@ {}
}

function argologin (){
  argo login argocd.ops.sbe-vision.com --grpc-web --sso
}


