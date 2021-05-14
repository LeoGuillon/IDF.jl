"""
    logL

Compute the log-likelihood of a given vector `Y` under a GEV of parameters μ, σ and ξ
"""
function logL(Y::Vector{Float64}, μ::Float64, σ::Float64, ξ::Float64)
    G = GeneralizedExtremeValue(μ, σ, ξ)
    return loglikelihood(G, Y)
end

"""
    BIC_GEV

Compute the BIC of a given vector `Y` under the model of a GEV.
"""
function BIC_GEV(Y::Vector{Float64})
    p = gevfit(y).θ̂
    n = length(Y)
    k = length(p)

    return k*log(n) - 2logL(Y, p[1], exp(p[2]), p[3])
end
