FROM mfisherman/mpich:4.2.3 AS builder

USER root

WORKDIR /app

COPY --chmod=777 ./triton /app/triton

RUN apt-get update && apt-get install -y \
    gdal-bin \
    libgdal-dev \
    python3-gdal

RUN chdir /app/triton/src && mpic++ main.cpp -fopenmp -o /app/triton/build/triton.exe -DACTIVE_OMP -I/usr/include/gdal -L/usr/lib -lgdal
RUN echo 'cd /triton/build && mpirun -np 8 ./triton.exe "$@" ' > /project/triton

FROM mfisherman/mpich:4.2.3 AS runner

USER root

COPY --from=builder /app/triton /triton
COPY --from=builder /project /project

RUN apt-get update && apt-get install -y \
    gdal-bin \
    libgdal-dev \
    python3-gdal

RUN chmod +x /project/triton 
ENV PATH="/project:${PATH}:."
ENV LD_LIBRARY_PATH="/usr/lib:${LD_LIBRARY_PATH}"