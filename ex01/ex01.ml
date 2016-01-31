module StringHash : (Hashtbl.HashedType with type t = String.t) =
  struct
    type t = String.t
    let equal s1 s2 = (String.compare s1 s2 = 0)
    let hash s =
      let rec hash_loc s index length =
        if index = length then 0
        else
          let tmp = (int_of_float (10.**(float_of_int index))) * Char.code
          (String.get s index) in
          tmp + (hash_loc s (index + 1) length) in
        hash_loc s 0 (String.length s)
  end

module StringHashtbl : (Hashtbl.S with type key = String.t) = Hashtbl.Make (StringHash)

let () =
  let ht = StringHashtbl.create 5 in
  let values = ["Hello"; "world"; "42"; "Ocaml"; "H"] in
  let pairs = List.map (fun s -> (s, String.length s)) values in
  List.iter (fun (k, v) -> StringHashtbl.add ht k v) pairs;
  StringHashtbl.iter (fun k v -> Printf.printf "k = \"%s\", v = %d\n" k v) ht
