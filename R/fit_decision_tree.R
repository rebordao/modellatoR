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