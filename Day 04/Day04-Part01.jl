global Sum = 0

function Verify(string)
    global Sum

    numbers = split(pop!(split(string, ":")), "|")

    winning = filter(n -> n != "", numbers[1])
    predict = filter(n -> n != "", numbers[2])

    if size(findall(in(winning), predict))[1] >= 1
        Sum += 2 ^ (size(findall(in(winning), predict))[1] - 1)    
    end
end

while true
    input = readline(stdin)
    
    if input == "" || input == nothing
        break;
    end

    Verify(input)
end

println(Sum)