module IDF

using DataFrames, CSV, Random, StatsBase
using Extremes, Distributions

include("compute.jl")
include("data.jl")

export load_data, load_station, BIC_GEV

end # module
