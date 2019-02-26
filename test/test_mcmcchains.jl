using CmdStan, StanMCMCChains, Test, Statistics

ProjDir = joinpath(dirname(@__FILE__), "..", "examples", "mcmcchains")
cd(ProjDir) do

  isdir("tmp") && rm("tmp", recursive=true);
    
  include("../examples/mcmcchains/mcmcchains.jl")

  @test 18.0 <  mean(chn.value) < 22.0
    
  isdir("tmp") && rm("tmp", recursive=true);

end # cd
