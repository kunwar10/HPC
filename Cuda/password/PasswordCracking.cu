#include <stdio.h>
#include <cuda_runtime_api.h>
#include <time.h>

__device__ int cracking(char *crack){

   char pwd1[]="MN4970";
   char pwd2[]="KN9469";
   char pwd3[]="SI2065";
   char pwd4[]="XY3960";

   char *m1 = crack;
   char *m2 = crack;
   char *m3 = crack;
   char *m4 = crack;

   char *p1 = pwd1;
   char *p2 = pwd2;
   char *p3 = pwd3;
   char *p4 = pwd4;

   while(*m1 == *p1){
    
       if(*m1 == '\0'){
          return 1;
       }
       m1++;
       p1++;
   }
   
    while(*m2 == *p2){
    
       if(*m2 == '\0'){
          return 1;
       }
       m2++;
       p2++;
   }

    while(*m3 == *p3){
    
       if(*m3 == '\0'){
          return 1;
       }
       m3++;
       p3++;
   }

    while(*m4 == *p4){
    
       if(*m4 == '\0'){
          return 1;
       }
       m4++;
       p4++;
   }
 return 0;
}

__global__ void cracking() {

 
  char word[26] = {'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'};
  

  char numb[10] = {'0','1','2','3','4','5','6','7','8','9'};
  

  char crack[7];
  crack[6] = '\0';
  int m, n, o, p;

     for(m=0;m<10;m++){
      for(n=0; n<10; n++){
       for(o=0; o<10; o++){
        for(p=0; p<10; p++){

        crack[0] = word[blockIdx.x];
        crack[1] = word[threadIdx.x];
        crack[2] = numb[m];
        crack[3] = numb[n];
        crack[4] = numb[o];
        crack[5] = numb[p];

        if(cracking(crack)){
            printf("Password successfully cracked: %s\n", crack);
        }

       }
      }
     }
    }
   }

int time_difference(struct timespec *start, struct timespec *finish, long long int *difference)
 {
     long long int ds =  finish->tv_sec - start->tv_sec;
     long long int dn =  finish->tv_nsec - start->tv_nsec;

     if(dn < 0 )
     {
      ds--;
      dn += 1000000000;
      }

     *difference = ds * 1000000000 + dn;
    return !(*difference > 0);
}


int main(int argc, char *argv[])
{

    struct timespec start, finish;  
    long long int time_elapsed;

    clock_gettime(CLOCK_MONOTONIC, &start);

    cracking <<<26, 26>>>();

    cudaThreadSynchronize();


    clock_gettime(CLOCK_MONOTONIC, &finish);
    time_difference(&start, &finish, &time_elapsed);
     printf("Time elapsed was %lldns or %0.9lfs\n", time_elapsed,
                                           (time_elapsed/1.0e9));
  return 0;
}







