struct Item
    Indexes::Array{Int64}
    Line::Int64
    Name::String
end

global Sum = 0
global LineNumber = 1
global ListItems = []

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
    string = replace(string, '$' => "-")
    string = replace(string, "#" => "-")
    string = replace(string, "%" => "-")
    string = replace(string, "=" => "-")
    string = replace(string, "/" => "-")
    string = replace(string, "@" => "-")
    string = replace(string, "+" => "-")
    string = replace(string, "&" => "-")
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
        for i in findfirst(element, newString)
            push!(indexes, i - 1)
            push!(indexes, i)
            push!(indexes, i + 1)
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

function Adjacent()
    global Sum
    symbols = filter(s -> s.Name == "*", ListItems)

    for symbol in symbols
        numbers = filter(n -> (n.Name != "*" && n.Name != "-")
                                  && (n.Line == symbol.Line - 1 || n.Line == symbol.Line + 1 || n.Line == symbol.Line)
                                  && (intersect(n.Indexes, symbol.Indexes) != Any[]), ListItems)
        if size(numbers)[1] == 2
            Sum = Sum + (parse(Int64, numbers[1].Name) * parse(Int64,numbers[2].Name))
        end
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
println(Sum)