#' Creates the setup of the project.
#'
#' @param data is a data.frame or data.table containing the data.
#' @param method_id is a method for training. Needs to be one
#' of the following: 'dt', 'rf', 'glm', 'nn'. These acronyms correspond to:
#' \itemize{
#'   \item dt: Decision Trees Model
#'   \item rf: Random Forest Model
#'   \item glm: Generalized Liner Model
#'   \item nn: Neural Network Model
#' }
#' @param out_var is the target variable that the model tries to estimate.
#' @return Writes the model's params to a config file at `config/params.R`.
#' @export
#'
setup_project <- function(data, method_id, out_var) {

  # Checks if method_id is valid
  if (!(tolower(method_id) %in% c('dt', 'rf', 'glm', 'nn'))) {
    stop("Needs to be one of the following methods: 'dt', 'rf', 'glm', 'nn'")
  }

#   # Checks if out_var is valid
#   if (!(out_var %in% colnames(data))) {
#     stop(paste0("Needs to be one of the following variables: ",
#                 paste0(colnames(data), collapse = ', ')))
#   }

  # Reads from file
  load(file.path(getwd(), "/config/params.RData"))

  params$method_id <- tolower(method_id)
  params$out_var <- out_var

  # Builds formula for the model
  params$model_formula <- paste(params$out_var, "~ .")

  # Stores predictors's names
  params$predictors <- colnames(data)[-which(colnames(data) %in% params$out_var)]

  # Stores model's name
  params$model_name <- paste0("model_", params$method_id)

  # Sets up the name of the method used for the training
  params$method_name <- switch(params$method_id,
                               "dt"   = "Decision Trees",
                               "rf"   = "Random Forest",
                               "glm"  = "Generalized Liner Regression",
                               "nn"   = "Neural Network"
  )

  # Sets up the type of task (classification or regression)
  params$classification <- F
  if (class(params$out_var) == 'factor') {
    params$classification <- T
  }
  params$regression <- !params$classification

  # Sets up some arguments of the method used for the training
  # TODO: try to find a better way

  if (params$method_id == 'rf') {
    # Random Forest Model
    params$rf <- list(ntree = 10, sampsize = 10000)

  } else if (params$method_id == 'glm') {
    # Generalized Liner Model
    params$glm <- list(family = 'gaussian')

  } else if (params$method_id == 'nn') {
    # Neural Network Model
    params$nn <- list(hidden = 10, stepmax = 100, threshold = 0.01)
  }

  save(object = params, file = 'config/params.RData')
}
