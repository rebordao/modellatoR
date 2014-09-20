#' Fits the chosen model to the data.
#'
#' @param trainset is a data.frame or data.table containing the train data.
#' @param testset is a data.frame or data.table containing the test data.
#' @param params is a list containing the arguments necessary for training.
#' @return This function returns the chosen model.
#' @export
#'
train_model <- function(trainset, testset, params) {

  model <- function(trainset, testset, params) {
    switch(tolower(params$method_id),
           "dt"    = modellatoR::fit_decision_tree(trainset, testset, params),
           "rf"    = modellatoR::fit_random_forest(trainset, testset, params),
           "glm"   = modellatoR::fit_glm(trainset, testset, params),
           "nn"    = modellatoR::fit_neural_net(trainset, testset, params)
    )
  }

  # Deploys model
  model(trainset, testset, params)
}