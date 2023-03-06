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

link <- function(link, text = NULL){
    text <- ifelse(is.null(text), link, text)
    sprintf("[%s](%s)", text, link)
}

cap_link <- function(link, text = NULL){
    if (is.null(text)) {
        text <- link
    }
    sprintf('<a href="%s">%s</a>', link, text)
}

iframe <- function(link, w, h){
    sprintf('<iframe src="%s" width="%s" height="%s" frameBorder="0"></iframe',
            link, w, h)
}

# chunk

chunk <- function(x){
    txt <- "```{r, echo = FALSE, result = 'asis'}\n%s\n```\n"
    cat(sprintf(txt, x))
}

# questions

questions <- function(){
    cat("# Questions?\n\n")
    cat(iframe("https://giphy.com/embed/ZNnQvIYzIBmZAbrBR7",400, 300))
}