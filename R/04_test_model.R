
#### TESTING ####

#' Tests a model.
#'
#' @param model is a model computed with train_model.
#' @param params is the list of arguments created by setup_model.
#' @param testset is the data.frame that contains the data
#' that we want to evaluate.
#' @return Returns a data.frame that contains the real
#' values of the target variable and the model estimations.
#' @export
test_model <- function(model, params, testset) {

  # Sets up type of output of the training method
  if (params$regression) {
    type <- switch(params$method_id,
                   "dt"   = "vector",
                   "rf"   = "response",
                   "glm"  = "response",
                   "nn"   = "response"
    )
  } else {
    type <- switch(params$method_id,
                   "dt"   = "prob",
                   "rf"   = "prob",
                   "glm"  = "response",
                   "nn"   = "prob "
    )
  }

  # Sets up a function to get y_estimated
  get_y_est <- function(model, type, testset) {

    if (params$regression) {
      switch(params$method_id,
             "dt"    = predict(model, newdata = testset, type = type),
             "rf"    = predict(model, newdata = testset, type = type),
             "glm"   = predict(model, newdata = testset, type = type),
             "nn"    = 1 # TODO this
      )
    } else {
      switch(params$method_id,
             "dt"    = predict(model, newdata = testset, type = type)[, 2],
             "rf"    = predict(model, newdata = testset, type = type)[, 2],
             "glm"   = predict(model, newdata = testset, type = type),
             "nn"    = 1 # TODO this
      )
    }
  }

  # Gets real values y
  y <- testset[[params$out_var]]

  # Gets y estimated
  y_est <- get_y_est(model, type, testset)

  # Generates output
  output <- data.frame(cbind(y = y, y_est = y_est), row.names=NULL)
}