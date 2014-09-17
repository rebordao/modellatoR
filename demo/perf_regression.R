
# Loads data
data(boston)

# Creates a cutoff to divide the data intro trainset and testset
cutoff <- round(.7 * nrow(boston))

# Does trainset
trainset <- subset(boston, 1:nrow(boston) < cutoff)

# Does testset
testset <- subset(boston, 1:nrow(boston) >= cutoff)

# Creates a temporary dir where to store the modellatoR project
temp_dir <- tempdir()

# Deletes temp_dir if it already exists
unlink(file.path(temp_dir, '*'))

# Creates the modellatoR project
modellatoR::create_project(working_dir = temp_dir,
                           project_name = "demo_regression",
                           project_minimal = T)

# The modellatoR project is the framework for our analytics process,
# check the content of temp_dir to see its structure and tools.
print(temp_dir)

# It's files are as follows:
list.files(file.path(temp_dir, "demo_regression"), recursive = T)

# Setups model, defines method and the output variable, saves into params.RData
modellatoR::setup_project(data = trainset,
                          method_id = 'rf',
                          out_var = 'medv')

# Reads Setup from file
load(paste0(getwd(), "/config/params.RData"))

# Training
model <- modellatoR::train_model(trainset = trainset,
                                 testset = testset,
                                 params = params)

# Testing
output <- modellatoR::test_model(model = model,
                                 params = params,
                                 testset = testset)

# Generates report and saves it into 'reports'
rmarkdown::render(
  input = file.path(getwd(), 'reports/regression_report.Rmd'),
  output_file = paste0(params$method_id, '_', params$timestamp, '.html')
)
