### Load 'BSEIR'
library(BSEIR)
library(parallel)

#library(BSEIR, lib = "/mnt/ceph/ctovissode/Rpackages/")
#library(parallel, lib = "/mnt/ceph/ctovissode/Rpackages/")

# attach(getNamespace("BSEIR"))

#print(version)
#print(packageVersion("BSEIR"))
#packageDescription("BSEIR")

### Path to saved 'sim.scenarios' object
path0 = "/Users/ctovissode/Desktop/BSEIR/LocalSimulations/RunScenarios/"

### Path to save results
path = "/Users/ctovissode/Desktop/BSEIR/LocalSimulations/RawResults/"

### Profile
K = "0A"

cat (paste0("\n           *** Running simulations for Profile ", K, " Scenarios \n"))

### Import simulation 'sim.scenarios' object (stored in directory indexed by 'path')
Scenarios <- read.csv(paste0(path0, "Scenarios", K, ".csv"))
class(Scenarios) <- c("data.frame", "sim.scenarios")
attr(Scenarios, "sep") <- "+"

### Call 'BSEIR::Batch.solveBSEIR'
#clobject <- parallel::makeCluster(spec = 50)
clobject <- parallel::makeCluster(spec = 4)

system.time({
  ResultK = BSEIR::Batch.solveBSEIR (scenarios = Scenarios,
                                     Horizon = 1000, timestep = 0.5, closed.eval.time = TRUE,
                                     eps = 1e-20, fQ = 1, non.negative.params = TRUE,
                                     minP = 1e-10, minQ = -3, maxQ = 3,
                                     method = "lsoda", control = NULL,
                                     add.homogeneous = FALSE, verbose = 1L,
                                     cl = clobject, chunk.size = NULL,
                                     save = TRUE, path = path, subpath = "Outputs",
                                     filename = paste0("Scenarios", K, "_out"),
                                     save.each = FALSE,
                                     file.ext = ".csv", quote = TRUE,
                                     eol = "\n", na = "NA", row.names = TRUE)
})
# user  system elapsed
# 6.117   1.272 935.03
# for 2430 settings in 'scenarios'

BSEIR::catch.conditions({
  parallel::stopCluster(cl = clobject)
})
