#
# $ make
# $ ./my.top -I _build
#        OCaml version 4.01.0
# # My.test_parse ;;
# - : string -> int = <fun>
# # My.test_lex ;;
# - : string -> unit = <fun>

prog:=calc
srcs:=$(prog)_parse.mly $(prog)_lex.mll $(prog).ml
cmos:=$(prog)_parse.cmo $(prog)_lex.cmo $(prog).cmo

all : $(prog).top

$(prog).top : $(srcs)
	ocamlbuild $(prog).byte
	ocamlmktop -o $(prog).top -I _build $(cmos)

clean :
	rm -rf _build $(prog).top $(prog).byte


