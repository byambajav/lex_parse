%{
%}

%token <float> NUM
%token PLUS MINUS MUL DIV
%token LEFT_PAR RIGHT_PAR
%token EOF

%token <string> VAR
%token LET EQUAL IN

%start parse
%type <Calc_ast.expr> parse

%%

term :
 | NUM                { Calc_ast.Num $1 }
 | MINUS NUM          { Calc_ast.Num (-. $2) }
 | PLUS NUM           { Calc_ast.Num $2 }
 | VAR                { Calc_ast.Var $1 }
 | MINUS VAR          { Calc_ast.Minus(Calc_ast.Num 0., Calc_ast.Var $2) }
 | PLUS VAR           { Calc_ast.Var $2 }
 | term MUL term  { Calc_ast.Mul($1, $3) }
 | term DIV term  { Calc_ast.Div($1, $3) }
 | LEFT_PAR expr RIGHT_PAR { Calc_ast.Par $2 }
     
parse :
 | expr EOF      { $1 }

expr :
 | term           { $1 }
 | expr PLUS term { Calc_ast.Plus($1, $3) }
 | expr MINUS term { Calc_ast.Minus($1, $3) }
 | LET VAR EQUAL expr IN expr { Calc_ast.Let($2, $4, $6) }
    
%%
