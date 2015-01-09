#include <pthread.h>
#include <stdio.h>
#include <unistd.h>

// This program has a race condition from thread 4

int Global;

void inc_counter() {
    int i = 0;
    while(i < 1) {
    printf("Global %d\n", Global);
        int temp = Global + 1;
    printf("Temp %d\n", temp);

        Global = temp;
    printf("Global %d\n", Global);

        i++;
    }
}

void *Thread1(void *x) {
    printf("Global %d\n", Global);
    inc_counter();
    return NULL;
}

extern "C"
{
    void missed_1(pthread_t *t) {
        pthread_create(&t, NULL, Thread1, NULL);
        return;
    }
}


int main() {
    inc_counter();
    printf("Final Value : %d\n", Global);

    pthread_t t[1];
    missed_1(&t[0]);
    pthread_join(t[0], NULL);

    printf("Final Value : %d\n", Global);
}
