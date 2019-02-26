using Test, Statistics

pdir = joinpath(@__DIR__, "../examples/m12.6sl")
cd(pdir) do

  isdir("tmp") && rm("tmp", recursive=true);
  
  include(joinpath(pdir, "m12.6sl.jl"))

  @test 1.5 <  mean(m12_6sl.value)< 2.5
  
  isdir("tmp") && rm("tmp", recursive=true);

end
