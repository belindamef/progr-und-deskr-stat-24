# This script specifies a number of R code evaluation and output defaults. It is
# based on common.R in Hadley Wickham's Advanced R Second Edition 
#
# Author- Dirk Ostwald
' ------------------------------------------------------------------------------'
library(methods)
library(latex2exp)
set.seed(1014)                                                                   # fixed random number generator state


knitr::opts_chunk$set(
comment       = ">",                                                             # console output label
collapse      = FALSE,                                                           # console output label in R code chunk
cache         = TRUE,
fig.retina    = 0.8, 
dpi           = 300,
out.width     = "70%",
fig.align     = 'center',
fig.width     = 5,
fig.asp       = 1,  # 1 / phi
fig.show      = "hold"
)

options(
  rlang_trace_top_env = rlang::current_env(),
  rlang__backtrace_on_error = "none"
)

options(
  digits = 3,
  str = strOptions(strict.width = "cut")
)

if (knitr::is_latex_output()) {
  knitr::opts_chunk$set(width = 69)
  options(width = 69)
  options(crayon.enabled = FALSE)
  options(cli.unicode = TRUE)
}

knitr::knit_hooks$set(
  small_mar = function(before, options, envir) {
    if (before) {
      par(mar = c(4.1, 4.1, 0.5, 0.5))
    }
  }
)

# Make error messages closer to base R
registerS3method("wrap", "error", envir = asNamespace("knitr"),
  function(x, options) {
    msg <- conditionMessage(x)

    call <- conditionCall(x)
    if (is.null(call)) {
      msg <- paste0("Error: ", msg)
    } else {
      msg <- paste0("Error in ", deparse(call)[[1]], ": ", msg)
    }

    msg <- error_wrap(msg)
    knitr:::msg_wrap(msg, "error", options)
  }
)

error_wrap <- function(x, width = getOption("width")) {
  lines <- strsplit(x, "\n", fixed = TRUE)[[1]]
  paste(strwrap(lines, width = width), collapse = "\n")
}


inline_hook <- function (x) {
    if (is.numeric(x)) {
        # ifelse does a vectorized comparison
        # If integer, print without decimal; otherwise print two places
        res <- ifelse(x == round(x),
                      sprintf("%d", x),
                      sprintf("%.2f", x)
        )
        paste(res, collapse = ", ")
    }
}

knitr::knit_hooks$set(inline = inline_hook)


