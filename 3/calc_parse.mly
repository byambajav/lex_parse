%{
%}

%token <int> NUM
%token PLUS EOF

%start parse
%type <Calc_ast.expr> parse

%%

parse :
 | expr EOF      { $1 }

expr :
 | NUM           { Calc_ast.Num $1 }
 | expr PLUS NUM { Calc_ast.Plus($1, Calc_ast.Num $3) }

%%

