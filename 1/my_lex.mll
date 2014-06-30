{
type token = 
  NUM of int
| PLUS
| EOF
}

rule lex = parse
| [ ' ' '\t' '\n' ]   { lex lexbuf }
| [ '0' - '9' ]+ as s { NUM(int_of_string s) }
| "+"                 { PLUS }
| eof                 { EOF }


{

let string_of_token t =
  match t with
    NUM(s) -> Printf.sprintf "NUM(%d)" s
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
