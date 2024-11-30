#include <stdio.h>

int maximum(int* arr) {

    int max = arr[0];
    int i = 1;
    while (arr[i] != 0) {
        if (arr[i] > max) {
            max = arr[i];
        }
        i++;
    }

    return max;
}

int main() {

    int arr[] = {2, 3, 4, 5, 6, 1, 0};

    int max = maximum(arr);
    printf("Done\n");

    return 0;
}

