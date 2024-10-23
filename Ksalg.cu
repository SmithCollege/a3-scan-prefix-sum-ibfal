#include <iostream>
#include <math.h>

#define SIZE 8

//kernel funciton for prefix wihtmultiple threads
__global__ 
void prefixsum(int *in, int *out, int stride){
		int xindex = threadIdx.x;
        //int index = blockIdx.x*blockDim.x+threadIdx.x;
        
        if (xindex >= stride){
  			out[xindex] = in[xindex]+ in[xindex - stride];
  			}		
  			
   		if (xindex < stride){
        	out[xindex]= in[xindex];}
        }

int main(void){
        int *input, *output, *temp, *source, *dest;
        cudaMallocManaged(&input, sizeof(int)*SIZE);
        cudaMallocManaged(&output, sizeof(int)*SIZE);
        //cudaMallocManaged(&temp, sizeof(int)*SIZE);
        //cudaMallocManaged(&dest, sizeof(int)*SIZE);
        //cudaMallocManaged(&source, sizeof(int)*SIZE);

        //init input array
		input[0]= 3;
		input[1]= 1;
		input[2]= 7;
		input[3]= 0;
		input[4]= 4;
		input[5]= 1;
		input[6]= 6;
		input[7]= 3;

		source = &input[0];
		dest = &output[0];
		
        for (int i = 0; i<SIZE; i++){
        		printf("%d ", input[i]);}
        printf("\n");
        
        // call prefixsum
        for (int stride = 1; stride < SIZE; stride*=2){
        	prefixsum<<<1,SIZE>>>(source, dest, stride);
        	temp = dest; 
        	output = source;
        	source = temp ;
		}
	
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
