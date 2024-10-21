#include <iostream>
#include <math.h>

#define SIZE 128

//kernel funciton for prefix wihtmultiple threads
__global__ 
void prefixsum(int *in, int *out){
		__shared__ int dest[SIZE];
		int xindex = threadIdx.x;
        int index = blockIdx.x*blockDim.x+threadIdx.x;
        
		if (index< SIZE){
			dest[xindex]= in[index];
		}

        for (int stride = 1; stride< blockDim.x; stride++){
        	__syncthreads();
			int val; 
        	if (xindex >= stride){
  				val= in[xindex - stride];}
			__syncthreads();
			if (xindex >=stride){
				dest[xindex]+= val;}		
        }
        out[index]= dest[xindex];
        }

int main(void){
        int * input, * output;
        cudaMallocManaged(&input, sizeof(int)*SIZE);
        cudaMallocManaged(&output, sizeof(int)*SIZE);

        //init input array
        for (int i=0; i<SIZE; i++){
                input[i]= 1;
        }

        for (int i = 0; i<SIZE; i++){
        		printf("%d ", input[i]);}
        printf("\n");
        
        // call prefixsum
        prefixsum<<<1,SIZE>>>(input,output);

	
        //sync
        cudaDeviceSynchronize();
        printf("%s\n", cudaGetErrorString(cudaGetLastError()));

		for (int i = 0; i<SIZE; i++){
			printf("%d ", output[i]);}

        //check errors
        float maxError = 0;
       	for(int i=0; i<SIZE; i++){
        	maxError=fmax(maxError,fabs(output[i]-output[i]));
                }
        std::cout << "Max error: " << maxError << std::endl ;
        
        cudaFree(input);
        cudaFree(output);
        
        }
