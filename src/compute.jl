"""
    BIC_GEV

Compute the BIC of a given vector `Y` under the model of a GEV.
"""
function BIC_GEV(Y::Vector{Float64})
    p = gevfit(y).θ̂
    n = length(Y)
    k = length(p)

    return k*log(n) - 2loglikelihood(GeneralizedExtremeValue(p[1], exp(p[2]), p[3]), y)
end
