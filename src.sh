http_debug() { 
  
  local uargs=()
  local url=
  local cookie=false
  local ua="Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/81.0"
  local timeout=60
  local secure=false
  local help=false
  
  local OK=true

  while (( $# >= 1 )); do 
      if [[ $1 == -* ]]; then
          case $1 in
          --cookie|-c)
            cookie=$2
            shift 2;;
          --ua|-u) 
            ua=$2
            shift 2;;
          --secure|-s)
            secure=true
            shift;;
          --help|-h|-?)
            help=true
            shift;;
          *) echo "Invalid option: $1"; exit 1;;
          esac;
      else
          uargs+=("$1")
          shift
      fi
  done

  

  if [ ${#uargs[@]} -gt 1 ]; then
      echo "Error: Only one unnamed parameter is allowed."
      help=true
      OK=false
  else
      url=(${uargs[0]})
  fi

  if [ "$help" == true ]; then
    echo "http_debug <url> [-c|--cookie <cookie>] [-u|--ua <user-agent>] [-s|--secure] [-h|--help]"
    OK=false
  fi

  if $OK; then

    # Build up the curl command
    cmd="curl --connect-timeout $timeout"
    if [ "$cookie" != false ]; then
      cmd="$cmd -b $cookie"
    fi
    
    cmd="$cmd -v -I"

    if [ "$secure" != true ]; then
      cmd="$cmd --insecure"
    fi

    echo "$cmd -A \"$ua\" \"$url\" 2>&1 | egrep -v '^> |^< |^{|^}|^* TLS|^* AL|^  0' "

    bash -c "$cmd -A \"$ua\" \"$url\" 2>&1 | egrep -v '^> |^< |^{|^}|^* TLS|^* AL|^  0' "
    
  fi

};
