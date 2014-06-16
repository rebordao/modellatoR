
# Loads data
data(blabla)
data(blabla)

# Creates project
modellatoR::create_project(working_dir = getwd(),
                           project_name = "wee",
                           project_minimal = T)

# Setups model and creates params.rda
modellatoR::setup_model(data = blabla,
                        method_id = 'rf',
                        out_var = 'blabla')

# Reads configuration
load(paste0(getwd(), "/config/params.rda"))

# Training
model <- modellatoR::train_model(data = blabla,
                                 params = params)

# Testing
modellatoR::test_model(model = model,
                       params = params,
                       testset = blabla)

# Generates report and saves it into 'reports'
rmarkdown::render(
  input = paste0(getwd(), '/reports/regression_report.Rmd'),
  output_file = paste0(params$method_id, '_', params$timestamp, '.html')
)