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
    p = gevfit(Y).θ̂
    n = length(Y)
    k = length(p)

    return k*log(n) - 2logL(Y, p[1], exp(p[2]), p[3])
end

"""
    solve_gumbel

Returns the scale and mean parameters of a given vector `Y`under the model of a Gumbel law (GEV with shape parameter of 0)
"""
function solve_gumbel(Y::Vector{Float64})
    μ₀ = mean(Y)
    ϕ₀ = log(std(Y))
    p₀ = [μ₀, ϕ₀]
    
    # la fonction objectif, comme on maximise la log_vraisemblance
    # il faut prendre l'oppose car optimize.jl minimise.
    function fobj(p::Vector{Float64})
        return -logL(y, p[1], exp(p[2]), 0.0)
    end
    
    p = p₀
    
    try
        res = optimize(fobj, p₀)
        
         
        if Optim.converged(res)
            p = Optim.minimizer(res)
        else
            @warn "The maximum likelihood algorithm did not find a solution. Maybe try with different initial values or with another method. The returned values are the initial values."
            p = p₀
        end
        
    catch
        println("Error of execution")
    end
   
    return p
end
