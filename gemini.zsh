alias g='gemini'
function gupdate(){
  sudo npm install -g @google/gemini-cli@$1
}

function gadd(){
  gemini extensions install  https://github.com/gemini-cli-extensions/$@
}
