## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  eval = rmarkdown::pandoc_available() && ("dplyr" %in% rownames(installed.packages()))
)

## ----setup--------------------------------------------------------------------
library(ftExtra)

## -----------------------------------------------------------------------------
data.frame(
  x = c("**bold**", "*italic*"),
  y = c("^superscript^", "~subscript~"),
  z = c("*[**~ft~^Extra^**](https://ftextra.atusy.net/) is*", "*Cool*"),
  stringsAsFactors = FALSE
) %>%
  as_flextable() %>%
  colformat_md()

## -----------------------------------------------------------------------------
data.frame(
  R = c("![](https://www.r-project.org/logo/Rlogo.png){width=.5} is the great language"),
  stringsAsFactors = FALSE
) %>%
  as_flextable() %>%
  colformat_md() %>%
  flextable::autofit()

## -----------------------------------------------------------------------------
data.frame(linebreak = c("a\nb"), stringsAsFactors = FALSE) %>%
  as_flextable() %>%
  colformat_md()

## -----------------------------------------------------------------------------
data.frame(linebreak = c("a\\\nb"), stringsAsFactors = FALSE) %>%
  as_flextable() %>%
  colformat_md()

## -----------------------------------------------------------------------------
data.frame(linebreak = c("a\nb"), stringsAsFactors = FALSE) %>%
  as_flextable() %>%
  colformat_md(.from = "markdown+hard_line_breaks")

## -----------------------------------------------------------------------------
data.frame(emoji = c(":+1:"), stringsAsFactors = FALSE) %>%
  as_flextable() %>%
  colformat_md(.from = "markdown+emoji")

