mkdir -p output
#docker run -v ./output:/triton/build/output:rw triton-gnu:v3 sh -c "triton input/cfg/case01.cfg"
docker run -v ./output:/triton/build/output:rw triton-gnu:v3 sh -c "triton input/cfg/case03_short.cfg"