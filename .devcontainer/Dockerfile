# Pre-built Dev Container Image for R. More info: https://github.com/rocker-org/devcontainer-images/pkgs/container/devcontainer%2Ftidyverse
# Available R version: 4, 4.1, 4.0
ARG VARIANT="4.2"
FROM ghcr.io/rocker-org/devcontainer/tidyverse:${VARIANT}

# Copy RStudio preferences
COPY rstudio-prefs.json /rstudio-prefs.json
COPY copy-rstudio-prefs.sh /copy-rstudio-prefs.sh
RUN chmod +x /copy-rstudio-prefs.sh

RUN install2.r --error --skipinstalled -n -1 \
        here \
        tidymodels \
        markdown \
        gtsummary \
        ggsurvfit \
        survival \
        gt \
        quarto \
        rmarkdown \
        languageserver \
        WeightIt \
        MatchIt \
        MatchThem \
        tictoc \
    && rm -rf /tmp/downloaded_packages

