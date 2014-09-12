"
A set of tools for training a model.
"

#### TRAINING ####

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

#### METHODS FOR TRAINING ####

#' Fits a Random Forest Model to the data.
#'
#' @param trainset is a data.frame or data.table containing the train data.
#' @param testset is a data.frame or data.table containing the test data.
#' @return This function returns the chosen model.
#' @export
#'
fit_random_forest = function(trainset, testset, params) {

  # If nrow(data) < rf$sampsize then samp_size = nrow(trainset)
  samp_size <- ifelse(
    nrow(trainset) < params$rf$sampsize, nrow(trainset), params$rf$sampsize)

  randomForest::randomForest(
    x = subset(trainset, select = !(colnames(trainset) %in% params$out_var)),
    y = trainset[[params$out_var]],
    xtest = subset(testset, select = !(colnames(testset) %in% params$out_var)),
    ytest = testset[[params$out_var]],
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