# Description

## Objective

The objective of this repository is to flexibly simulate de novo
datasets with different missingness scenarios. The simulated datasets
approximate the distributions of the empirical cohort used in the
[`HDMI` project](https://gitlab-scm.partners.org/drugepi/hd-mi).

## Dependencies

This is a quarto project and R package dependencies are managed through
the `renv` package. All packages and their versions can be viewed in the
lockfile `renv.lock`. All required packages and the appropriate versions
can be installed by running the following command:

    renv::restore()

The dependencies are managed through Posit’s repository package manager
(RSPM) version for your underlying OS distribution. If you use a
different operating system than MacOS, please head over to the RSPM
setup website and follow these steps:

1.  Go to the [RSPM setup
    website](https://packagemanager.posit.co/client/#/repos/cran/setup?distribution=redhat-9)

2.  Choose the operating system (if Linux, also choose the Linux
    distribution)

3.  Go to **`Repository URL:`** and copy-paste the URL to the options
    statement in the `.Rprofile` file

    *options(repos = c(REPO\_NAME = “URL”))*

## Reproducibility

Follow these steps in RStudio to reproduce this study:

1.  Install all necessary dependencies (see above)
2.  In RStudio, run all scripts via `quarto render` or
    `Build > Render Book` (make sure quarto is installed)

## Repository structure and files

### Directory overview

    ## .
    ## ├── README.md
    ## ├── _quarto.yml
    ## ├── cc_bias_simulation.Rproj
    ## ├── doc
    ## │   ├── index.html
    ## │   ├── robots.txt
    ## │   ├── scripts
    ## │   ├── search.json
    ## │   ├── site_libs
    ## │   └── sitemap.xml
    ## ├── functions
    ## │   ├── format_methods.R
    ## │   ├── generate_NA_cont.R
    ## │   ├── generate_NA_discrete.R
    ## │   ├── generate_data.R
    ## │   ├── ps_analysis_mids.R
    ## │   ├── rsimsum_ggplot.R
    ## │   └── run_simulation.R
    ## ├── index.qmd
    ## ├── renv
    ## │   ├── activate.R
    ## │   ├── library
    ## │   ├── settings.json
    ## │   └── staging
    ## ├── renv.lock
    ## ├── scripts
    ## │   ├── 01_data_generation.html
    ## │   ├── 01_data_generation.qmd
    ## │   ├── 01_data_generation_files
    ## │   ├── 02_missingness_generation.html
    ## │   ├── 02_missingness_generation.qmd
    ## │   ├── 02_missingness_generation_files
    ## │   ├── 03_run_simulation.md
    ## │   ├── 03_run_simulation.qmd
    ## │   └── 03_run_simulation_files
    ## └── update_README.R

-   .Rprofile - defines paths, activates `renv`, options for Posit R
    package manager
-   scripts - main R/RMarkdown scripts
-   functions - helper functions called in scripts
-   renv/renv.lock - `renv` directories to manage R dependencies and
    versions used in this simulation
-   docs - output of Quarto scripts
-   README - essential information about the project (README.Rmd renders
    to README.md via update\_README.R after each `quarto render`
    command)
