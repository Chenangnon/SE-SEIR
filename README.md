# SE-SEIR

This repository provides supplementary material to the paper ``Heterogeneous risk tolerance, in-groups, and epidemic waves``
from the project ``Standards of Risk Evidence Driven Behavior-Disease Model``. The directory ``Files2023Sections`` contains discussions from early stages of the project. It is not intended to the public.

The directory ``Rsource`` contains two source R packages required to reproduce the results in the paper: ``BSEIR`` and ``wavefinder``.
These packages require R (>= 4.0.0) and depend on a few other R packages. To install all dependencies:

``` r
# Install devtools if not yet
if(!require("devtools")) install.packages("devtools")

# Install dependencies for wavefinder
install.packages(c('Rdpack', 'R6', 'dplyr', 'pracma', 'data.table'), dependencies = TRUE)

# Install additional dependencies for BSEIR (also depends on 'pracma', 'data.table', and 'wavefinder')
install.packages(c('Rdpack', 'parallel', 'deSolve', 'pspline', 'stringi'), dependencies = TRUE)
```

To install ``BSEIR`` and ``wavefinder`` on your computer, first download the files ``BSEIR_0.1.0.tar.gz`` and ``wavefinder_0.1.0.tar.gz`` from the directory ``Rsource`` of this repository.

Then, run the following line with ``~`` replaced by the path to the directory where ``BSEIR_0.1.0.tar.gz`` and ``wavefinder_0.1.0.tar.gz`` were saved on your computer.

``` r
# Install the required libraries BSEIR and wavefinder
install.packages("~/wavefinder_0.1.0.tar.gz", repos = NULL, type = "source")
install.packages("~/BSEIR_0.1.0.tar.gz", repos = NULL, type = "source")
```

## Example 1
This basic example shows you how to simulate and visualize a Behavior-Disease system.

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

## Help on the main function
?SolveBSEIR

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

## Example 2
This example shows an approach to wave detection in an epidemiological time series using Harvey et al. (2023)'s algorithm.
The example use a simulated epidemiological case data with spikes.  

``` r
## Load wavefinder
library(wavefinder)

## Load data (see ?sbseir for details)
load('sbseir')

# Plot the same series repeated twice
plot(c(sbseir$Time, tail(sbseir$Time, 1) + sbseir$Time[-1]),
     c(sbseir$Ct, sbseir$Ct[-1]),
     type="l", col="navy",
     xlab = "Time (day)", ylab = "New positive cases")
grid()

# Find peaks with height over 100, and trough below 500, and peak-trough distance above 10 steps
peaktroughs <- peaks_and_troughs (c(sbseir$Ct, sbseir$Ct[-1]),
                                  height = 100,
                                  trough_max = 500,
                                  lag_min = 10)
peaktroughs
```

## Reference
Harvey J, Chan B, Srivastava T, Zarebski AE, Dłotko P, Błaszczyk P, Parkinson RH, White LJ, Aguas R, Mahdi A (2023). “Epidemiological waves - Types, drivers and modulators in the COVID-19 pandemic.” Heliyon, 1–25. doi:10.1016/j.heliyon.2023.e16015.

## Simulation procedure
The directory ``RunScenarios`` contains R codes (and generated ``.csv`` files) used to run simulations in the paper ``Heterogeneous risk tolerance, in-groups, and epidemic waves``. A file with the generic name ``GenerateScenariosX.R`` (e.g. ``GenerateScenarios0.R``) contains the R code used to generate combinations of BSEIR model parameters for simulations under a specific population profile (e.g. ``profile 0`` in the paper, i.e. a population responsive to disease prevalence only). It uses the R function ``BSEIR::get.sim.scenarios`` of the package ``BSEIR`` (see the R help page ``?BSEIR::get.sim.scenarios`` for details). The results from running ``GenerateScenariosX.R`` is an R object of class ``sim.scenarios``, i.e. a ``data.frame`` with 25 named columns which is saved in the file ``ScenariosX.csv`` (e.g. ``Scenarios0.csv``). The R script ``RunScenariosX.R`` (e.g. ``RunScenarios0.R``) loads ``ScenariosX.csv`` (e.g. ``Scenarios0.csv``) and calls the function ``BSEIR::Batch.solveBSEIR`` of the package ``BSEIR`` to run the simulations for all scenarios indexed in ``ScenariosX.csv`` (see the R help page ``?BSEIR::Batch.solveBSEIR``` for details).



