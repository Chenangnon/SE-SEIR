
### Path to save the scenarios
path0 = "/Users/ctovissode/Desktop/BSEIR/LocalSimulations/RunScenarios/"

### Scenarios for Profile D (population with linear effect of rate of change)
ScenariosD <- BSEIR::get.sim.scenarios(b0.vec = 0,
                                       v.vec = 0,
                                       d0.vec = 0,
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
                                       e_1.e1 = "10+10",
                                       only.homogeneous = FALSE,
                                       fully.heterogeneous = FALSE,
                                       sep = "+")

write.csv(ScenariosD, file = paste0(path0, "/ScenariosD", ".csv"), row.names = FALSE)

ScenariosD_params.mat <- BSEIR:::scenario2params (ScenariosD, sep = "+",
                                                  name.cols = TRUE)

dim(ScenariosD_params.mat)
head(ScenariosD_params.mat[, 1:13], 50)
tail(ScenariosD_params.mat[, 1:13], 50)
