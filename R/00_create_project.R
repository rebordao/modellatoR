"
A set of tools to create and manage a modellatoR project.
"

#### CREATES PROJECT ####

#' Creates a folder structure/architecture for the project.
#'
#' @param working_dir is the path of the root folder where the
#' project's folder is going to be created.
#' @param project_name is the name of the project.
#' @param project_minimal, if set to TRUE, sets up a minimal folder structure.
#' @return A folder with the project's folder structure and all the tools
#' delivered by the package `ProjectTemplate`.
#' @export
#'
create_project <- function(working_dir, project_name, project_minimal) {

  setwd(working_dir)

  # Creates a folder structure via ProjectTemplate
  ProjectTemplate::create.project(project.name = project_name,
                                  minimal = project_minimal,
                                  dump = F,
                                  merge.strategy = "require.empty")

  setwd(project_name)

  # Removes the default files in `src` and in `munge`
  for (dir_name in c("src", 'munge')) {
    do.call(file.remove, list(file.path(dir_name, list.files(dir_name))))
  }

  # Copies report files into `reports`, copies gui files into `gui`
  dir_path <- system.file(package = 'modellatoR')
  file.copy(from = file.path(dir_path, "reports"), to = './', recursive = T)
  file.copy(from = file.path(dir_path, "gui"), to = './', recursive = T)

  # Creates a configuration file `params` and saves it into `config`
  params <- list(working_dir = getwd(),
                 project_name = tail(unlist(strsplit(getwd(), '/')), 1),
                 timestamp = format(Sys.time(), "%Y%m%d_%Hh%M")
                 )
  save(object = params, file = 'config/params.rda')
}