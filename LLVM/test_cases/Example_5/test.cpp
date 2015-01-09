#include <pthread.h>
#include <stdio.h>
#include <unistd.h>

int Global;
pthread_mutex_t lock;
int y;

void inc_counter() {
    int i = 0;
    while(i < 1) {
        int temp = Global + 1;
        Global = temp;
        i++;
    }
}
extern "C"
{
    void missed_1() {
        while(y != 11) {}
    }

    void missed_2() {
        y=11;
    }
}


void *Thread1(void *x) {
    missed_1();
    inc_counter();
    return NULL;
}

int main() {
    y = 10;

    inc_counter();
    missed_2();

    pthread_t t[1];
    pthread_create(&t[0], NULL, Thread1, NULL);

    pthread_join(t[0], NULL);
    printf("Final Value : %d\n", Global);
}
