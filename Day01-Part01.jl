global Total = 0

function Regex(line)
    global Total
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