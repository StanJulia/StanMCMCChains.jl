using CmdStan, StanMCMCChains, Test, Statistics

ProjDir = joinpath(dirname(@__FILE__), "..", "examples", "Bernoulli")
cd(ProjDir) do

  isdir("tmp") && rm("tmp", recursive=true);
    
  include("../examples/m12.6sl/m12.6sl.jl")

  #@test 0.1 <  mean(chains.value[:, 8, :] ) < 0.6
    
  isdir("tmp") && rm("tmp", recursive=true);

end # cd
