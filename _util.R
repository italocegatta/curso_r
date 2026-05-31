# _util.R — Configuração executada antes de cada capítulo

# User library path
.libPaths(c("/home/italo/R/library", .libPaths()))

# Pacotes
library(dplyr)
library(ggplot2)
library(readr)
library(tidyr)
library(stringr)
library(forcats)
library(purrr)
library(tibble)
library(readxl)
library(lubridate)
library(broom)
library(patchwork)
library(scales)
# gt installed separately if available
tryCatch(library(gt), error = function(e) NULL)

# Tema padrão para todos os gráficos
theme_set(theme_minimal(base_size = 12))

# Opções do knitr
knitr::opts_chunk$set(
  collapse = TRUE,
  fig.width = 8,
  fig.height = 5,
  fig.align = "center",
  dpi = 150
)
