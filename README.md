# SE-SEIR

This repository provides supplementary material to the paper ``Heterogeneous risk tolerance, in-groups, and epidemic waves``
from the project ``Standards of Risk Evidence Driven Behavior-Disease Model``.

The folder ``Rsource`` contains two source packages required to reproduce the results in the paper: ``BSEIR`` and ``wavefinder``.
Please, install all dependencies in R with the code

``` r
# Install devtools
install.packages("devtools")

# Dependencies for wavefinder
install.packages(c('Rdpack', 'R6', 'dplyr', 'pracma', 'data.table'), dependencies = TRUE)

# Additional dependencies for BSEIR (also depend on 'pracma', 'data.table', 'wavefinder')
install.packages(c('Rdpack', 'parallel', 'deSolve', 'pspline', 'stringi'), dependencies = TRUE)
```

Download and install these 

