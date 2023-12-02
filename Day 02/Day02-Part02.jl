global Total = 0

function Trim(string)
    return join(map(x -> isspace(string[x]) ? "" : string[x], 1:length(string)))
end

function Separate(string)
    array = split(string, ":")
    popfirst!(array)

    games = array[1]
    values = split(games, ";")

    return values
end

function Calculator(line)
    global Total

    red = 0
    blue = 0
    green = 0

    results = Separate(line)

    for result in results
        cubes = split(result, ",")
        for cube in cubes 
            if occursin("red", cube)
                value = Trim(replace(cube, "red" => ""))
                if red == 0
                    red = parse(Int64, filter(x->'0'<=x<='9', value))
                elseif red != 0 && red < parse(Int64, filter(x->'0'<=x<='9', value))
                    red = parse(Int64, filter(x->'0'<=x<='9', value))
                end            
            elseif occursin("blue", cube)
                value = Trim(replace(cube, "blue" => ""))
                if blue == 0
                    blue = parse(Int64, filter(x->'0'<=x<='9', value))
                elseif blue != 0 && blue < parse(Int64, filter(x->'0'<=x<='9', value))
                    blue = parse(Int64, filter(x->'0'<=x<='9', value))
                end
            else
                value = Trim(replace(cube, "green" => ""))
                if green == 0
                    green = parse(Int64, filter(x->'0'<=x<='9', value))
                elseif green != 0 && green < parse(Int64, filter(x->'0'<=x<='9', value))
                    green = parse(Int64, filter(x->'0'<=x<='9', value))
                end
            end
        end

    end

    Total = Total + (red * blue * green)

end

while true
    global Total
    input = readline(stdin)
    
    if input == "" || input == nothing
        break;
    end

    Calculator(input)
end

println(Total)