#include <ncurses.h>
int main(){
    initscr();
    printw("Hello Ncurses!");
    refresh();
    endwin();
    return 0;
}
