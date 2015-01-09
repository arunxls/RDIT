#include <pthread.h>
#include <stdio.h>
#include <unistd.h>

// This program has no race conditions

int Global;
pthread_mutex_t lock;

void inc_counter() {
    int i = 0;
    while(i < 1) {
        int temp = Global + 1;
        Global = temp;
        i++;
    }
}

void f() {
    inc_counter();
}
extern "C"
{
    void missed_1() {
        pthread_mutex_lock(&lock);
        f();
        pthread_mutex_unlock(&lock);
    }
}


void *Thread1(void *x) {
    missed_1();
    return NULL;
}

int main() {
    pthread_t t[1];
    pthread_mutex_init(&lock, NULL);

    pthread_mutex_lock(&lock);
    pthread_create(&t[0], NULL, Thread1, NULL);
    f();
    pthread_mutex_unlock(&lock);

    pthread_join(t[0], NULL);
    pthread_mutex_destroy(&lock);
    printf("Final Value : %d\n", Global);
}
