// In Memory Object
...
if(race == true) {
    t1 = last_thread_access;
    t2 = conflicting_thread_access;

    c1 = t1.function_count;
    c2 = t2.function_count;

    if(t1.inFunc) {
        maybe = true;
    } else if(c1 < 2) {
        maybe = false;
    } else if(c1 - func_before == 0) {
        maybe = false;
    } else if(c2 == 0 && ! t2.inFunc) {
        maybe = false;
    } else {
        maybe = true;
    }

    if(maybe == true) {
        func_before = c2;
        check_t = t2;
    }
}
...

//In Engine
...
else if(type.equals("join")) {
    ...
    if(mem.maybe == true) {
        if(mem.check_t.id == thread.id){
            c1 = mem.check_t.function_count;
            c2 = m.func_before;
            if(c1 - c2 != 0) {
                race--;
            }
        }
    }
    ...
}
...

