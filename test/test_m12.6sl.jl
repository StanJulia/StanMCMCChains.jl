using CmdStan, StanMCMCChains, Test, Statistics

ProjDir = joinpath(dirname(@__FILE__), "..", "examples", "m12.6sl")
cd(ProjDir) do

  isdir("tmp") && rm("tmp", recursive=true);
    
  include("../examples/m12.6sl/m12.6sl.jl")

  @test 1.5 <  mean(m12_6sl.value)< 2.5
    
  isdir("tmp") && rm("tmp", recursive=true);

end # cd
