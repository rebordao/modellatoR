library(modellatoR)
context("Functional Training")

# Creates a modellatoR's project, with its folder structure
modellatoR::create_project(working_dir = tempdir(),
                           project_name = "test",
                           project_minimal = T)

# Setups project
data(boston)
modellatoR::setup_project(data = boston, method_id = "rf", out_var = "medv")

# Loads params
load(file.path(tempdir(), "test", "config", "params.RData"))

# Trains model
cutoff <- round(.8 * nrow(boston))
model <- modellatoR::train_model(
  trainset = subset(boston, 1:nrow(boston) < cutoff),
  testset = subset(boston, 1:nrow(boston) >= cutoff),
  params = params)

# Gets y estimated
y_est <- predict(model, newdata = subset(boston, 1:nrow(boston) >= cutoff))

test_that("y estimated is not of the proper class", {
  if (params$regression) expect_is(y_est, "numeric")
  if (params$classification) expect_is(y_est, "factor")
})

# Removes folder structure
unlink(file.path(tempdir(), "test"), recursive = T)
