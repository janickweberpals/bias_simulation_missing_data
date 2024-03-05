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
2.  Add/adapt the paths to the datasets in `.Renviron`
3.  In RStudio, run all scripts via `quarto render` or
    `Build > Render Book` (make sure quarto is installed)

## Repository structure and files

### Directory overview

    ## .
    ## ├── README.md
    ## ├── _quarto.yml
    ## ├── cc_bias_simulation.Rproj
    ## ├── data
    ## │   └── simulation_results.parquet
    ## ├── docs
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
    ## │   ├── 01_data_generation.qmd
    ## │   ├── 02_missingness_generation.qmd
    ## │   ├── 03_run_simulation.qmd
    ## │   ├── 04_simulation_results.md
    ## │   ├── 04_simulation_results.qmd
    ## │   └── 04_simulation_results_files
    ## ├── site_libs
    ## │   ├── bootstrap
    ## │   ├── clipboard
    ## │   ├── crosstalk-1.2.1
    ## │   ├── htmlwidgets-1.6.4
    ## │   ├── jquery-3.5.1
    ## │   ├── plotly-binding-4.10.4
    ## │   ├── plotly-htmlwidgets-css-2.11.1
    ## │   ├── plotly-main-2.11.1
    ## │   ├── quarto-html
    ## │   ├── quarto-nav
    ## │   ├── quarto-search
    ## │   └── typedarray-0.1
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
