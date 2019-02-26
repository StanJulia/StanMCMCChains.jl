using StanModels, CmdStan, MCMCChains
gr(size=(500,500));

pdir = @__DIR__
cd(pdir)

howell1 = CSV.read(rel_path("..", "data", "Howell1.csv"), delim=';')
df = convert(DataFrame, howell1);

df2 = filter(row -> row[:age] >= 18, df)
first(df2, 5)

heightsmodel = "
// Inferring a Rate
data {
  int N;
  real<lower=0> h[N];
}
parameters {
  real<lower=0> sigma;
  real<lower=0,upper=250> mu;
}
model {
  // Priors for mu and sigma
  mu ~ normal(178, 20);
  sigma ~ uniform( 0 , 50 );

  // Observed heights
  h ~ normal(mu, sigma);
}
";

stanmodel = Stanmodel(name="heights", model=heightsmodel);

heightsdata = Dict("N" => length(df2[:height]), "h" => df2[:height]);

rc, a3d, cnames = stan(stanmodel, heightsdata, pdir, diagnostics=false,
  CmdStanDir=CMDSTAN_HOME);

pi = filter(p -> length(p) > 2 && p[end-1:end] == "__", cnames)
p = filter(p -> !(p in  pi), cnames)

chn = MCMCChains.Chains(a3d,
  Symbol.(cnames),
  Dict(
    :parameters => Symbol.(p),
    :internals => Symbol.(pi)
  )
)

describe(chn)
describe(chn, section=:internals)
