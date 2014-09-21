library(modellatoR)
context("Folder's Structure Integrity")

# Creates a modellatoR's project, with its folder structure
modellatoR::create_project(working_dir = tempdir(),
                           project_name = "test",
                           project_minimal = T)

# Tests if the project's folder structure exists
test_that("folder structure doesn't exist", {
  expect_output(list.files(tempdir()), "test")
})

# Loads params
load(file.path(tempdir(), "test", "config", "params.RData"))

# Checks if the file params.RData and its vars exist
test_that("params.RData doesn't exist or has missing variables", {
  expect_output(list.files(file.path(tempdir(), "test", "config")), "params")
  expect_output(str(params), "List of 3")
})

# Removes folder structure
unlink(file.path(tempdir(), "test"), recursive = T)
