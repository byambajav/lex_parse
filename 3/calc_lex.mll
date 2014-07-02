{
open Calc_parse
;;
}

let digit = ['0'-'9']
let frac = '.' digit*
let exp = ['e' 'E'] ['-' '+']? digit+
let float = digit+ frac? exp?

rule lex = parse
| [ ' ' '\t' '\n' ]   { lex lexbuf }
| float as s { NUM(float_of_string s) }
| "+"                 { PLUS }
| "-"                 { MINUS }
| "*"                 { MUL }
| "/"                 { DIV }
| "("                 { LEFT_PAR }
| ")"                 { RIGHT_PAR }
| eof                 { EOF }
