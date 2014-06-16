ModellatoR
==========

## Description

[modellatoR](https://github.com/rebordao/modellator) is a tool for semi-automatic supervised statistical analysis that allows people to understand better their data. It's built around the concept that people only have to do the preprocessing and choose a model. The rest is automatically done by our software.

It targets both power users and people with limited knowledge in Statistical Learning. Power users can use directly the [backend](https://github.com/rebordao/modellatoR) in an R console (or through an IDE like [Rstudio](http://www.rstudio.com/)), and less knowledgable users can use the [GUI](https://github.com/rebordao/modellatoR).

It's licensed under [The MIT License](http://opensource.org/licenses/MIT) and freely available at [github](https://github.com/rebordao/modellatoR).

## Revisions

Check `NEWS.md` for information about this.

## Usage

You can use it for the following analyses:

- **Exploratory Analysis**
    - This illustrates a set of statistics and relationships between the input variables.
- **Sensitivity Analysis**
    - This explores the contribution of the input variables towards an output variable.
- **Performance Analysis**
    - This builds models that can be applied to new data where we don't know the output variable but would like to know it. It can be used both for Classification and Regression tasks using the following methods:
        - Decision Trees;
        - Random Forests;
        - General Linear Models;
        - Neural Networks.

#### Of the Backend

Basically you place the raw data in folder `data` and now, if you load the project (`load.project()`), the data will be imported automatically, and the scripts located in `munge` will be executed sequentially to preprocess the data. At this step the preprocessed resulting files can be optionally written into `cache` for future faster access. The preprocessed data is also loaded in the Environment and ready to be analysed through the scripts of `src`. The whole process is controlled by `config/global.dcf` and the reports are written into `reports`. The models' parameters are defined in `config/params.R`.

To get more information about this dataflow and framework, check the section `Architecture` below.

#### Of the GUI

In folder `gui` there is a Web Demo built using [Shiny](http://shiny.rstudio.com/). To deploy it go to the library's root folder and execute:

```
library(shiny)
runApp('web')
```

Then your browser will open the modellatoR's GUI in a new tab. On the left side bar fill in top down the requested information, execute the analysis and wait a bit for the report to be ready.

## Layout

```
/modellatoR
  /cache
  /config
    global.cfg
    params.R
  /data
  /lib
    trainers.R
  /munge
    00_PreProcessesData.R
    01_DoesTrainTestSets.R
  /reports
    /ExploratoryAnalysis
    exploratoryTemplate.Rnw
    /PerformanceAnalysis
    classificationTemplate.Rnw
    regressionTemplate.Rnw
    /SensitivityAnalysis
    sensitivityTemplate.Rnw
  /src
    00_SetsProject.R
    01_ExploratoryAnalysis.R
    02_SensitivityAnalysis.R
    03_PerformanceAnalysis.R
  license.txt
  README.md
  .gitignore
```

To understand better the layout, please check the next section.

## Architecture

The architecture of this library is the following:

- `cache`  
Here you'll store any data sets that are generated during a preprocessing step and don't need to be regenerated every single time you analyze your data. You can use the cache() function to store data to this directory automatically. Any data set found in both the cache and data directories will be drawn from cache instead of data based on ProjectTemplate's priority rules.

- `config`  
Here you'll store any configurations settings for your project. Use the DCF format that the read.dcf() function parses.

- `data`  
Here you'll store your raw data files. If they are encoded in a supported file format, they'll automatically be loaded when you call load.project().

- `gui`
Here there are the files for the shiny app.

- `lib`  
Here you'll store any files that provide useful functionality for your work, but do not constitute a statistical analysis per se.

- `logs`
Here there are stored the output of the Log System.

- `munge`  
Here you can store any preprocessing or data munging code for your project. For example, if you need to add columns at runtime, merge normalized data sets or globally censor any data points, that code should be stored in the munge directory. The preprocessing scripts stored in munge will be executed sequentially when you call load.project(), so you should append numbers to the filenames to indicate their sequential order.

- `reports`  
Here you can store any output reports made using the package `knitr`.

- `src`  
Here you'll store your final statistical analysis scripts. You should add the following piece of code to the start of each analysis script: library('ProjectTemplate); load.project(). You should also do your best to insure that any code that's shared between the analyses in src is moved into the munge directory; if you do that, you can execute all of the analyses in the src directory in parallel.

This architecture was created by the package [ProjectTemplate](http://projecttemplate.net/). This package is intended to create statistical analysis projects and provides template code for data diagnostics, data munging, code profiling and unit testing. For its usage please check:  
- [Getting Started](http://projecttemplate.net/getting_started.html)  
- [Mastering Project Template](http://projecttemplate.net/mastering.html)

## Authors

This utility was written by [Antonio Rebordao](https://www.linkedin.com/in/rebordao).

I would like to acknowledge my employer Mentis SA for supporting this project.

## License

This software is licensed under The MIT License. Check the file `license.txt` for more details.
