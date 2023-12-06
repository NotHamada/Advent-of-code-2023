struct Item
    Indexes::Array{Int64}
    Line::Int64
    Name::String
end

global Sum = 0
global LineNumber = 1
global ListItems = []
global IntersectItems = []

function ReplaceSymbols(string)
    string = replace(string, "#" => ".")
    string = replace(string, "*" => ".")
    string = replace(string, "%" => ".")
    string = replace(string, "=" => ".")
    string = replace(string, "-" => ".")
    string = replace(string, "/" => ".")
    string = replace(string, "@" => ".")
    string = replace(string, "+" => ".")
    string = replace(string, "&" => ".")
    string = replace(string, '$' => ".")

    return string
end

function ReplaceNumbers(string)
    string = replace(string, "0" => ".")
    string = replace(string, "1" => ".")
    string = replace(string, "2" => ".")
    string = replace(string, "3" => ".")
    string = replace(string, "4" => ".")
    string = replace(string, "5" => ".")
    string = replace(string, "6" => ".")
    string = replace(string, "7" => ".")
    string = replace(string, "8" => ".")
    string = replace(string, "9" => ".")
    string = replace(string, '$' => "*")
    string = replace(string, "#" => "*")
    string = replace(string, "%" => "*")
    string = replace(string, "=" => "*")
    string = replace(string, "-" => "*")
    string = replace(string, "/" => "*")
    string = replace(string, "@" => "*")
    string = replace(string, "+" => "*")
    string = replace(string, "&" => "*")
    return string
end

function GetNumbers(string)
    global LineNumber
    global ListItems

    newString = ReplaceSymbols(string)

    elements = filter!(e -> e != "", split(newString, "."))

    for element in elements
        indexes = []
        for i in findfirst(element, newString)
            push!(indexes, i)
        end
        item = Item(indexes, LineNumber, element)

        push!(ListItems, item)

        array = collect(newString)

        for index in indexes 
            array[index] = '.'
        end

        newString = join(array)
    end
end

function GetSymbols(string)
    global LineNumber
    global ListItems

    newString = ReplaceNumbers(string)

    elements = filter!(e -> e != "", split(newString, "."))

    for element in elements
        indexes = []
        for i in 1:size(findall(element, newString))[1]
            push!(indexes, (findall(element, newString)[i][1] - 1))
            push!(indexes, findall(element, newString)[i][1])
            push!(indexes, (findall(element, newString)[i][1] + 1))
        end
        item = Item(indexes, LineNumber, element)
        push!(ListItems, item)
        elements = filter!(e -> e != element, elements)
    end
end

function Adjacent()
    global IntersectItems
    symbols = filter(s -> s.Name == "*", ListItems)

    for symbol in symbols
        numbers = filter(n -> (n.Name != "*")
                                  && (n.Line == symbol.Line - 1 || n.Line == symbol.Line + 1 || n.Line == symbol.Line)
                                  && (intersect(n.Indexes, symbol.Indexes) != Any[]), ListItems)
        for number in numbers
            push!(IntersectItems, number)
        end

    end
end

function SumItems()
    global IntersectItems
    global Sum

    for number in intersect(IntersectItems, ListItems)
        Sum = Sum + parse(Int64, number.Name)
    end
end

while true
    global LineNumber
    input = readline(stdin)

    if input == "" || input == nothing
        break
    end

    GetNumbers(input)
    GetSymbols(input)

    LineNumber = LineNumber + 1
end

Adjacent()
SumItems()
println(Sum)