global Total = 0

function Substitute(string)
    string = replace(string, "eightwoneight" => "8218")
    string = replace(string, "twoneight" => "218")
    string = replace(string, "sevenineight" => "798")
    string = replace(string, "eightwone" => "821")
    string = replace(string, "oneight" => "18")
    string = replace(string, "twone" => "21")
    string = replace(string, "threeight" => "38")
    string = replace(string, "fiveight" => "58")
    string = replace(string, "sevenine" => "71")
    string = replace(string, "eightwo" => "82")
    string = replace(string, "nineight" => "98")
    string = replace(string, "nine" => "9")
    string = replace(string, "eight" => "8")
    string = replace(string, "seven" => "7")
    string = replace(string, "six" => "6")
    string = replace(string, "five" => "5")
    string = replace(string, "four" => "4")
    string = replace(string, "three" => "3")
    string = replace(string, "two" => "2")
    string = replace(string, "one" => "1")
    
    return string
end

function Regex(input)
    global Total

    line = Substitute(input)

    array = filter(x->'0'<=x<='9', collect(line))
    if(length(array) == 1)
        number = first(array) * first(array)
        Total = Total + parse(Int64, number)
    else

        number = first(array) * last(array)
        Total = Total + parse(Int64, number)
    end
end

while true
    input = readline(stdin)
    
    if input == "" || input == nothing
        break;
    else
        Regex(input)
    end
end

println(Total)