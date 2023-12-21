# SE-SEIR

This repository provides supplementary material to the paper ``Heterogeneous risk tolerance, in-groups, and epidemic waves``
from the project ``Standards of Risk Evidence Driven Behavior-Disease Model``.

The folder ``Rsource`` contains two source packages required to reproduce the results in the paper: ``BSEIR`` and ``wavefinder``.
These packages require R (>= 4.0.0). To install all dependencies:

``` r
# Install devtools if not yet
if(!require("devtools")) install.packages("devtools")

# Install dependencies for wavefinder
install.packages(c('Rdpack', 'R6', 'dplyr', 'pracma', 'data.table'), dependencies = TRUE)

# Install additional dependencies for BSEIR (also depends on 'pracma', 'data.table', and 'wavefinder')
install.packages(c('Rdpack', 'parallel', 'deSolve', 'pspline', 'stringi'), dependencies = TRUE)
```

Download the files ``BSEIR_0.1.0.tar.gz`` and ``wavefinder_0.1.0.tar.gz`` from the directory ``Rsource``.

``` r
install.packages("~/wavefinder_0.1.0.tar.gz", repos = NULL, type = "source")
```

