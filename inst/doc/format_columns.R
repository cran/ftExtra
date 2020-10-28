## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  eval = rmarkdown::pandoc_available("2.7.2") &&
    ("dplyr" %in% rownames(installed.packages()))
)

## ----setup--------------------------------------------------------------------
library(ftExtra)

## -----------------------------------------------------------------------------
data.frame(
  a = c("**bold**", "*italic*"),
  b = c("^superscript^", "~subscript~"),
  c = c("`code`", "[underline]{.underline}"),
  d = c("*[**~ft~^Extra^**](https://ftextra.atusy.net/) is*",
        "[Cool]{.underline shading.color='skyblue'}"),
  stringsAsFactors = FALSE
) %>%
  as_flextable() %>%
  colformat_md()

## -----------------------------------------------------------------------------
data.frame(
  package = "ftExtra",
  description = "Extensions for 'Flextable'^[Supports of footnotes]",
  stringsAsFactors = FALSE
) %>%
  as_flextable() %>%
  colformat_md() %>%
  flextable::autofit(add_w = 0.5)

## -----------------------------------------------------------------------------
data.frame(
  package = "ftExtra^[Short of *flextable extra*]",
  description = "Extensions for 'Flextable'^[Supports of footnotes]"
) %>%
  as_flextable() %>%
  colformat_md(
    .footnote_options = footnote_options(ref = "i",
                                         prefix = '[',
                                         suffix = ']',
                                         start = 2,
                                         inline = TRUE,
                                         sep = "; ")
  ) %>%
  flextable::autofit(add_w = 0.5)

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
  colformat_md(md_extensions = "+hard_line_breaks")

## ---- echo=FALSE, collapse=FALSE, out.class="bib", warning=FALSE--------------
knitr::write_bib("ftExtra")

## ---- eval=FALSE--------------------------------------------------------------
#  data.frame(
#    Cite = c("@R-ftExtra", "[@R-ftExtra]", "[-@R-ftExtra]"),
#    stringsAsFactors = FALSE
#  ) %>%
#    as_flextable() %>%
#    colformat_md() %>%
#    flextable::autofit(add_w = 0.2)

## ---- echo=FALSE, warning=FALSE-----------------------------------------------
tf <- tempfile(fileext = ".bib")
knitr::write_bib("ftExtra", tf)
data.frame(
  Cite = c("@R-ftExtra", "[@R-ftExtra]", "[-@R-ftExtra]"),
  stringsAsFactors = FALSE
) %>%
  as_flextable() %>%
  colformat_md(pandoc_args = paste0("--bibliography=", tf)) %>%
  flextable::autofit(add_w = 0.2)

## -----------------------------------------------------------------------------
data.frame(math = "$e^{i\\theta} = \\cos \\theta + i \\sin \\theta$",
           stringsAsFactors = FALSE) %>%
  as_flextable() %>%
  colformat_md() %>%
  flextable::autofit(add_w = 0.2)

## -----------------------------------------------------------------------------
data.frame(emoji = c(":+1:"), stringsAsFactors = FALSE) %>%
  as_flextable() %>%
  colformat_md(md_extensions = "+emoji")

