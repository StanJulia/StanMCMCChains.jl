# Top level test script for Stan.jl
using CmdStan, StanMCMCChains, Test, Statistics

println("\nRunning tests for StanMCMCChains-j1.0-v4.0.1:\n")


# Run execution_tests only if cmdstan is installed and CMDSTAN_HOME is set correctly.
execution_tests = [
  "test_m10.4s.jl",
  "test_m12.6sl.jl",
  "test_mcmcchains.jl",
]

if CMDSTAN_HOME != ""
  println("CMDSTAN_HOME set. Try to run tests.")
  @testset "StanMCMCChains.jl" begin

    for my_test in execution_tests
        println("\n\n  * $(my_test) *\n")
        include(my_test)
    end
    
    println("\n")
  end 
else
  println("\n\nCMDSTAN_HOME not set or found.")
  println("Skipping all tests that depend on CmdStan!\n")
end
