nclude <stdio.h>
#include <stdlib.h>
#include <ctype.h>


// Assembly functions
void *make_cabbage();
void shred_cabbage(void *cabbage);

void set_age(void *cabbage, int age);
int get_age(void *cabbage);

void set_name(void *cabbage, const char *name);
const char *get_name(void *cabbage);

void set_vertex(void *cabbage, int i, double x, double y);
double get_vertex_x(void *cabbage, int i);
double get_vertex_y(void *cabbage, int i);

double area(void *cabbage);

/**
 * main()
 * Program main entry point
 */
int main(int argc, char **argv)
{
    void *cabbage = make_cabbage();
    
    set_age(cabbage, 17);
    set_name(cabbage, "Stewart");
    printf("%s the cabbage is %d days old\n", get_name(cabbage), get_age(cabbage));
    
    set_vertex(cabbage, 1, 1.0, -3.2);
    set_vertex(cabbage, 2, 18.2, 0);
    set_vertex(cabbage, 3, 7.9, 5.8);
    
    int i;
    for(i=1; i<=3; i++) {   
        printf("%d: %f %f\n", i, get_vertex_x(cabbage, i), get_vertex_y(cabbage, i));
    }

    printf("Triangle area: %f\n", area(cabbage));
    
    shred_cabbage(cabbage);
    
    return 0;
}
