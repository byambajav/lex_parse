%{
%}

%token <int> NUM
%token PLUS EOF

%start parse
%type <My_ast.expr> parse

%%

parse :
 | expr EOF      { $1 }

expr :
 | NUM           { My_ast.Num $1 }
 | expr PLUS NUM { My_ast.Plus($1, My_ast.Num $3) }

%%

