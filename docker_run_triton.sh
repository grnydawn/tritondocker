mkdir -p output
docker run -v ./output:/triton/build/output:rw grnydawn/triton-mpich:v1 sh -c "triton input/cfg/case03_short.cfg"