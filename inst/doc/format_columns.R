## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  eval = rmarkdown::pandoc_available("2.7.2") &&
    ("dplyr" %in% rownames(installed.packages()))
)

## ----setup--------------------------------------------------------------------
library(flextable)
library(ftExtra)

## -----------------------------------------------------------------------------
df <- data.frame(Oxide = c("SiO2", "Al2O3"), stringsAsFactors = FALSE)
ft <- flextable::flextable(df)

ft %>%
  flextable::compose(
    i = 1, j = "Oxide",
    value = flextable::as_paragraph(
      "SiO", as_sub("2")
    )
  ) %>%
  flextable::compose(
    i = 2, j = "Oxide",
    value = flextable::as_paragraph(
      "Al", as_sub("2"), "O", as_sub("3")
    )
  )

## -----------------------------------------------------------------------------
df <- data.frame(Oxide = c("SiO2", "Fe2O3"), stringsAsFactors = FALSE)
ft <- flextable::flextable(df)

for (i in seq(nrow(df))) {
  ft <- flextable::compose(
    ft, i = i, j = "Oxide",
    value = flextable::as_paragraph(
      list_values = df$Oxide[i] %>%
        stringr::str_replace_all("([2-9]+)", " \\1 ") %>%
        stringr::str_split(" ", simplify = TRUE) %>%
        purrr::map_if(
          function(x) stringr::str_detect(x, "[2-9]+"),
          flextable::as_sub
        )
    )
  )
}
ft

## -----------------------------------------------------------------------------
df <- data.frame(Oxide = c("SiO2", "Fe2O3"), stringsAsFactors = FALSE)

df %>%
  dplyr::mutate(Oxide = stringr::str_replace_all(Oxide, "([2-9]+)", "~\\1~")) %>%
  flextable::flextable() %>%
  ftExtra::colformat_md()

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
  R = sprintf("![](%s)", system.file("img", "Rlogo.jpg", package="jpeg")),
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

## ---- echo=FALSE, collapse=FALSE, class.output="bibtex", warning=FALSE, comment=""----
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

