{
open My_parse
;;
}

rule lex = parse
| [ ' ' '\t' '\n' ]   { lex lexbuf }
| [ '0' - '9' ]+ as s { NUM(int_of_string s) }
| "+"                 { PLUS }
| eof                 { EOF }


