#! /bin/sh

case "$1" in
    gdb) 
        docker run --rm -v $(pwd):/app -w /app --network host rtsg make qemu-gdb
        break ;;
    *) 
        docker run -t -i --rm -v $(pwd):/app -w /app --network host rtsg make $1 ;;
esac
