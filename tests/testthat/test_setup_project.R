library(modellatoR)
context("Project's Setup Integrity")

# Creates a modellatoR's project, with its folder structure
modellatoR::create_project(working_dir = tempdir(),
                           project_name = "test",
                           project_minimal = T)

# Setups project
data(boston)
modellatoR::setup_project(data = boston, method_id = "rf", out_var = "medv")

# Loads params
load(file.path(tempdir(), "test", "config", "params.RData"))

# Checks if the file params.RData and its vars exist
test_that("params.RData doesn't exist or has missing variables", {
  expect_output(list.files(file.path(tempdir(), "test", "config")), "params")
  expect_output(str(params), "List of 12")
})

# Removes folder structure
unlink(file.path(tempdir(), "test"), recursive = T)
