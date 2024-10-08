# Contributing to howto

This outlines how to propose a change to howto.
For a detailed discussion on contributing to this and other tidyverse packages, please see the [**epiverse-trace contributing guide**](https://github.com/epiverse-trace/.github/blob/main/CONTRIBUTING.md) and the [tidyverse code review principles](https://code-review.tidyverse.org/).

## Fixing typos

You can fix typos, spelling mistakes, or grammatical errors in the documentation directly using the GitHub web interface, as long as the changes are made in the _source_ file. 
<!--This generally means you'll need to edit [roxygen2 comments](https://roxygen2.r-lib.org/articles/roxygen2.html) in an `.R`, not a `.Rd` file. 
You can find the `.R` file that generates the `.Rd` by reading the comment in the first line.-->

## Bigger changes

If you want to make a bigger change, it's a good idea to first file an issue and make sure someone from the team agrees that it’s needed. 
If you’ve found a bug, please file an issue that illustrates the bug with a minimal 
[reprex](https://www.tidyverse.org/help/#reprex) (this will also help you write a unit test, if needed).
See our guide on [how to create a great issue](https://code-review.tidyverse.org/issues/) for more advice. 
You can also check out the [How to make a reproducible R code example](https://community.appliedepi.org/t/how-to-make-a-reproducible-r-code-example/167/1) of the AppliedEpi community site.

### Pull request process

*   Fork the project and clone onto your computer. If you haven't done this before, we recommend using `usethis::create_from_github("epiverse-trace/howto", fork = TRUE)`.

*   Install all development dependencies with `renv::restore()`. 

<!--and then make sure the package passes R CMD check by running `devtools::check()`. 
    If R CMD check doesn't pass cleanly, it's a good idea to ask for help before continuing. -->

*   Create a Git branch for your pull request (PR). We recommend using `usethis::pr_init("brief-description-of-change")`.

*   Make your changes following the steps in **add a new `howto` entry** (detailed below).

*   Commit to git, and then create a PR by running `usethis::pr_push()`, and following the prompts in your browser.
    The title of your PR should briefly describe the change.
    The body of your PR should contain `Fixes #issue-number`.

<!--*  For user-facing changes, add a bullet to the top of `NEWS.md` (i.e. just below the first header). Follow the style described in <https://style.tidyverse.org/news.html>.-->

### Add a new `howto` entry

After following the steps above:

#### 1. Find your folder

Folder names corresponds to each task (box) of the [pipeline roadmap](https://epiverse-trace.github.io/getting-started.html#roadmap) within the `analyses/` folder:

  - `read_cases/` → Read case data
  - `describe_cases/` → Describe case data
  - `reconstruct_transmission/` → Reconstruct transmission chains
  - `estimate_severity/` → Estimate severity
  - `forecast_cases/` → Create short-term forecast
  - `quantify_transmission/` → Quantify transmission
  - `read_population/` → Read population data
  - `simulate_transmission/` → Simulate transmission scenarios
  - `compare_intervention/` → Compare intervention scenarios
  - `read_intervention/` → Read intervention data
  - `compare_economic/` → Compare economic impacts

#### 2. Reuse a template

Create a new `howto` entry. 

- Copy and rename the [`template-package_action.qmd`](https://github.com/epiverse-trace/howto/blob/main/internal/template-package_action.qmd) file from the `internal/` folder.
- This template already has the components to obtain a standard output across entries, and writing suggestions.
- We suggest to name your file with the key words of the actions/verbs to solve the question. Use the snake case [naming standard](https://devguide.ropensci.org/building.html?q=snake#function-and-argument-naming).

#### 3. Write your content

We propose to use a minimal template. This is open to adapt for the needs of the entry.

- Content can resemble a recipe:
  - Ingredients → Use nouns. (wanted)
  - Steps in code → Use active verbs. (wanted)
  - Steps in detail → Use active verbs. (optional)

- One reference example is in: [`incidence_convert_between_inc1_inc2.qmd`](https://github.com/epiverse-trace/howto/blob/5004d91ef22c63e8682878683d947dc75c96b8d4/internal/incidence_convert_between_inc1_inc2.qmd#L14-L21)

#### 4. Reuse existing data

To read data we suggest to rely on data already available in an R package like in `{outbreaks}` or similar. 

Save any new input data in the `data/` folder.

Optionally, one alternative to read data can be:

- Copy the [View Raw](https://docs.github.com/en/enterprise-cloud@latest/repositories/working-with-files/using-files/viewing-a-file) link to make it directly 
- Read data from that link. (Example in template)

#### 5. Build locally 

Use the [**Render** button](https://quarto.org/docs/get-started/hello/rstudio.html#rendering) in the RStudio IDE to render the file and preview the output with a single click or keyboard shortcut (⇧⌘K).

To render the whole website, use the **Render Website** button within the [Build pane](https://docs.posit.co/ide/user/ide/guide/ui/ui-panes.html).

If the task (folder) of your entry is not listed in the `index.qmd` page, First, add a new task entry to the `listing:` section in the YAML on top. In the template below, edit the `id:` and `contents:` with for the corresponding task (folder name). For example, for the task `"Describe case data"` with used as ID `describe-cases` and detailed the folder path `analyses/describe_cases/*.qmd`:

```
listing: 
  - id: describe-cases
    contents: "analyses/describe_cases/*.qmd"
    type: table
    fields: [title]
```

Second, to make the listing visible in the website, add a subtitle with the task name (`Describe case data`) and refer to the ID (`describe-cases`) in the following format:

```
## Describe case data

:::{#describe-cases}
:::
```

#### 6. Add new packages to renv

We use the [{renv} R package](https://rstudio.github.io/renv/) to ensure reproducibility of the how-to guides we are providing. All packages used in this repository are registered in the [`renv.lock`](https://github.com/epiverse-trace/howto/blob/main/renv.lock) file.

Add all new packages that your specific `howto` entry needs. After installing the packages, follow these steps:

- First, use `renv::status()` to detect any pre-existing issue.
  - Issues with packages not related to your specific `howto` entry should be solved in a different PR.

- Second, use `renv::snapshot()` to update packages in the lockfile (`renv.lock`). You should read your packages (and occasionally its dependencies) listed before confirming to proceed.

Now you should be ready to create a PR (steps above!).

### Keep the reproducible environment updated

We need to keep the `renv.lock` file and the version of the`{renv}` package frequently updated. This will help us know of breaking changes in packages under development. For this we:

- Use `renv::update()` to update all packages registered in the `renv.lock` currently out-of-date.
- Use `renv::upgrade()` to upgrade the version of `{renv}` associated with the project, updates the activate script, and restarts R.

Any of these actions needs be done in an isolated PR.

### Code style

-   New code should follow the tidyverse [style guide](https://style.tidyverse.org). 
    You can use the [styler](https://CRAN.R-project.org/package=styler) package to apply these styles, but please don't restyle code that has nothing to do with your PR. 

- Each howto entry should include __one chunk only__. This aims to be ready to copy and paste as a whole, resembling a reprex. For this reason, the howto entry chunk:
  - __Can not__ include intermediate plots. Chunks can only include one plot at the end of the chunk. To compare plots, use the [patchwork](https://patchwork.data-imaginist.com/) R package to add `ggplot` objects together using the `+` operator. 
  - __Can__ include intermediate output prints. You can avoid long output prints using `<tibbles>` with `dplyr::as_tibble()` or `head()`.

<!--*  We use [roxygen2](https://cran.r-project.org/package=roxygen2), with [Markdown syntax](https://cran.r-project.org/web/packages/roxygen2/vignettes/rd-formatting.html), for documentation.  

*  We use [testthat](https://cran.r-project.org/package=testthat) for unit tests. 
   Contributions with test cases included are easier to accept.  -->

## Code of Conduct

Please note that the howto project is released with a
[Contributor Code of Conduct](CODE_OF_CONDUCT.md). By contributing to this
project you agree to abide by its terms.
