library(lme4)
library(MuMIn)
library(scales)


# Taken from MuMIN package
# https://rdrr.io/cran/MuMIn/src/R/averaging.R
# https://rdrr.io/cran/MuMIn/src/R/model.avg.R

.coefarr.avg <-
  function(cfarr, weight, revised.var, full, alpha) {	
    weight <- weight / sum(weight)
    nCoef <- dim(cfarr)[3L]
    if(full) {
      nas <- is.na(cfarr[, 1L, ]) & is.na(cfarr[, 2L, ])
      cfarr[, 1L, ][nas] <- cfarr[, 2L, ][nas] <- 0
      #cfarr[, 1L:2L, ][is.na(cfarr[, 1L:2L, ])] <- 0
      if(!all(is.na(cfarr[, 3L, ])))
        cfarr[ ,3L, ][is.na(cfarr[ , 3L, ])] <- Inf
    }
    
    avgcoef <- array(dim = c(nCoef, 5L),
                     dimnames = list(dimnames(cfarr)[[3L]], c("Estimate",
                                                              "Std. Error", "Adjusted SE", "Lower CI", "Upper CI")))
    for(i in seq_len(nCoef))
      avgcoef[i, ] <- par.avg(cfarr[, 1L, i], cfarr[, 2L, i], weight,
                              df = cfarr[, 3L, i], alpha = alpha, revised.var = revised.var)
    
    avgcoef[is.nan(avgcoef)] <- NA
    return(avgcoef)
  }

.makecoefmat <- function(cf) {
  no.ase <- all(is.na(cf[, 3L]))
  z <- abs(cf[, 1L] / cf[, if(no.ase) 2L else 3L])
  pval <- 2 * pnorm(z, lower.tail = FALSE)
  cbind(cf[, if(no.ase) 1L:2L else 1L:3L, drop = FALSE],
        `z value` = z, `Pr(>|z|)` = zapsmall(pval))
}

# Generate model selections using lmer, dredge, and model.avg
# `forumla` : a two-sided linear formula object describing both the fixed-effects and random-effects part of the model
# `data` : the data frame containing the variables from the formula
# `aic_delta` : the AIC delta to use for selecting models in model average
model_average <- function(formula, data, aic_delta) {
  model <- lmer(
    formula,
    data=data
  )
  dredge_result <- dredge(model)
  summary(model.avg(dredge_result, subset = delta < aic_delta))
}

# Create a summary data frame containing the selected variables from a model
# `pool` : The name of the pool variables were selected from - used for naming columns
# `response_var` : The name of the response var variables were selected for - used for naming columns
# `model_sum` : The model summary output from `model_average`
model_summary <- function(pool, response_var, model_sum) {
  .column_name <- function(postfix) {
    paste(response_var, pool, postfix, sep='_')
  }
  
  # just return the estimate and p value
  weight <- model_sum$msTable[, 5L]
  
  coefmat.full <- as.data.frame(.makecoefmat(.coefarr.avg(model_sum$coefArray, weight,
                                                          attr(model_sum, "revised.var"), TRUE, 0.05)))
  
  coefmat.subset <-
    as.data.frame(.makecoefmat(.coefarr.avg(model_sum$coefArray, weight,
                                            attr(model_sum, "revised.var"), FALSE, 0.05)))
  
  
  coefmat.subset <- coefmat.subset[-c(1), c(1, 5)]
  names(coefmat.subset) <- c(.column_name("estimate"), .column_name("p"))
  coefmat.subset <- tibble::rownames_to_column(coefmat.subset, "explanatory")
  coefmat.subset$model = 'subset'
  
  coefmat.full <- coefmat.full[-c(1), c(1, 5)]
  names(coefmat.full) <- c(.column_name("estimate"), .column_name("p"))
  coefmat.full <- tibble::rownames_to_column(coefmat.full, "explanatory")
  coefmat.full$model = 'full'
  
  rbind(coefmat.full, coefmat.subset)
}