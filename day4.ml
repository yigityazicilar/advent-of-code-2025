let list_to_array (l: 'a list) : 'a array  = 
    Array.init (List.length l) (List.nth l)

let read_file (file: string) : char array array =    
    let channel = open_in file in
    let lines = In_channel.input_lines channel in
    close_in channel;
    list_to_array @@ List.map (fun line -> Array.init (String.length line) (String.get line)) lines

let get_adj_roll_count (plan: char array array) (x: int) (y: int) : int = 
    let adj_count = ref 0 in 
    for x' = x - 1 to x + 1 do
        for y' = y - 1 to y + 1 do
            try
                if (x' != x || y' != y) && plan.(x').(y') == '@' then adj_count := !adj_count + 1
            with Invalid_argument _ -> ()
        done
    done;
    !adj_count

let get_removable_rolls (plan: char array array) : (int * int) list =
    let removable_rolls = ref [] in
    Array.iteri (fun x row -> Array.iteri (fun y c -> if c == '@' && get_adj_roll_count plan x y < 4 then removable_rolls := (x, y) :: !removable_rolls) row) plan;
    !removable_rolls

let remove_rolls (removable: (int * int) list) (plan: char array array) =
    List.iter (fun (x, y) -> plan.(x).(y) <- '.') removable

let rec full_removable_roll_count (plan: char array array) : int =
    let removable_rolls = get_removable_rolls plan in
    let removable_count = List.length removable_rolls in
    remove_rolls removable_rolls plan;
    if removable_count != 0 then
        removable_count + full_removable_roll_count plan
    else
        removable_count

let () =
    let floor_plan = read_file Sys.argv.(1) in
    Printf.printf "Day 4 Part 1: %d\n" @@ List.length @@ get_removable_rolls floor_plan;
    Printf.printf "Day 4 Part 2: %d\n" @@ full_removable_roll_count floor_plan

