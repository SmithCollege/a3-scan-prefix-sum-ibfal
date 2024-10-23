#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#define SIZE 128

double get_clock() {
	struct timeval tv; int ok;
	ok = gettimeofday(&tv, (void *) 0);
	if (ok<0) { printf(“gettimeofday error”); }
	return (tv.tv_sec * 1.0 + tv.tv_usec * 1.0E-6);
	}


int main(){
		double t0 = get_clock();
		for (i=0; i<N; i++) times[i] = get_clock();
		double t1 = get_clock();
		printf("time per call: %f ns\n", (1000000000.0*(t1-t0)/N) );
		
        //allocate memory 
        double start = get_clock(); 
                                                                                  
        int* input= malloc(sizeof(int)*SIZE);
        int* output= malloc(sizeof(int)*SIZE);

        //initialize inputs                                                                          
        for (int i=0; i<SIZE; i++){
                input[i] =1;
        }

//dumb alg                                                                                           
        //for (int i=0; i<SIZE; i++){                                                                
                //int value= 0;                                                                      
                //for (int j=0; j<=i; j++){                                                          
                        //value += input[j];                                                         
                //}                                                                                  
                //output[i]=value;                                                                   
        //}  

//smarter alg                                                                                        
        output[0]=input[0];
        for (int i=0; i<SIZE; i++){
                output[i] = input[i]+output[i-1];
        }
		double end = get_clock();
		
        //check results                                                                              
        for (int i=0; i<SIZE; i++){
                printf("%d ", output[i]);
        }
        printf("\n");
        printf("start: %f  end: %f", start, end);

        //free mem                                                                                   
        free(input);
        free(output);

        return 0;
}
