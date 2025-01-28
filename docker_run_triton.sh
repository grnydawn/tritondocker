mkdir -p output
docker run -v ./output:/triton/build/output:rw triton-gnu sh -c triton