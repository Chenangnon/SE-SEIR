
### Path to save the scenarios
path0 = "/Users/ctovissode/Desktop/BSEIR/LocalSimulations/RunScenarios/"

### Scenarios for Profile B (population with interaction prevalence * rate of change)
ScenariosB <- BSEIR::get.sim.scenarios(b0.vec = 0,
                                       d0.vec = 0,
                                       e.vec = 0,
                                       alpha.vec = c(0.1, 1, 2, 3),
                                       m0.vec = 0.05,
                                       tau.vec = c(1, 3, 5, 7),
                                       kappa.vec = c(0.5, 0.6, 0.75, 0.9, 0.95, 1),
                                       beta_0.vec = c(0.5, 1, 2, 3),
                                       phi_a.vec = 1, phi_s.vec = 1,
                                       theta.vec = 0.25,
                                       pi_val.vec = c(0.25, 0.5, 2/3, 3/4),
                                       sigma.vec = 0.5,
                                       gamma_a.vec = 2/70, gamma_s.vec = 4/70,
                                       rho_a.vec = 3/70, rho_s.vec = 1/70, rho_d.vec = 1/70,
                                       S0.vec = 49998,
                                       E0.vec = 2,
                                       Ia0.vec = 1,
                                       Is0.vec = 1,
                                       Id0.vec = 0,
                                       a_1.a1 = "20+20",
                                       v_1.v1 = "150+150",
                                       only.homogeneous = FALSE,
                                       fully.heterogeneous = FALSE,
                                       sep = "+")

write.csv(ScenariosB, file = paste0(path0, "/ScenariosB", ".csv"), row.names = FALSE)

ScenariosB_params.mat <- BSEIR:::scenario2params (ScenariosB, sep = "+",
                                                  name.cols = TRUE)

dim(ScenariosB_params.mat)
head(ScenariosB_params.mat[, 1:13], 20)
