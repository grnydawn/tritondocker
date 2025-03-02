FROM mfisherman/mpich:4.2.3 AS builder

WORKDIR /app

COPY --chmod=777 ./triton /app/triton

RUN chdir /app/triton/src && mpic++ main.cpp -fopenmp -o /app/triton/build/triton.exe -DACTIVE_OMP

RUN echo 'cd /triton/build && mpirun -np 8 ./triton.exe "$@" ' > /project/triton

FROM mfisherman/mpich:4.2.3 AS runner

COPY --from=builder /app/triton /triton
COPY --from=builder /project /project

RUN chmod +x /project/triton 
ENV PATH="/project:${PATH}:."