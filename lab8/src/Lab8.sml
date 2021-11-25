fun countChar (ch: char) (str: string) : int =
    let
        val str_list : char list = String.explode str
        fun count (ch: char) (l: char list) acc : int =
            case l of
                [] => acc
            |   x::xs =>
                    if x = ch then
                        count ch xs (acc+1)
                    else
                        count ch xs acc;
    in
        count ch str_list 0
    end;

countChar #"a" "lalala";
countChar #"a" "hey";