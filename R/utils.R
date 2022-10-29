# update_material -----------------------------------------------------------

update_material <- function(path, to_pdf = FALSE){
    materials <- list.files(path, recursive = TRUE, full.names = TRUE, pattern = ".Rmd")
    out <- purrr::walk(materials, compile, to_pdf)
}

# compile -----------------------------------------------------------------

compile <- function(file, pdf = FALSE){
    html <- suppressWarnings(rmarkdown::render(file, clean = TRUE, quiet = TRUE))
    if(pdf) {
        renderthis::to_pdf(html)
    }
    cli::cli_alert_success(paste(file, "compiled! :)"))
}