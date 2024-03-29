%{
%}

%token <float> NUM
%token PLUS MINUS MUL DIV
%token LEFT_PAR RIGHT_PAR
%token EOF

%token <string> VAR
%token LET EQUAL IN

%token IF THEN ELSE
%token EQGREATER EQLESS GREATER LESS
%token AND OR 
%token TRUE FALSE 

%start parse
%type <If_ast.expr> parse

%%

term :
 | NUM                { If_ast.Num $1 }
 | MINUS NUM          { If_ast.Num (-. $2) }
 | PLUS NUM           { If_ast.Num $2 }
 | VAR                { If_ast.Var $1 }
 | MINUS VAR        { If_ast.Minus(If_ast.Num 0., If_ast.Var $2) }
 | PLUS VAR           { If_ast.Var $2 }
 | term MUL term      { If_ast.Mul($1, $3) }
 | term DIV term      { If_ast.Div($1, $3) }
 | LEFT_PAR expr RIGHT_PAR { If_ast.Par $2 }

bool_expr :
 | TRUE               { If_ast.True }
 | FALSE              { If_ast.False }
 | expr EQGREATER expr { If_ast.EqGreater($1, $3) }
 | expr EQLESS expr   { If_ast.EqGreater($3, $1) }
 | expr GREATER expr  { If_ast.Greater($1, $3) }
 | expr LESS expr     { If_ast.Greater($3, $1) }
 | bool_expr AND bool_expr { If_ast.And($1, $3) }
 | bool_expr OR bool_expr { If_ast.Or($1, $3) }

parse :
 | expr EOF           { $1 }

expr :
 | term               { $1 }
 | expr PLUS term     { If_ast.Plus($1, $3) }
 | expr MINUS term    { If_ast.Minus($1, $3) }
 | LET VAR EQUAL expr IN expr { If_ast.Let($2, $4, $6) }
 | IF bool_expr THEN expr ELSE expr { If_ast.If($2, $4, $6) }
    
%%
