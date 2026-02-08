alias dda='datadog-agent'
ddog_options=(
  "analyze-logs\n"
  "check\n"
  "completion\n"
  "config\n"
  "configcheck\n"
  "diagnose\n"
  "dogstatsd\n"
  "dogstatsd-capture\n"
  "dogstatsd-replay\n"
  "dogstatsd-stats\n"
  "flare\n"
  "health\n"
  "help\n"
  "hostname\n"
  "import\n"
  "integration\n"
  "jmx\n"
  "launch-gui\n"
  "processchecks\n"
  "run\n"
  "secret\n"
  "secret-helper\n"
  "snmp\n"
  "status\n"
  "stop\n"
  "stream-event-platform\n"
  "stream-logs\n"
  "tagger-list\n"
  "version\n"
  "workload-list\n"
)

function dstat(){
  sudo datadog-agent $(echo ${ddog_options[@]} |flist 'Datadog-Agent Subcommands'| sed 's/"//g')
}

  # sudo datadog-agent $(echo ${options[@]} | tr ' ' '\n' | grep 'datadog-agent subcommands')
