## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, include=FALSE-----------------------------------------------------
library(ftExtra)
library(dplyr)

## ----setup2, ref.label='setup', eval=FALSE------------------------------------
#  library(ftExtra)
#  library(dplyr)

## -----------------------------------------------------------------------------
grouped_iris <- iris %>%
  group_by(Species) %>%
  slice(1, 2)

grouped_mtcars <- mtcars %>%
  mutate(model = rownames(mtcars)) %>%
  head %>%
  select(model, cyl, mpg, disp, am) %>%
  group_by(am, cyl)

## -----------------------------------------------------------------------------
grouped_iris %>% as_flextable()

## -----------------------------------------------------------------------------
grouped_iris %>% as_flextable(hide_grouplabel = TRUE)

## -----------------------------------------------------------------------------
grouped_mtcars %>% as_flextable()

## -----------------------------------------------------------------------------
grouped_iris %>%
  as_flextable(groups_to = 'merged')

## -----------------------------------------------------------------------------
grouped_mtcars %>%
  as_flextable(groups_to = 'merged') %>%
  flextable::theme_vanilla()

## -----------------------------------------------------------------------------
grouped_mtcars %>%
  as_flextable(groups_to = 'merged', groups_pos = 'asis') %>%
  flextable::theme_vanilla()

