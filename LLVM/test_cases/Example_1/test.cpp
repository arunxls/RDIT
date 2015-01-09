#include <pthread.h>
#include <stdio.h>
#include <unistd.h>

// This program has a race condition

int Global;
pthread_mutex_t lock;

void inc_counter() {
    pthread_mutex_lock(&lock);
    int i = 0;
    while(i < 1) {
        int temp = Global + 1;
        Global = temp;
        i++;
    }
    pthread_mutex_unlock(&lock);
}

void inc_counter_without_lock() {
    int i = 0;
    while(i < 1) {
        int temp = Global + 1;
        Global = temp;
        i++;
    }
}

void *Thread1(void *x) {
    inc_counter_without_lock();
    return NULL;
}


int main() {
    pthread_t t[1];
    pthread_mutex_init(&lock, NULL);

    pthread_create(&t[0], NULL, Thread1, NULL);
    inc_counter_without_lock();

    pthread_join(t[0], NULL);
    pthread_mutex_destroy(&lock);
    printf("Final Value : %d\n", Global);
}
