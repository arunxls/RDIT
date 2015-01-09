#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>

pthread_mutex_t mutexCounter;
int init = 0;

void write_to_file(char *text);
void __arunk_read(void *addr);
void __arunk_write4(void *addr);
void __arunk_write8(void *addr);
void __arunk_write(void *addr);
void __arunk_init();
void __arunk_func_entry(void *call_pc);
void __arunk_func_exit(void *thr);
void __arunk_read4(void *addr);
void __arunk_read8(void *addr);
void __arunk_create(void *t);
void print_thread_id(pthread_t id);

void __arunk_read(void *addr) {
    char str[100] = "read ";
    char address[200];
    sprintf(address, "%p %d", addr, *(int *)addr);
    strcat(str, address);

    write_to_file(str);
}

void __arunk_read4(void *addr) {
    __arunk_read(addr);
}

void __arunk_read8(void *addr) {
    __arunk_read(addr);
}

void __arunk_write4(void *addr) {
    __arunk_write(addr);
}

void __arunk_write8(void *addr) {
    __arunk_write(addr);
}

void __arunk_write(void *addr) {
    char str[100] = "write ";
    char address[200];
    snprintf(address, 199, "%p %d", addr, *(int *)addr);
    strcat(str, address);

    write_to_file(str);

}

void __arunk_set_line_num(void *line) {
    printf("HERE!!\n");
}

void __arunk_func_entry(void *func_name){
    write_to_file("func_entry");
}

void __arunk_func_exit(void *thr){
    write_to_file("func_exit");
}

void __arunk_lock(void *lock) {
    char str[100] = "lock ";
    char address[20];
    sprintf(address, "l%p", lock);
    strcat(str, address);

    write_to_file(str);
}

void __arunk_unlock(void *lock) {
    char str[100] = "unlock ";
    char address[20];
    sprintf(address, "l%p", lock);
    strcat(str, address);

    write_to_file(str);
}

void __arunk_create(void *t) {
    char str[100] = "fork ";
    char address[20];
    sprintf(address, "t%u", (unsigned int)*(pthread_t*)t);
    strcat(str, address);

    write_to_file(str);
}

void __arunk_join(void *t) {
    char str[100] = "join ";
    char address[20];
    sprintf(address, "t%u", (unsigned int)(pthread_t)(int*)t);
    strcat(str, address);

    write_to_file(str);
}

void __arunk_init() {
    if(init == 0) {
        pthread_mutex_init(&mutexCounter,NULL);
        init = 1;
    }
}

void write_to_file(char *text) {
    pthread_mutex_lock(&mutexCounter);
    char filename[] = "test.log";

    FILE *f = fopen(filename, "a");
    if (f == NULL)
    {
        printf("Error opening file!\n");
        exit(1);
    }

    fprintf(f, "t%u %s\n", (unsigned int)pthread_self(), text);
    fclose(f);
    pthread_mutex_unlock (&mutexCounter);
}
