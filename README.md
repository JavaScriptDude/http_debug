# http_debug
Basic bash function for troubleshooting http sites.

# background
When troubleshooting http server certificates, IP addresses, and other functionality (eg redirects), its helpful to have a tool that does not have any caching. 
Regular browser often have internal caches that will get in the way of discrete tests resulting in un-usable results.

# Installation
Simply put the bash function in your `~/.bashrc` file (see `src.sh`)
Restart your console or run `% source ~/.bashrc`

# Usage
```
% http_debug -h
http_debug [-c|--cookie <cookie>] [-u|--ua <user-agent>] [-s|--secure] [-h|--help] [-g|--get] <url>
```
params:
```
# [url] full url to site including scheme (http/https)
# [cookie] (-c|--cookie)(opt) Path to cookie file
# [ua] (-u|--ua)(opt) User agent string
# [secure] (-s|--secure)(opt) Tell curl to ignore certificate errors (eg self-signed certificate)
# [get] (-g|--get)(opt) Use GET instead of HEAD (default)
# [help] (-h|--help)(opt) Show help
```







