#include "table.h"
tbb::task_scheduler_init* Table::init_tbb(){
    char *v=getenv("ACA_NUM_THREADS");
    if(v==NULL) thread_limit = 0;
    else thread_limit = atoi(v);
    fprintf(stderr, "Thread limit set to: %u\n", thread_limit);
    if(thread_limit == 0) return new tbb::task_scheduler_init();
    else return new tbb::task_scheduler_init(thread_limit);
}
