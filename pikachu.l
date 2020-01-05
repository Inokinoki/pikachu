%{
#include <stdlib.h>
#include <stdio.h>
#include "Node.h"
#include "y.tab.h"
%}

%%
[achikpu\-\[\]\,\.]  { return *yytext; }
[\n]                { return END; }
.
%%
/*main() { printf("%d", yylex());}*/
    