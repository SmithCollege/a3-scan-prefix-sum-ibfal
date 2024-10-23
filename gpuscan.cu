#include <iostream>
#include <math.h>
#include <sys/time.h>
#define SIZE 128

double get_clock() {
	struct timeval tv; int ok;
	ok = gettimeofday(&tv, (void *) 0);
	if (ok<0) { printf(“gettimeofday error”); }
	return (tv.tv_sec * 1.0 + tv.tv_usec * 1.0E-6);
	}


//kernel funciton for prefix wihtmultiple threads
__gloabl__
void prefixsum(int *in, int *out){
        int xindex= threadIdx.x

        //add up all elements for that speicfic index
        for (int i = 0; i<xindex; i++){
                int val = 0
                for (int j = 0, j<=i; j++){
                        val=inp[j];
                }
                out[xindex]=val;
        }
        return 0;
}

int main(void){
		double t0 = get_clock();
		for (i=0; i<N; i++) times[i] = get_clock();
		double t1 = get_clock();
		printf("time per call: %f ns\n", (1000000000.0*(t1-t0)/N) );
				
        int * input, * output;
        cudaMallocManaged(&input, sizeof(int)*SIZE);
        cudaMallocManaged(&output, sizeof(int)*SIZE);

        //init input array
        for (int i=0; i<SIZE; i++){
                input[i]= 1;
        }
        // call prefixsum
       	double start = get_clock();
        prefixsum<<<1,SIZE>>>(input,output);

        //sync
        cudaDeviceSynchronize();
        
        double end = get_clock()
		printf("start: %f  end: %f", start, end);
        
        printf("%s\n", cudaGetErrorString(cudaGetLastError()));

        //check errors
        float maxError = 0;
        for(int i=0; i<SIZE; i++){
                maxError=fmax(maxError,fabs(output[i]-output[i]));
        }
        std::cout << "Max error: " << maxError << std::endl ;

        cudaFree(input);
        cudaFree(output);
}
