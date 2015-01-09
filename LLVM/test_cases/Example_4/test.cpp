#include <pthread.h>
#include <stdio.h>
#include <unistd.h>

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

extern "C"
{
    void missed_1() {
        pthread_mutex_lock(&lock);
        return;
    }

    void missed_2() {
        pthread_mutex_unlock(&lock);
        return;
    }
}

void *Thread1(void *x) {
    missed_1();
    inc_counter();
    missed_2();
    return NULL;
}

int main() {
    pthread_mutex_init(&lock, NULL);

    pthread_t t[1];
    pthread_create(&t[0], NULL, Thread1, NULL);

    missed_1();
    inc_counter();
    missed_2();

    pthread_join(t[0], NULL);
    pthread_mutex_destroy(&lock);

    // printf("Final Value : %d\n", Global);
}
