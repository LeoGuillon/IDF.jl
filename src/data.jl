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
    filename = joinpath(dirname(@__FILE__), "..", "data/stations_data", string(ID, ".csv"))
    if isfile(filename)
        df = CSV.read(filename, DataFrame)

        rename!(df, :Année => :Year)
    
        #on met le tableau sous forme tidy (cf cheat sheet de R)
        df_reshape = stack(df, Not(:Year); variable_name=:Duration, value_name=:Pcp)
        dropmissing!(df_reshape,:Pcp)

        return df_reshape
    end
    error("There is no station with ID $ID")
end

"""
    Pcp

Returns the maximum precipitation of the station with the `ID` code, for the duration `DURATION`, in the form of a vector of float.

The possible durations are : 5 min, 10 min, 15 min, 30 min, 1 h, 2 h, 6 h, 12 h, 24 h

#Examples
```julia-repl
julia> IDF.pcp("701S001", "24 h")
```
"""
function pcp(ID::String, duration::String)::Vector{Float64}
    df = load_station(ID)

    filter!(row -> row[:Duration] == duration, df)

    return df[:, :Pcp]
end
