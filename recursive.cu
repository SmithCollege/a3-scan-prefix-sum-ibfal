#include <iostream>
#include <math.h>
#include <sys/time.h>
#define SIZE 1024

double get_clock() {
	struct timeval tv; int ok;
	ok = gettimeofday(&tv, (void *) 0);
	if (ok<0) {printf("gettimeofday error"); }
	return (tv.tv_sec * 1.0 + tv.tv_usec * 1.0E-6);
	}

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
		int *times;
		cudaMallocManaged(&times, sizeof(double)*SIZE);
		double t0 = get_clock();
		for (int i=0; i<SIZE; i++) 
			times[i] = get_clock();
		double t1 = get_clock();
		printf("time per call: %f ns\n", (1000000000.0*(t1-t0)/SIZE) );
		
        int *input, *output, *temp, *source, *dest;
        cudaMallocManaged(&input, sizeof(int)*SIZE);
        cudaMallocManaged(&output, sizeof(int)*SIZE);

		for (int i = 0; i<SIZE; i++){
			input[i]=1;}

		source = &input[0];
		dest = &output[0];

		
        for (int i = 0; i<SIZE; i++){
        		printf("%d ", input[i]);}
        printf("\n");

        
        double start = get_clock();
        // call prefixsum
        for (int stride = 1; stride < SIZE; stride*=2){
        	prefixsum<<<1,SIZE>>>(source, dest, stride);
        	temp = dest; 
        	output = source;
        	source = temp ;
		}
	
        //sync
        cudaDeviceSynchronize();
        double end = get_clock();
        printf("start: %f  end: %f", start, end);
        
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
