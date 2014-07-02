%{
%}

%token <int> NUM
%token PLUS EOF

%start parse
%type <int> parse

%%

parse :
 | expr EOF      { $1 }

expr :
 | NUM           { $1 }
 | expr PLUS NUM { $1 + $3 }

%%

