#!/bin/sh

if [ $# -eq 0 ]; then
    exec "/bin/sh"
else
    exec "$@"
fi
