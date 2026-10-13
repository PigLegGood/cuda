#include <cuda_runtime.h>

// native version,α(A*B)+βC
__global__ void sgemm_naive(
    const float* A, const float* B, float* C,
    int M, int N, int K) {
    
    // 朴素写法每个线程负责一个元素
    int row = blockDim.x * blockIdx.x + threadIdx.x;
    int col = blockDim.y * blockIdx.y + threadIdx.y;

    if (row < M && col < N) {
        float sum = 0.0f;
        for (int k = 0; k < K; ++k) {
            sum += A[row * K + k] * B[k * N + col];  // B 列访问，非合并
        }
        C[row * N + col] = sum;
    }

}

// tiling version
__global__ void sgemm_naive(
    const float* A, const float* B, float* C,
    int M, int N, int K,
    int BM, int BN, int BK ) {

    __shared__ float As[BM][BK];
    __shared__ float Bs[BK][BN];
    
    int tx = threadIdx.x, ty = threadIdx.y;
    int row = blockIdx.y * BM + ty;
    int col = blockIdx.x * BN + tx;
    
    for(int i=0;i<K;i+=BK){
        
    }

}