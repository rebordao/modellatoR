
# Loads data
data(cancer_w)

# Creates a cutoff to divide the data intro trainset and testset
cutoff <- round(.7 * nrow(cancer_w))

# Does trainset
trainset <- subset(cancer_w, 1:nrow(cancer_w) < cutoff)

# Does testset
testset <- subset(cancer_w, 1:nrow(cancer_w) >= cutoff)

# Creates a temporary dir to store the modellatoR project
temp_dir <- tempdir()

# Creates the modellatoR project,
# for your projects choose an appropiate working_dir and project_name
modellatoR::create_project(working_dir = temp_dir,
                           project_name = "demo_classification",
                           project_minimal = T)

# The modellatoR project is the framework for our analytics process,
# check the content of temp_dir to see its structure and tools.
# Read carefully how to use this framework and its tools.
print(temp_dir)

# It's files are as follows:
list.files(file.path(temp_dir, "demo_classification"), recursive = T)

# Setups model, defines method and the output variable, saves into params.RData
modellatoR::setup_project(data = trainset,
                          method_id = 'rf',
                          out_var = 'Class')

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
  input = file.path(getwd(), 'reports/classification_report.Rmd'),
  output_file = paste0(params$method_id, '_', params$timestamp, '.html')
)
