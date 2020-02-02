docker build --rm -f "Dockerfile" -t ludwig:latest "."
docker run -it --entrypoint /bin/bash ludwig