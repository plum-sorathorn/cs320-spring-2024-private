(* Recipes by Ingredients

   Implement a function `recs_by_ingrs` which given

     recs : a list of recipes
     ingrs : a list of ingredients (i.e., strings)

   returns the list of those recipes in `recs` (in the same order)
   whose ingredients are included in `ingrs`.

   You may assume that `ingrs` and `r.ingrs` for every `r` in `recs`
   do not contain duplicates.

   Hint: The function List.mem may be useful.

   Example:
   let r1 = { name = "1" ; ingrs = ["a"; "b"; "d"] }
   let r2 = { name = "2" ; ingrs = ["a"; "c"; "e"] }
   let r3 = { name = "3" ; ingrs = ["b"; "c"] }
   let _ = assert (recs_by_ingrs [r1;r2;r3] ["a";"b";"c";"d"] = [r1;r3])
   let _ = assert (recs_by_ingrs [r1;r2;r3] ["a";"b";"c";"e"] = [r2;r3])

*)

type ingr = string

type recipe = {
  name : string ;
  ingrs : ingr list;
}

let rec apply lst = function
  |  [] -> true 
  | n :: rest -> lst n && apply lst rest;;

let pass_all check =
  let rec pass acc = function
    | [] -> List.rev acc
    | n :: rest -> 
      if (check (n)) then pass (n :: acc) rest
      else pass acc rest
    in pass []

let recs_by_ingrs (l : recipe list) (s : ingr list) : recipe list =
  let is_recipe_included r =
    apply (fun ingr -> List.mem ingr s) r.ingrs
  in pass_all is_recipe_included l;;


let r1 = { name = "1" ; ingrs = ["a"; "b"; "d"] }
let r2 = { name = "2" ; ingrs = ["a"; "c"; "e"] }
let r3 = { name = "3" ; ingrs = ["b"; "c"] }
let _ = assert (recs_by_ingrs [r1;r2;r3] ["a";"b";"c";"d"] = [r1;r3])
let _ = assert (recs_by_ingrs [r1;r2;r3] ["a";"b";"c";"e"] = [r2;r3])