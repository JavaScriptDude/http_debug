#!/bin/bash
# http_debug()
# [url] full url to site including scheme (http/https)
# [cookie] (-c|--cookie)(opt) Path to cookie file to allow session persistence
# [ua] (-u|--ua)(opt) User agent string
# [secure] (-s|--secure)(opt) Tell curl to ignore certificate errors (eg self-signed certificate)
# [get] (-g|--get)(opt) Use GET instead of HEAD (default)
# [proxy] (-p|--proxy)(opt) Proxy server to use (eg http://<host>:<port>)
# [help] (-h|--help)(opt) Show help

http_debug() { 
  
  # unnamed args
  local uargs=()
  local url=
  # named args
  local help=false
  local cookie=false
  local ua="Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/81.0"
  local timeout=60
  local secure=false
  local http_get=false
  local proxy=
  # other
  local OK=true
  local msg=
  

  while (( $# >= 1 )); do 
      if [[ $1 == -* ]]; then
          case $1 in
          --help|-h|-\?)  help=true;      shift;;
          --cookie|-c)    cookie=$2;      shift 2;;
          --ua|-u)        ua=$2;          shift 2;;
          --secure|-s)    secure=true;    shift;;
          --get|-g)       http_get=true;  shift;;
          --proxy|-x)     proxy=$2;       shift 2;;
          *) msg="Invalid option: $1"; OK=false; help=true; break;;
          esac;
      else
          uargs+=("$1")
          shift
      fi
  done


  if [ "$help" == true ]; then
    echo "http_debug [-c|--cookie <cookie>] [-u|--ua <user-agent>] [-s|--secure] [-h|--help] [-g|--get] [-p|--proxy] <url>" 
    OK=false
    if [ "$msg" != "" ]; then
      echo "    $msg"
    fi
  fi



  if [ ${#uargs[@]} -gt 1 ]; then
      echo "Error: Only one unnamed parameter is allowed."
      help=true
      OK=false
  else
      url=(${uargs[0]})
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

    if [ "$http_get" == true ]; then
      cmd="$cmd -X GET -H 'Cache-Control: no-cache no-store'"
    fi

    if [ "$proxy" != "" ]; then
      cmd="$cmd --proxy $proxy"
    fi
    

    cmd="$cmd -A \"$ua\" \"$url\" 2>&1 | egrep -v '^> |^< |^{|^}|^* TLS|^* AL|^  0' "

    echo "cmd: $cmd"

    bash -c "$cmd "
    
  fi

};
