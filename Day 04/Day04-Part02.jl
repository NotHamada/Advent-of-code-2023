using Setfield

global GameNumber = 1
global ListGames = []
global Sum = 0

mutable struct Game
    Copies::Int64
    Line::String
    Number::Int64
end

function GetGames(string)
    global GameNumber
    global ListGames

    line = pop!(split(string, ":"))
    game = Game(0, line, GameNumber)

    push!(ListGames, game)

    GameNumber = GameNumber + 1
end

function GetSum()
    global Sum

    for game in ListGames
        numbers = split(game.Line, "|")

        winning = filter(n -> n != "", split(numbers[1], " "))
        predict = filter(n -> n != "", split(numbers[2], " "))

        if size(findall(in(winning), predict))[1] >= 1
            for number in game.Number + 1:game.Number + size(findall(in(winning), predict))[1]
                newCopy = filter(g -> g.Number == number, ListGames)[1]
                newCopy.Copies = newCopy.Copies + 1
            end
        end

        if game.Copies > 0
            for copy in game.Number + 1:game.Number + size(findall(in(winning), predict))[1]
                newCopy = filter(g -> g.Number == copy, ListGames)[1]
                newCopy.Copies = newCopy.Copies + game.Copies
            end
        end

        Sum = Sum + 1 + game.Copies
    end
end

while true
    global Sum
    input = readline(stdin)

    if input == "" || input == nothing
        break
    end

    GetGames(input)
end

GetSum()

println(Sum)