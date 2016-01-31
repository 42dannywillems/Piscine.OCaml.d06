module type PAIR =
  sig
    val pair : (int * int)
  end

module type VAL =
  sig
    val x : int
  end

module type MAKEPROJECTION =
  functor (Pair : PAIR) -> VAL

module MakeFst : MAKEPROJECTION =
  functor (Pair : PAIR) ->
    struct
      let x = let (a, b) = Pair.pair in a
    end

module MakeSnd : MAKEPROJECTION =
  functor (Pair : PAIR) ->
    struct
      let x = let (a, b) = Pair.pair in b
    end

module Pair : PAIR =
  struct
    let pair = (21, 42)
  end

module Fst : VAL = MakeFst (Pair)
module Snd : VAL = MakeSnd (Pair)

let () =
  Printf.printf "Fst.x = %d, Snd.x = %d\n" Fst.x Snd.x