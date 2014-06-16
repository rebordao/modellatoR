"
A set of tools for training a model.
"

#### TRAINING ####

#' Fits the chosen model to the data.
#'
#' @param data is a data.frame or data.table containing the data.
#' @param params is a list containing the arguments necessary for training.
#' @return This function returns the chosen model.
#' @export
#'
train_model <- function(data, params) {

  model <- function(data, params) {
    switch(tolower(params$method_id),
           "dt"    = modellatoR::fit_decision_tree(data, params),
           "rf"    = modellatoR::fit_random_forest(data, params),
           "glm"   = modellatoR::fit_glm(data, params),
           "nn"    = modellatoR::fit_neural_net(data, params)
    )
  }

  # Deploys model
  model(data, params)
}

#### METHODS FOR TRAINING ####

#' Fits a Random Forest Model to the data.
#'
#' @param data is a data.frame or data.table containing the data.
#' @param params is a list containing the arguments necessary for training.
#' @return This function returns the chosen model.
#' @export
#'
fit_random_forest = function(data, params) {

  # If nrow(data) < rf$sampsize sets up samp_size = nrow(data)
  samp_size <- params$rf$sampsize
  if (nrow(data) < samp_size) {
    samp_size <- nrow(data)
  }

  randomForest::randomForest(formula = as.formula(params$model_formula),
                             data = data,
                             ntree = params$rf$ntree,
                             sampsize = samp_size,
                             importance = T,
                             keep.forest = T,
                             do.trace = T,
                             na.action = na.omit
  )
}

# fitDecisionTree = function(data, params) {
#   "
#   This method fits a full grown Decision Tree Model to the data.
#
#   More information about rpart at:
#   http://stat.ethz.ch/R-manual/R-patched/library/rpart/html/rpart.html
#   "
#
#   modelDT <- rpart(formula=as.formula(params$formulaModel),
#                    data=data,
#                    na.action=na.rpart,
#                    control=rpart.control(cp = 0, xval=10)
#   )
#
#   # prunes the tree according to the optimal cp
#   optimalCp <- modelDT$cptable[which.min(modelDT$cptable[,"xerror"]),"CP"]
#   modelDT.pruned <- prune(modelDT, cp=optimalCp)
# }

#
# fitGLM = function(data, params) {
#   "
#   This method fits a Generalized Linear Model to the data.
#   "
#
#   glm(formula=as.formula(params$formulaModel),
#       data=data,
#       family=params$glm$family
#   )
# }
#
# fitNeuralNet = function(data, params) {
#   "
#   This method fits a Neural Network Model to the data.
#   "
#
#   neuralnet(
#     formula="AP_DONEN ~ P_Age + dayPeriod + month",
#     data=model.matrix(object=~., data=data[1:10000, ]),
#     hidden=params$hidden,
#     stepmax=params$stepmax,
#     threshold=params$threshold
#   )
# }