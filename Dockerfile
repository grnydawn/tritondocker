FROM mfisherman/openmpi:4.1.7 AS builder

WORKDIR /app

# build triton, copy data and config files
COPY --chmod=777 ./triton /app/triton

RUN chdir /app/triton/src && mpic++ main.cpp -fopenmp -o /app/triton/build/triton.exe -DACTIVE_OMP

RUN echo "cd /triton/build && mpirun --oversubscribe -np 8 ./triton.exe ./input/cfg/case03_short.cfg " > /project/triton

# Make the script executable

FROM mfisherman/openmpi:4.1.7 AS runner

COPY --from=builder /app/triton /triton
COPY --from=builder /project /project

RUN chmod +x /project/triton 
ENV PATH="/project:${PATH}:."