#include <iostream>
#include <math.h>

#define SIZE 128

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
        int * input, * output;
        cudaMallocManaged(&input, sizeof(int)*SIZE);
        cudaMallocManaged(&output, sizeof(int)*SIZE);

        //init input array
        for (int i=0; i<SIZE; i++){
                input[i]= 1;
        }
        // call prefixsum
        prefixsum<<<1,SIZE>>>(input,output);

        //sync
        cudaDeviceSynchronize();
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
