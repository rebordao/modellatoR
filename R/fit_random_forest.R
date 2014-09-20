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