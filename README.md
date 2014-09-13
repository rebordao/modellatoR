[![Build Status](https://travis-ci.org/rebordao/modellatoR.png)](
https://travis-ci.org/rebordao/modellatoR)

# ModellatoR

## Description

Automates some parts of an analytics process, particularly the 
deployment of a model, its testing and reporting. It's built around 
the concept that people only have to do the preprocessing and specify 
2 or 3 parameters. The rest is automatically done by our software.

It targets both power users and less knowledgable users. Power users can use 
directly the [backend](https://github.com/rebordao/modellatoR) in an R console 
or through an IDE like Rstudio, and less knowledgable users can use the 
[website](https://github.com/rebordao/modellatoR).

It's licensed under an [MIT License](http://opensource.org/licenses/MIT) and 
freely available at [github](https://github.com/rebordao/modellatoR).

It can be used for the following analyses:

- **Exploratory Analysis**  
  This describes a set of statistics and relationships among the input 
  variables.
- **Sensitivity Analysis**  
  This analyzes the contribution of the input variables towards an output 
  variable.
- **Performance Analysis**  
  This builds models and tests them. It can be used for Classification 
  and Regression tasks using the following methods:  
    - Decision Tree Models;  
    - Random Forest Models;  
    - Generalized Linear Models.

## Revisions

Check `NEWS.md` for information about this.

## Usage

#### Of the Backend

You can use it to create and setup projects, to train and test statistical 
models and also to generate automatic reports.

Typically you start by creating a folder structure using the function 
`modellatoR::create_project` and by doing its setup with the function 
`modellatoR::setup_project`. Now you have a folder structure similar to 
the one described in section `Project's Folder Structure`, and you can 
use this folder structure and its tools for your analytics process.

After these 2 steps you place the raw data in folder `data` and then if you 
load the project (`ProjectTemplate::load.project()`), the data will be 
imported automatically, and the scripts located in `munge` will be executed 
sequentially to preprocess and clean this data. Please note that either you
need to feed clean raw data in folder `data` or you need to do these 
preprocessing scripts. 

At this step the preprocessed resulting data structures can be optionally 
written into `cache` for future faster access. The preprocessed data is 
also loaded in the Environment and ready to be analysed through the 
scripts of `src`. The whole process is controlled by `config/global.dcf` 
and the reports are written into `reports`. 

The model's parameters are defined in `config/params.RData`. If you need to 
change them, edit the list `params` accordingly and then save it into 
file `config/params.RData`. 

If you need to change the report, adapt the corresponding Rmd file in `reports`.

Check section `Project's Folder Structure` for more information.

#### Of the GUI

In folder `gui` there is a Web Demo built using 
[Shiny](http://shiny.rstudio.com/). To deploy it go to the root folder of the 
package and execute:

```
library(shiny)
runApp('gui')
```

Then your browser will open the modellatoR's GUI in a new tab. Fill in the 
sidebar with the requested information, click in `Generate Report`and wait 
for the report to be ready. It will be downloaded automatically.

## Project's Folder Structure

The folder structure is built on top of one created by 
[ProjectTemplate](http://projecttemplate.net/) and consists of the following:

- `cache`  
Here you'll store any data sets that are generated during a preprocessing 
step and don't need to be regenerated every single time you analyze your data. 
You can use the `cache()` function to store data to this directory 
automatically. Any data set found in both the cache and data directories will 
be drawn from cache instead of data based on ProjectTemplate's priority rules.

- `config`  
Here you'll store any configurations settings for your project.

- `data`  
Here you'll store your raw data files. If they are encoded in a supported 
file format, they'll automatically be loaded when you call `load.project()`.

- `gui`  
Here are the files for the graphical interface.

- `munge`  
Here you can store any preprocessing or data munging code for your project. 
For example, if you need to add columns at runtime, merge normalized data 
sets or globally censor any data points, that code should be stored in the 
munge directory. The preprocessing scripts stored in munge will be executed 
sequentially when you call `load.project()`, so you should append numbers 
to the filenames to indicate their sequential order.

- `reports`  
Here are the report templates and the reports generated within the project.

- `src`  
Here you'll store your final statistical analysis scripts. You should add 
the following piece of code to the start of each analysis script: 
`library('ProjectTemplate); load.project()`.

[ProjectTemplate](http://projecttemplate.net/) is intended to create 
statistical analysis projects and provides template code for data 
diagnostics, data munging, code profiling and unit testing. For its 
usage please check:  
- [Getting Started](http://projecttemplate.net/getting_started.html)  
- [Mastering Project Template](http://projecttemplate.net/mastering.html)

## Authors

This package was made by [Antonio Rebordao](https://www.linkedin.com/in/rebordao).

I would like to acknowledge my employer [Mentis SA](
http://www.mentis-consulting.be/) for supporting this project.

## License

This software is licensed under a MIT License. Check the file `license.txt` 
for more details.
