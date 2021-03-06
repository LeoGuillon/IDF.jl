module IDF

using DataFrames, Random, StatsBase
using Extremes, Distributions

import CSV

include("data.jl")
include("compute.jl")

export 
    
    # loading functions
    load_data, 
    load_station,
    pcp, 
    
    # computation functions
    logL,
    BIC_GEV

end # module
