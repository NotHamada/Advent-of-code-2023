global Total = 0
global Id = 1

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
    valid = true

    results = Separate(line)

    for result in results 
        red = 12
        green = 13
        blue = 14

        cubes = split(result, ",")
        for cube in cubes 
            if occursin("red", cube)
                value = Trim(replace(cube, "red" => ""))
                red -= parse(Int64,filter(x->'0'<=x<='9', value))
            elseif occursin("blue", cube)
                value = Trim(replace(cube, "blue" => ""))
                blue -= parse(Int64,filter(x->'0'<=x<='9', value))
            else
                value = Trim(replace(cube, "green" => ""))
                green -= parse(Int64,filter(x->'0'<=x<='9', value))
            end
        end

        if red < 0 || blue < 0 || green < 0
            valid = false
            return valid
        end
    end

    return valid
end

while true
    global Id
    global Total
    input = readline(stdin)
    
    if input == "" || input == nothing
        break;
    end

    if Calculator(input)
        Total = Total + Id    
    end

    Id = Id + 1 
end

println(Total)