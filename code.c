#include <stdio.h>

void bubbleSort(int *arr, int n)
{
    for (int i = 0; i < (n - 1); ++i)
    {
        for (int j = (n - 1); j > i; --j)
        {
            if (arr[j - 1] < arr[j])
            {
                int temp = arr[j - 1];
                arr[j - 1] = arr[j];
                arr[j] = temp;
            }
        }
    }
}

static void printArr(FILE *out, int *arr, int n)
{
    for (int i = 0; i < n; ++i)
    {
        fprintf(out, "%d ", arr[i]);
    }
}

static void fillArr(FILE *in, int *arr, int n)
{
    for (int i = 0; i < n; ++i)
    {
        fscanf(in, "%d", &arr[i]);
    }
}

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

