global Time = 0
global Distance = 0
global Result = 0

function GetTimes(times)
    global Time

    Time = parse(Int128, join(times))
end

function GetDistances(distances)
    global Distance

    Distance = parse(Int128, join(distances))
end

function Calculate()
    global Time
    global Distance
    global Result

    min = 0
    max = 0

    for j in 0:Time
        travel = (Time - j) * (j)

        if travel > Distance
           min = j
           max = Time - j
           break
        end
    end

    Result = max - min + 1

end

while true
    input = readline(stdin)

    if input == "" || input == nothing
        break
    end

    type = split(input, ":")[1]
    numbers = filter(s -> s != "", split(split(input, ": ")[2], " "))

    if type == "Time"
        GetTimes(numbers)
    else
        GetDistances(numbers)
    end
end

Calculate()
println(Result)