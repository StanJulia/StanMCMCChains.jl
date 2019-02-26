using CmdStan, StanMCMCChains, Test, Statistics

ProjDir = joinpath(dirname(@__FILE__), "..", "examples", "m10_4s")
cd(ProjDir) do

  isdir("tmp") && rm("tmp", recursive=true);
    
  include("../examples/m10.4s/m10.4s.jl")

  @test 0.8 < mean(m10_4s.value[:, :bp, :]) < 0.9
    
  isdir("tmp") && rm("tmp", recursive=true);

end # cd
