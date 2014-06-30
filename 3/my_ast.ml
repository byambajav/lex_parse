(* abstract syntax tree *)
type expr =
  Num of int
| Plus of expr * expr
;;
