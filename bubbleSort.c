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

