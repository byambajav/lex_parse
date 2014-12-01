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
%type <Fun_ast.expr> parse

%%

term :
 | NUM                { Fun_ast.Num $1 }
 | MINUS NUM          { Fun_ast.Num (-. $2) }
 | PLUS NUM           { Fun_ast.Num $2 }
 | VAR                { Fun_ast.Var $1 }
 | MINUS VAR        { Fun_ast.Minus(Fun_ast.Num 0., Fun_ast.Var $2) }
 | PLUS VAR           { Fun_ast.Var $2 }
 | term MUL term      { Fun_ast.Mul($1, $3) }
 | term DIV term      { Fun_ast.Div($1, $3) }
 | LEFT_PAR expr RIGHT_PAR { Fun_ast.Par $2 }

bool_expr :
 | TRUE               { Fun_ast.True }
 | FALSE              { Fun_ast.False }
 | expr EQGREATER expr { Fun_ast.EqGreater($1, $3) }
 | expr EQLESS expr   { Fun_ast.EqGreater($3, $1) }
 | expr GREATER expr  { Fun_ast.Greater($1, $3) }
 | expr LESS expr     { Fun_ast.Greater($3, $1) }
 | bool_expr AND bool_expr { Fun_ast.And($1, $3) }
 | bool_expr OR bool_expr { Fun_ast.Or($1, $3) }

parse :
 | expr EOF           { $1 }

expr :
 | term               { $1 }
 | expr PLUS term     { Fun_ast.Plus($1, $3) }
 | expr MINUS term    { Fun_ast.Minus($1, $3) }
 | LET VAR EQUAL expr IN expr { Fun_ast.Let($2, $4, $6) }
 | IF bool_expr THEN expr ELSE expr { Fun_ast.If($2, $4, $6) }
    
%%
