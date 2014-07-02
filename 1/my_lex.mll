{
type token = 
  NUM of int
| FLOAT of float
| PLUS
| EOF
}


let digit = ['0'-'9']
let int = '-'? digit+
let frac = '.' digit*
let exp = ['e' 'E'] ['-' '+']? digit+
let float = '-'? digit+ frac? exp?

rule lex = parse
| [ ' ' '\t' '\n' ]   { lex lexbuf }
| int as s { NUM(int_of_string s) }
| float as s { FLOAT(float_of_string s) }
| "+"                 { PLUS }
| eof                 { EOF }


{

let string_of_token t =
  match t with
    NUM(s) -> Printf.sprintf "NUM(%d)" s
  | FLOAT(s) -> Printf.sprintf "FLOAT(%f)" s
  | PLUS -> "PLUS"
  | EOF -> "EOF"
;;

let print_token t =
  Printf.printf "%s\n" (string_of_token t);
  t
;;

let lex_string s =
  let rec loop b = 
    match print_token (lex b) with
      EOF -> ()
    | _ -> loop b
  in
  loop (Lexing.from_string s)
;;
}
