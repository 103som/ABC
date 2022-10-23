#include <stdio.h>

static void printArr(FILE *out, int *arr, int n)
{
    for (int i = 0; i < n; ++i)
    {
        fprintf(out, "%d ", arr[i]);
    }
}

