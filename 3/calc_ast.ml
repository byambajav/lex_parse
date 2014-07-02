(* abstract syntax tree *)
type expr =
  Num of float
| Par of expr
| Plus of expr * expr
| Minus of expr * expr
| Mul of expr * expr
| Div of expr * expr    
;;
