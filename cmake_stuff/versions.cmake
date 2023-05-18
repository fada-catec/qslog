#################################
## Configuring Project Version ##
#################################

set(VERSION "2.1.1")
string(REGEX MATCHALL "[0-9]" VERSION_PARTS "${VERSION}")
list(GET VERSION_PARTS 0 VERSION_MAJOR)
list(GET VERSION_PARTS 1 VERSION_MINOR)
list(GET VERSION_PARTS 2 VERSION_PATCH)
set(SOVERSION "${VERSION_MAJOR}.${VERSION_MINOR}")
