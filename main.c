#include <stdio.h>

extern void bubbleSort(int *arr, int n);
extern static void printArr(FILE *out, int *arr, int n);
extern static void fillArr(FILE *in, int *arr, int n);

int main()
{
    int A[100], B[100];
    int n, i;
    
    FILE *in = fopen("input.txt", "r");
    FILE *out = fopen("output.txt", "w");
    
    fscanf(in, "%d", &n);
    
    fillArr(in, A, n);
    for (i = 0; i < n; ++i)
        B[i] = A[i];
    
    bubbleSort(B, n);
    printArr(out, B, n);
    return 0;
}

