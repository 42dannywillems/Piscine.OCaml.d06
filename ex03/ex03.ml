module type FIXED =
  sig
    type t
    val of_float    : float -> t
    val of_int      : int   -> t
    val to_float    : t     -> float
    val to_int      : t     -> int
    val to_int      : t     -> string
    val zero        : t
    val one         : t
    val succ        : t -> t
    val pred        : t -> t
    val min         : t -> t -> t
    val max         : t -> t -> t
    val gth         : t -> t -> bool
    val lth         : t -> t -> bool
    val gte         : t -> t -> bool
    val lte         : t -> t -> bool
    val eqp         : t -> t -> bool
    val eqs         : t -> t -> bool
    val add         : t -> t -> t
    val sub         : t -> t -> t
    val mul         : t -> t -> t
    val div         : t -> t -> t
    val foreach     : t -> t -> (t -> unit) -> unit
  end

module type FRACTIONNAL_BITS =
  sig
    val bits : int
  end

module type MAKE =
  functor (Fractionnal_bits : FRACTIONNAL_BITS) ->
    FIXED

(*module Make : MAKE =*)
  (*functor (Fractionnal_bits : FRACTIONNAL_BITS) ->*)
    (*struct*)

module Fixed4 : FIXED = Make (struct let bits = 4 end)
module Fixed8 : FIXED = Make (struct let bits = 8 end)
