(* It's asked to build a module based on string by using the Set module *)
module StringSet = Set.Make (String)

let () =
    let set = List.fold_right StringSet.add ["foo"; "bar"; "baz"; "qux"] StringSet.empty in
    StringSet.iter print_endline set;
    print_endline (StringSet.fold ( ^ ) set "")
