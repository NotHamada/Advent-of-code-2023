@enum Types begin
    HighCard = 1
    OnePair = 2
    TwoPair = 3
    ThreeOfAKind = 4
    FullHouse = 5
    FourOfAKind = 6
    FiveOfAKind = 7
end

global Ranking = 1
global Labels = ['A', 'K', 'Q', 'J', 'T', '9', '8', '7', '6', '5', '4', '3', '2']
global Groups = []
global Games = []
global Sum = 0

mutable struct Game
    Cards::String
    Value::Int64
    Hand::Types
    Strength::Array{Int64}
end

function GetType(array)
    if size(array)[1] == 5
        return HighCard
    elseif size(array)[1] == 4
        return OnePair
    elseif size(array)[1] == 3
        if filter(a -> a == 3, array) != Any[]
            return ThreeOfAKind
        else
            return TwoPair
        end
    elseif size(array)[1] == 2
        if filter(a -> a == 3, array) != Any[]
            return FullHouse
        else
            return FourOfAKind
        end
    else
        return FiveOfAKind
    end
end

function GetAttributes(hand)
    global Labels
    cards = collect(hand)

    strengths = []

    for card in cards
        push!(strengths, (findfirst(label -> label == card, Labels)))
    end

    equalCards = []

    for i in 1:13
        push!(equalCards, size(filter(s -> s == i, strengths))[1])
    end

    equalCards = filter(e -> e != 0, equalCards)

    return [GetType(equalCards), strengths]
end

function GetGames(string)
    global Games

    values = split(string, " ")

    attributes = GetAttributes(values[1])

    game = Game(values[1], parse(Int64, values[2]), attributes[1], attributes[2])

    push!(Games, game)
end

function OrderGames()
    global Games

    highCards = reverse(sort(filter(g -> g.Hand == HighCard, Games), by=h -> h.Strength))
    onePairs = reverse(sort(filter(g -> g.Hand == OnePair, Games), by=h -> h.Strength))
    twoPairs = reverse(sort(filter(g -> g.Hand == TwoPair, Games), by=h -> h.Strength))
    threeOfAKinds = reverse(sort(filter(g -> g.Hand == ThreeOfAKind, Games), by=h -> h.Strength))
    fullHouses = reverse(sort(filter(g -> g.Hand == FullHouse, Games), by=h -> h.Strength))
    fourOfAKinds = reverse(sort(filter(g -> g.Hand == FourOfAKind, Games), by=h -> h.Strength))
    fiveOfAKinds = reverse(sort(filter(g -> g.Hand == FiveOfAKind, Games), by=h -> h.Strength))
    push!(Groups, highCards)
    push!(Groups, onePairs)
    push!(Groups, twoPairs)
    push!(Groups, threeOfAKinds)
    push!(Groups, fullHouses)
    push!(Groups, fourOfAKinds)
    push!(Groups, fiveOfAKinds)

    Result()
end

function Result()
    global Sum
    global Groups
    global Ranking
    
    for group in Groups
        for item in group
            Sum = Sum + (Ranking * item.Value)
            Ranking = Ranking + 1
        end        
    end
end

while true
    input = readline(stdin)

    if input == "" || input == nothing
        break
    end

    GetGames(input)
end

OrderGames()
println(Sum)