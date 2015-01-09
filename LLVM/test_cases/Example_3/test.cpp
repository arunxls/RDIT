#include <pthread.h>
#include <stdio.h>
#include <unistd.h>

int Global;

void inc_counter() {
    int i = 0;
    while(i < 1) {
        int temp = Global + 1;
        Global = temp;
        i++;
    }
}

void *Thread1(void *x) {
    inc_counter();
    return NULL;
}
extern "C"
{
    void missed_1() {
        pthread_t t[1];
        pthread_create(&t[0], NULL, Thread1, NULL);
        pthread_join(t[0], NULL);
        return;
    }
}


int main() {
    inc_counter();
    missed_1();
    // printf("Final Value : %d\n", Global);
}
