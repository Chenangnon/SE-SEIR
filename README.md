# SE-SEIR

This repository provides supplementary material to the paper ``Heterogeneous risk tolerance, in-groups, and epidemic waves``
from the project ``Standards of Risk Evidence Driven Behavior-Disease Model``.

The folder ``Rsource`` contains two source R packages required to reproduce the results in the paper: ``BSEIR`` and ``wavefinder``.
These packages require R (>= 4.0.0). To install all dependencies:

``` r
# Install devtools if not yet
if(!require("devtools")) install.packages("devtools")

# Install dependencies for wavefinder
install.packages(c('Rdpack', 'R6', 'dplyr', 'pracma', 'data.table'), dependencies = TRUE)

# Install additional dependencies for BSEIR (also depends on 'pracma', 'data.table', and 'wavefinder')
install.packages(c('Rdpack', 'parallel', 'deSolve', 'pspline', 'stringi'), dependencies = TRUE)
```

Download the files ``BSEIR_0.1.0.tar.gz`` and ``wavefinder_0.1.0.tar.gz`` from the directory ``Rsource`` of this repository.

Run the following line with ``~`` replaced by the path to the directory where ``BSEIR_0.1.0.tar.gz`` and ``wavefinder_0.1.0.tar.gz`` were saved at on your computer.

``` r
install.packages("~/wavefinder_0.1.0.tar.gz", repos = NULL, type = "source")
install.packages("~/BSEIR_0.1.0.tar.gz", repos = NULL, type = "source")
```

## Example
This is a basic example which shows you how to simulate a Behavior-Disease system.

``` r
## Simulation of an homogeneous population reactive to prevalence only, with neutral in-group pressure, and 95% protection by prophylactic behavior.
# Define a model parameter vector and initial states of the system
params0 <- list (
  # model parameters
  params = c(tau = 3,                 # Risk information delay
             a1 = 20, a2 = 20,        # Linear reaction to prevalence
             b01 = 0, b02 = 0,        # Quadratic reaction to prevalence
             v1 = 0, v2 = 0,          # Interaction prevalence x rate of change
             d01 = 0, d02 = 0,        # Quadratic reaction to rate of change
             e1 = 0, e2 = 0,          # Linear reaction to rate of change
             alpha1 = 1, alpha2 = 1,  # In-group pressure (neutral)
             m01 = 0.05, m02 = 0.05,  # Prophylactic proportion in disease/info-free conditions
             kappa = 0.95,            # level of protection from prophylactic behavior
             beta_0 = 2,              # Baseline (disease/info-free) transmission rate
             phi_a = 1, phi_s = 1,    # Probability of disease transmission by asymptomatic/syptomatic infectives
             theta = 1/4,             # 1/Duration of incubation (latent) period
             pi_val = 2/3,            # Early detection probability for exposed individuals
             sigma = 1/3,             # Proportion of symptomatic infectious
             gamma_a = 2/(3*14),      # Detection rate of asymptomatic infectives
             gamma_s = 4/(10*14),     # Detection rate of symptomatic infectives
             rho_a = (1 - 2/3)/14,    # Removal rate of asymptomatic infectious
             rho_s = (1 - 4/10)/14,   # Removal rate of symptomatic infectious,
             rho_d = 1/30,            # Removal rate of detected infectious
             N = 1e+5),
  # Initial state
  y0 = c(S_1 = 49998, S1 = 49998, E = 2, Ia = 1, Is = 1, Id = 0)
)

## Load BSEIR
library(BSEIR)

## Run the simulation
sim0 <- SolveBSEIR (params = params0$params,
                    y0 = params0$y0,
                    Horizon = 300, timestep = 0.5,
                    verbose = TRUE, plot = FALSE)

## Print a summary of the results
sim0

# plot the results
plot(sim0, which = "Solution")
plot(sim0, which = "New positive cases")
plot(sim0, which = "Prophylactic proportions")
plot(sim0, which = "Reproductive numbers")
```

