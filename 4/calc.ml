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
  | VAR(s)   -> Printf.sprintf "VAR(%s)" s
  | LET   -> "LET"
  | EQUAL   -> "EQUAL"
  | IN   -> "IN"
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

open Calc_ast
  
let rec eval_expr e env = (* e は式の構文木 *)
  match e with
    Num(x) -> x
  | Var(x) -> List.assoc x env
  | Par(x) -> eval_expr x env
  | Plus(x, y) -> eval_expr x env +. eval_expr y env
  | Minus(x, y) -> eval_expr x env -. eval_expr y env
  | Mul(x, y) -> eval_expr x env *. eval_expr y env
  | Div(x, y) -> eval_expr x env /. eval_expr y env
  | Let(x, y, z) -> eval_expr z ((x, eval_expr y env)::env)
;;

let eval_string s = (* e は文字列 *)
  let env = [] in
  eval_expr (parse_string s) env
;;
