#include <stdio.h>
#include <stdlib.h>
#define SIZE 128

int main(){
        //allocate memory                                                                            
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

        //check results                                                                              
        for (int i=0; i<SIZE; i++){
                printf("%d ", output[i]);
        }
        printf("\n");

        //free mem                                                                                   
        free(input);
        free(output);

        return 0;
