{
open If_parse
;;
}

let space_char = [' ' '\t' '\n']
let digit = ['0'-'9']
let frac = '.' digit*
let exp = ['e' 'E'] ['-' '+']? digit+
let float = digit+ frac? exp?
let let_expr = "let" space_char
let in_expr = "in" space_char
let var_expr = [ '_' 'a'-'z' 'A'-'Z']+ [ '_' 'a'-'z' 'A'-'Z' '0'-'9']*
let if_expr = "if" space_char
let then_expr = "then" space_char
let else_expr = "else" space_char
  
rule lex = parse
| space_char          { lex lexbuf }
| float as s          { NUM(float_of_string s) }
| "+"                 { PLUS }
| "-"                 { MINUS }
| "*"                 { MUL }
| "/"                 { DIV }
| "("                 { LEFT_PAR }
| ")"                 { RIGHT_PAR }
| "="                 { EQUAL }
| eof                 { EOF }
| let_expr            { LET }
| in_expr             { IN }
| var_expr as s       { VAR(s) }
| if_expr             { IF }
| then_expr           { THEN }
| else_expr           { ELSE }
| "<="                { EQGREATER }
| ">="                { EQLESS }
| "<"                 { GREATER }
| ">"                 { LESS }
| "&&"                { AND }
| "||"                { OR }
| "true" space_char   { TRUE }
| "false" space_char  { FALSE }
