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