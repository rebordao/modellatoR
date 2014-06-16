
# Loads data
data(cancer_w_trainset)
data(cancer_w_testset)

# Creates project
modellatoR::create_project(working_dir = getwd(),
                           project_name = "wee",
                           project_minimal = T)

# Setups model and creates params.rda
modellatoR::setup_model(data = cancer_w_trainset,
                        method_id = 'rf',
                        out_var = 'Class')

# Reads configuration
load(paste0(getwd(), "/config/params.rda"))

# Training
model <- modellatoR::train_model(data = cancer_w_trainset,
                                 params = params)

# Testing
modellatoR::test_model(model = model,
                       params = params,
                       testset = cancer_w_testset)

# Generates report and saves it into 'reports'
rmarkdown::render(
  input = paste0(getwd(), '/reports/classification_report.Rmd'),
  output_file = paste0(params$method_id, '_', params$timestamp, '.html')
)