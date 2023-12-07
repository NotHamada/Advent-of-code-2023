global Times = []
global Distances = []
global Result = 1

function GetTimes(times)
    global Times

    for time in times
        push!(Times, parse(Int64, time))
    end
end

function GetDistances(distances)
    global Distances

    for distance in distances
        push!(Distances, parse(Int64, distance))
    end
end

function Calculate()
    global Times
    global Distances
    global Result

    winners = []

    for i in 1:size(Times)[1]
        accepted = 0

        time = Times[i]

        for j in 0:time
            travel = (time - j) * (j)

            if travel > Distances[i]
                accepted = accepted + 1
            end
        end
    
        push!(winners, accepted)
    end

    for winner in winners
        Result = Result * winner
    end
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