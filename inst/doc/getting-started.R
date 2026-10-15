## -----------------------------------------------------------------------------
print(result)
summary(result)
plot(result)


## -----------------------------------------------------------------------------
reticulate::py_config()


## -----------------------------------------------------------------------------
library(rjsf)

jsf_available()


## -----------------------------------------------------------------------------
x <- c(prey, predator)


## -----------------------------------------------------------------------------
rates_lv <- reticulate::py_eval(
  "lambda x, t: [2.0 * x[0], 1.5 * x[1], 0.05 * x[0] * x[1]]"
)


## -----------------------------------------------------------------------------
reactant_lv <- matrix(
  c(
    1, 0,
    0, 1,
    1, 1
  ),
  ncol = 2,
  byrow = TRUE
)

reactant_lv


## -----------------------------------------------------------------------------
product_lv <- matrix(
  c(
    2, 0,
    0, 0,
    0, 2
  ),
  ncol = 2,
  byrow = TRUE
)

product_lv


## -----------------------------------------------------------------------------
result_lv <- jsf_simulate(
  x0 = c(prey = 50, predator = 10),
  rates = rates_lv,
  reactant = reactant_lv,
  product = product_lv,
  do_disc = c(1, 1),
  t_max = 10,
  dt = 0.01,
  switching_threshold = c(30, 30),
  species_names = c("prey", "predator"),
  return_type = "JSFResult"
)


## -----------------------------------------------------------------------------
result_lv


## -----------------------------------------------------------------------------
summary(result_lv)


## -----------------------------------------------------------------------------
plot(result_lv)


## -----------------------------------------------------------------------------
x <- c(S, I, R)


## -----------------------------------------------------------------------------
N <- 1000
beta <- 0.5
gamma <- 0.1


## -----------------------------------------------------------------------------
rates_sir <- reticulate::py_eval(sprintf(
  "lambda x, t: [%f * x[0] * x[1] / %f, %f * x[1]]",
  beta,
  N,
  gamma
))


## -----------------------------------------------------------------------------
reactant_sir <- matrix(
  c(
    1, 1, 0,
    0, 1, 0
  ),
  ncol = 3,
  byrow = TRUE
)

reactant_sir


## -----------------------------------------------------------------------------
product_sir <- matrix(
  c(
    0, 2, 0,
    0, 0, 1
  ),
  ncol = 3,
  byrow = TRUE
)

product_sir


## -----------------------------------------------------------------------------
result_sir <- jsf_simulate(
  x0 = c(S = N - 10, I = 10, R = 0),
  rates = rates_sir,
  reactant = reactant_sir,
  product = product_sir,
  do_disc = c(0, 1, 0),
  t_max = 60,
  dt = 0.1,
  switching_threshold = c(N, 10, N),
  species_names = c("S", "I", "R"),
  return_type = "JSFResult"
)


## -----------------------------------------------------------------------------
result_sir


## -----------------------------------------------------------------------------
summary(result_sir)


## -----------------------------------------------------------------------------
plot(result_sir)


## -----------------------------------------------------------------------------
df_lv <- jsf_simulate(
  x0 = c(prey = 50, predator = 10),
  rates = rates_lv,
  reactant = reactant_lv,
  product = product_lv,
  do_disc = c(1, 1),
  t_max = 10,
  dt = 0.01,
  switching_threshold = c(30, 30),
  species_names = c("prey", "predator"),
  return_type = "data.frame"
)

head(df_lv)


## -----------------------------------------------------------------------------
result_from_df <- as_jsf_result(
  df_lv,
  method = "operator-splitting",
  config = list(
    model = "Lotka-Volterra",
    dt = 0.01,
    switching_threshold = c(30, 30)
  )
)

result_from_df

