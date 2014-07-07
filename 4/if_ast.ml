(* abstract syntax tree *)
type expr =
  Num of float
| Var of string
| Par of expr
| Plus of expr * expr
| Minus of expr * expr
| Mul of expr * expr
| Div of expr * expr
| Let of string * expr * expr
| If of expr * expr * expr
| EqGreater of expr * expr
| Greater of expr * expr
| And of expr * expr
| Or of expr * expr
| True
| False
;;
