"""
    load_data

Load the dataset associated with `name`

# Examples
```julia-repl
julia> IDF.load_data("station_list")
julia> IDF.load_data("mean_pcp")
```
"""
function load_data(name::String)::DataFrame
    filename = joinpath(dirname(@__FILE__), "..", "data", string(name, ".csv"))
    if isfile(filename)
        return CSV.read(filename, DataFrame)
    end
    error("There is no dataframe named $name")
end

"""
    load_station

Load the dataset associated with the station with the `ID` code

#Examples
```julia-repl
julia> IDF.load_station("701S001")
```
"""
function load_station(ID::String)::DataFrame
    load_data("/stations_data/"*ID)
end
