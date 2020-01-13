%{
#include <stdlib.h>
#include <stdio.h>
#include "Node.h"
#define MAX_MEMORY 300000
#define INNER  0
#define LOOP  1

unsigned static char tab[MAX_MEMORY]; //static, no need to initialize with zero
int pointer;
Node  *parse(int op, Node *prev, Node *next);
void  delete_node(Node *p);
void  yyerror(char *string);
int execute(Node *p);
int  yylex(void);
%}

%union{
    Node *nodePointer;
}
%type <nodePointer> instruction instruction_list
%token END

%%

program:
    'p' 'i' 'k' 'a' 'c' 'h' 'u' '-' '-' instruction_list END  { execute($10); delete_node($10); exit(0); }
    ;
instruction_list:
    instruction     { $$ = $1; }
    |
    instruction_list instruction   { $$ = parse(INNER, $1, $2); }
    ;
instruction:
    'p' 'i'     { $$ = parse('<', NULL, NULL); }
    |
    'c' 'h' 'u'     { $$ = parse('>', NULL, NULL); }
    |
    ','     { $$ = parse(',', NULL, NULL); }
    |
    '.'     { $$ = parse('.', NULL, NULL); }
    |
    'k' 'a'     { $$ = parse('+', NULL, NULL); }
    |
    '-'     { $$ = parse('-', NULL, NULL); }
    |
    '[' instruction_list ']'   { $$ = parse(LOOP, $2, NULL); }
    ;

%%

Node *parse(int op, Node *prev, Node *next) {
    Node *node;
    if ((node = (Node *)malloc(sizeof(Node))) == NULL)
    yyerror("Out of memory.");
    node->op = op;
    node->prev  = prev;
    node->next = next;
    return node;
}
void delete_node(Node *p){
    if (p == NULL)
        return;
    delete_node(p->next);
    delete_node(p->prev);
    free(p);
}

void yyerror(char *string){
    printf("%s\n", string);
}

int execute(Node *p){
    if (p == NULL)
        return 0;
    switch(p->op){
    case '>':
        pointer++;
        if (pointer >= MAX_MEMORY) {
        yyerror("Pointer out of bounds.");
        return -1;
        }
        return 0;
    case '<':
        pointer--;
        if (pointer < 0){
        yyerror("Pointer out of bounds.");
        return -1;
        }
        return 0;
    case '+':
        tab[pointer]++; return 0;
    case '-':
        tab[pointer]--; return 0;
    case '.':
        putchar(tab[pointer]); return 0;
    case ',':
        tab[pointer] = getchar(); return 0;
    case LOOP:
        while (tab[pointer])
        execute(p->prev);
        execute(p->next);
        return 0;
    case INNER:
        execute(p->prev);
        execute(p->next);
        return 0;
    }
    return -1;
}

int main()
{
    pointer = 0;
    yyparse();
}