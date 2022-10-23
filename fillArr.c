#include <stdio.h>

static void fillArr(FILE *in, int *arr, int n)
{
    for (int i = 0; i < n; ++i)
    {
        fscanf(in, "%d", &arr[i]);
    }
}
