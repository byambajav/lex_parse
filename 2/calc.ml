open Calc_parse

(* token -> string *)
let string_of_token t =
  match t with
    NUM(s) -> Printf.sprintf "NUM(%f)" s
  | PLUS   -> "PLUS"
  | MINUS   -> "MINUS"
  | MUL   -> "MUL"
  | DIV   -> "DIV"
  | EOF    -> "EOF"
  | LEFT_PAR   -> "LEFT_PAR"
  | RIGHT_PAR   -> "RIGHT_PAR"
;;

(* print token t and return it *)
let print_token t =
  Printf.printf "%s\n" (string_of_token t);
  t
;;

(* apply lexer to string s *)
let lex_string s =
  let rec loop b = 
    match print_token (Calc_lex.lex b) with
      EOF -> ()
    | _ -> loop b
  in
  loop (Lexing.from_string s)
;;

(* apply parser to string s; 
   show some info when a parse error happens *)
let parse_string s = 
  let b = Lexing.from_string s in
  try
    parse Calc_lex.lex b			(* main work *)
  with Parsing.Parse_error as exn ->
    (* handle parse error *)
    let c0 = Lexing.lexeme_start b in
    let c1 = Lexing.lexeme_end b in
    Printf.fprintf stderr 
      "error: parse error at char=%d, near token '%s'\n" 
      c0 (String.sub s c0 (c1 - c0));
    raise exn
;;

