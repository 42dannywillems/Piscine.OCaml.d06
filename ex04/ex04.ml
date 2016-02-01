module type VAL =
  sig
    type t
    val add : t -> t -> t
    val mul : t -> t -> t
  end

module type EVALEXPR =
  sig
    type t (* Literals *)
    type expr = Sum of (t * t) | Products of (t * t) | Literals of t
    val eval : expr -> t
  end

module type MAKEEVALEXPR =
  functor (Val : VAL) -> EVALEXPR

module MakeEvalExpr : MAKEEVALEXPR =
  functor (Val : VAL) ->
    struct
      type t = Val.t
      type expr = Sum of (Val.t * Val.t)
                  | Products of (Val.t * Val.t)
                  | Literals of (Val.t)
      let eval v =
        match v with
          | Sum (a, b)      -> Val.add a b
          | Products (a, b) -> Val.mul a b
          | Literals a      -> a
    end

(* Tests *)
module IntVal : VAL =
  struct
    type t = int
    let add = ( + )
    let mul = ( * )
  end

module FloatVal : VAL =
  struct
    type t = float
    let add = ( +. )
    let mul = ( *. )
  end

module StringVal : VAL =
  struct
    type t = string
    let add s1 s2 = if (String.length s1) > (String.length s2) then s1 else s2
    let mul = ( ^ )
  end

module IntEvalExpr : EVALEXPR = MakeEvalExpr (IntVal)
module FloatEvalExpr : EVALEXPR = MakeEvalExpr (FloatVal)
module StringEvalExpr : EVALEXPR = MakeEvalExpr (StringVal)
