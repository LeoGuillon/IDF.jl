"""
    BIC_GEV

Compute the BIC of a given vector `Y` under the model of a GEV.
"""
function BIC_GEV(Y::Vector{Float64})
    p = gevfit(y).θ̂
    n = length(Y)

    return 3*log(n) - 2log(logL(Y, p[1], p[2], p[3]))
end
