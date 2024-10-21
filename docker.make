#! /bin/sh
docker run -t -i --rm -v $(pwd):/app -w /app -p 5900:5900 rtsg make $@
