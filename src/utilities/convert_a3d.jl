# convert_a3d

# Function that allows federation by setting the `output_format`  in the Stanmodel().

"""

# convert_a3d

Convert the output file created by cmdstan to the shape of choice. Currently . 

### Method
```julia
convert_a3d(a3d_array, cnames, ::Val{Symbol})
```
### Required arguments
```julia
* `a3d_array::Array{Float64}(n_draws, n_variables, n_chains`      : Read in from output files created by cmdstan                                   
* `cnames::Vector{AbstractString}`                                                 : Monitored variable names
* `::Val{Symbol}`                                                                             : Output format

Method called is based on the output_format defined in the stanmodel, e.g.:

   stanmodel = Stanmodel(num_samples=1200, thin=2, name="bernoulli", 
   model=bernoullimodel, output_format=:array);

Current formats supported are:

1. :array (a3d_array format, the default for CmdStan)
2. :dataFrame (DataFrame)
3. :mambachains (Mamba.Chains object)
4. :mcmcchain (TuringLang/MCMCChain.Chains object)
5. :mcmcchains (TuringLang/MCMCChains.Chains object)

Options 2 through 5 are respectively provided by the packages StanDataFrames, 
StanMamba, StanMCMCChain and StanMCMCChains.

StanJulia v5.x.x packages will use MCMCChains.jl.

See the examples in `examples/m10.4s` and `examples/m12.6sl` for more examples.
```

### Return values
```julia
* `res`                       : Draws converted to the specified format.
```
"""
function convert_a3d(a3d_array, cnames, ::Val{:mcmcchains})
  pi = filter(p -> length(p) > 2 && p[end-1:end] == "__", cnames)
  p = filter(p -> !(p in  pi), cnames)

  MCMCChains.Chains(a3d,
    Symbol.(cnames),
    Dict(
      :parameters => Symbol.(p),
      :internals => Symbol.(pi)
    )
  )
end
