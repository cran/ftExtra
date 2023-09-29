## ----include = FALSE----------------------------------------------------------
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

for (i in seq_len(nrow(df))) {
  ft <- flextable::compose(
    ft,
    i = i,
    j = "Oxide",
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
  dplyr::mutate(
    Oxide = stringr::str_replace_all(Oxide, "([2-9]+)", "~\\1~")
  ) %>%
  flextable::flextable() %>%
  ftExtra::colformat_md()

## -----------------------------------------------------------------------------
data.frame(
  a = c("**bold**", "*italic*"),
  b = c("^superscript^", "~subscript~"),
  c = c("`code`", "[underline]{.underline}"),
  d = c(
    "*[**~ft~^Extra^**](https://ftextra.atusy.net/) is*",
    "[Cool]{.underline shading.color='skyblue'}"
  ),
  stringsAsFactors = FALSE
) %>%
  flextable() %>%
  colformat_md()

## -----------------------------------------------------------------------------
data.frame(
  package = "ftExtra",
  description = "Extensions for 'Flextable'^[Supports of footnotes]",
  stringsAsFactors = FALSE
) %>%
  flextable() %>%
  colformat_md() %>%
  flextable::autofit(add_w = 0.5)

## -----------------------------------------------------------------------------
data.frame(
  package = "ftExtra^[Short of *flextable extra*]",
  description = "Extensions for 'Flextable'^[Supports of footnotes]",
  stringsAsFactors = FALSE
) %>%
  flextable() %>%
  colformat_md(
    .footnote_options = footnote_options(
      ref = "i",
      prefix = "[",
      suffix = "]",
      start = 2,
      inline = TRUE,
      sep = "; "
    )
  ) %>%
  flextable::autofit(add_w = 0.5)

## -----------------------------------------------------------------------------
data.frame(
  x =
    "foo[^a]^,^ [^b]

[^a]: aaa

[^b]: bbb",
  stringsAsFactors = FALSE
) %>%
  flextable() %>%
  colformat_md()

## -----------------------------------------------------------------------------
#' Custom formatter of reference symbols
#'
#' @param n n-th reference symbol (integer)
#' @param part where footnote exists: "body" or "header"
#' @param footer whether to format symbols in the footer: `TRUE` or `FALSE`
#'
#' @return a character vector which will further be processed as markdown texts
ref <- function(n, part, footer) {
  # Header uses letters and body uses integers for the symbols
  s <- if (part == "header") {
    letters[n]
  } else {
    as.character(n)
  }

  # Suffix symbols with ": " (a colon and a space) in the footer
  if (footer) {
    return(paste0(s, ":\\ "))
  }

  # Use superscript in the header and the body
  return(paste0("^", s, "^"))
}

# Apply custom function to format a table with footnotes
tibble::tibble(
  "header1^[note a]" = c("x^[note 1]", "y"),
  "header2" = c("a", "b^[note 2]")
) %>%
  flextable() %>%
  # process header first
  colformat_md(
    part = "header", .footnote_options = footnote_options(ref = ref)
  ) %>%
  # process body next
  colformat_md(
    part = "body", .footnote_options = footnote_options(ref = ref)
  ) %>%
  # tweak width for visibility
  flextable::autofit(add_w = 0.2)

## -----------------------------------------------------------------------------
data.frame(
  R = sprintf("![](%s)", file.path(R.home("doc"), "html", "logo.jpg")),
  stringsAsFactors = FALSE
) %>%
  flextable() %>%
  colformat_md() %>%
  flextable::autofit()

## -----------------------------------------------------------------------------
data.frame(linebreak = c("a\nb"), stringsAsFactors = FALSE) %>%
  flextable() %>%
  colformat_md()

## -----------------------------------------------------------------------------
data.frame(linebreak = c("a\\\nb"), stringsAsFactors = FALSE) %>%
  flextable() %>%
  colformat_md()

## -----------------------------------------------------------------------------
data.frame(linebreak = c("a\nb"), stringsAsFactors = FALSE) %>%
  flextable() %>%
  colformat_md(md_extensions = "+hard_line_breaks")

## -----------------------------------------------------------------------------
data.frame(linebreak = c("a\n\nb"), stringsAsFactors = FALSE) %>%
  flextable() %>%
  colformat_md(.sep = "\n\n")

## ----echo=FALSE, collapse=FALSE, class.output="bibtex", warning=FALSE, comment=""----
knitr::write_bib("ftExtra")

## ----eval=FALSE---------------------------------------------------------------
#  data.frame(
#    Cite = c("@R-ftExtra", "[@R-ftExtra]", "[-@R-ftExtra]"),
#    stringsAsFactors = FALSE
#  ) %>%
#    flextable() %>%
#    colformat_md() %>%
#    flextable::autofit(add_w = 0.2)

## ----echo=FALSE, warning=FALSE, error=TRUE------------------------------------
tf <- tempfile(fileext = ".bib")
knitr::write_bib("ftExtra", tf)
data.frame(
  Cite = c("@R-ftExtra", "[@R-ftExtra]", "[-@R-ftExtra]"),
  stringsAsFactors = FALSE
) %>%
  flextable() %>%
  colformat_md(pandoc_args = c("--bibliography", tf)) %>%
  flextable::autofit(add_w = 0.2)

## -----------------------------------------------------------------------------
data.frame(
  math = "$e^{i\\theta} = \\cos \\theta + i \\sin \\theta$",
  stringsAsFactors = FALSE
) %>%
  flextable() %>%
  colformat_md() %>%
  flextable::autofit(add_w = 0.2)

## -----------------------------------------------------------------------------
data.frame(emoji = c(":+1:"), stringsAsFactors = FALSE) %>%
  flextable() %>%
  colformat_md(md_extensions = "+emoji")

## -----------------------------------------------------------------------------
data.frame(
  x = "H<sub>2</sub>O",
  stringsAsFactors = FALSE
) %>%
  flextable() %>%
  colformat_md(.from = "html")

## -----------------------------------------------------------------------------
data.frame(
  x = "foo\n\nbar",
  stringsAsFactors = FALSE
) %>%
  flextable() %>%
  colformat_md(.from = "commonmark")

