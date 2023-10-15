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
http_debug <url> [-c|--cookie <cookie>] [-u|--ua <user-agent>] [-s|--secure] [-h|--help]
```







