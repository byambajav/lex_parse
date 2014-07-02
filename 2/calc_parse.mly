%{
%}

%token <float> NUM
%token PLUS MINUS MUL DIV
%token LEFT_PAR RIGHT_PAR
%token EOF

%start parse
%type <float> parse

%%

term :
 | NUM           { $1 }
 | MINUS NUM          { -. $2 }
 | PLUS NUM           { $2 }
 | term MUL term  { $1 *. $3 }
 | term DIV term  { $1 /. $3 }
 | LEFT_PAR expr RIGHT_PAR { $2 }
     
parse :
 | expr EOF      { $1 }

expr :
 | term           { $1 }
 | expr PLUS term { $1 +. $3 }
 | expr MINUS term { $1 -. $3 }

%%

