create_fifty_rows_of_importance <- function(data) {
  generate_importance <- function(data) {
    rf <- randomForest(
      response ~ .,
      data=data,
      ntree = 2000,
      replace = FALSE,
      importance = TRUE
    )
    t(randomForest::importance(rf, type = 1, scale = F))
  }
  
  nextimportance <- function(df, data) {
    rbind(df, generate_importance(data))
  }
  
  data.frame()  %>% nextimportance(data) %>% nextimportance(data) %>% nextimportance(data) %>% nextimportance(data) %>% nextimportance(data) %>% nextimportance(data) %>% nextimportance(data) %>% nextimportance(data) %>% nextimportance(data) %>% nextimportance(data) %>% nextimportance(data) %>% nextimportance(data) %>% nextimportance(data) %>% nextimportance(data) %>% nextimportance(data) %>% nextimportance(data) %>% nextimportance(data) %>% nextimportance(data) %>% nextimportance(data) %>% nextimportance(data) %>% nextimportance(data) %>% nextimportance(data) %>% nextimportance(data) %>% nextimportance(data) %>% nextimportance(data) %>% nextimportance(data) %>% nextimportance(data) %>% nextimportance(data) %>% nextimportance(data) %>% nextimportance(data) %>% nextimportance(data) %>% nextimportance(data) %>% nextimportance(data) %>% nextimportance(data) %>% nextimportance(data) %>% nextimportance(data) %>% nextimportance(data) %>% nextimportance(data) %>% nextimportance(data) %>% nextimportance(data) %>% nextimportance(data) %>% nextimportance(data) %>% nextimportance(data) %>% nextimportance(data) %>% nextimportance(data) %>% nextimportance(data) %>% nextimportance(data) %>% nextimportance(data) %>% nextimportance(data) %>% nextimportance(data) %>% nextimportance(data)
}

select_variables_from_random_forest <- function(data) {
  test <- create_fifty_rows_of_importance(data)
  sorted.test <- test[,order(colMeans(-test),colMeans(-test))]
  
  sd.test <- data.frame(sapply(sorted.test, sd))
  d <- sd.test
  names <- rownames(d)
  rownames(d) <- NULL
  variable_selection_output <- cbind(names,d)
  
  sd.test$x <- c(1:(ncol(data) - 1))
  sd.test$y <- sd.test$sapply.sorted.test..sd.
  sd.model <- rpart(y ~ x, data=sd.test)
  sd.predict <- predict(sd.model)
  cutoff <- min(sd.predict)
  
  ggplot(data = sd.test, aes(x=x, y=y)) + 
    geom_line() +
    ylab("Standard Deviation of VI") +
    xlab("Predictor Name") + scale_x_discrete(limits=names) + 
    geom_hline(yintercept = cutoff, linetype="dashed", color = "red") +
    theme_bw()  + theme(axis.text.x = element_text(angle = 90, hjust = 1))
  
  sd.test$keep <- sd.test$sapply.sorted.test..sd. > cutoff
  rownames(sd.test[sd.test$keep == T,])
}

create_fifty_rows_of_oob <- function(data) {
  generate_oob <- function(data) {
    rf <- randomForest(
      response ~ .,
      data=data,
      replace = FALSE,
      importance = TRUE
    )
    mean(rf$mse)
  }
  
  result <- c(generate_oob(data), generate_oob(data), generate_oob(data), generate_oob(data), generate_oob(data), generate_oob(data), generate_oob(data), generate_oob(data), generate_oob(data), generate_oob(data), generate_oob(data), generate_oob(data), generate_oob(data), generate_oob(data), generate_oob(data), generate_oob(data), generate_oob(data), generate_oob(data), generate_oob(data), generate_oob(data), generate_oob(data), generate_oob(data), generate_oob(data), generate_oob(data), generate_oob(data), generate_oob(data), generate_oob(data), generate_oob(data), generate_oob(data), generate_oob(data), generate_oob(data), generate_oob(data), generate_oob(data), generate_oob(data), generate_oob(data), generate_oob(data), generate_oob(data), generate_oob(data), generate_oob(data), generate_oob(data), generate_oob(data), generate_oob(data), generate_oob(data), generate_oob(data), generate_oob(data), generate_oob(data), generate_oob(data), generate_oob(data), generate_oob(data), generate_oob(data))
  
  m <- mean(result)
  sd <- sd(result)
  sum <- m + sd
  paste("Mean ", m, ", SD: ", sd, ", Mean + SD: ", sum)
}