# This function create a new folder for a new lecture

create_new_lecture <- function(folder_name, slides_name = folder_name){
    
    template_folder <- "slides/ZZZ_template"
    new_folder <- file.path("slides", folder_name)
    fs::dir_copy(template_folder, new_folder)
    
    # Renaming
    
    slides_name <- paste0(slides_name, ".Rmd")
    file.rename(file.path(new_folder, "template.Rmd"), file.path(new_folder, slides_name))
}

# update_css --------------------------------------------------------------

update_css <- function(){
    css_files <- list.files(".", recursive = TRUE, pattern = "arca.css")
    font_files <- list.files(".", recursive = TRUE, pattern = "arca_fonts.css")
    
    css_files <- css_files[!stringr::str_detect(css_files, "template")]
    font_files <- font_files[!stringr::str_detect(font_files, "template")]
    
    template_css <- "slides/0_template/resources/arca.css"
    template_font <- "slides/0_template/resources/arca_fonts.css"
    
    out <- sapply(css_files, function(x) fs::file_copy(template_css, x, overwrite = T))
    out <- sapply(font_files, function(x) fs::file_copy(template_font, x, overwrite = T))
    
    cli::cli_alert_success("CSS files updated!")
    
}


# compile_slides ----------------------------------------------------------

compile_slides <- function(slide){
    name <- basename(slide)
    rmarkdown::render(slide, quiet = T)
    cli::cli_alert_success(paste(cli::col_blue(name), "compiled!"))
}

# update_slides -----------------------------------------------------------

update_slides <- function(){
    slides <- list.files("slides/", recursive = TRUE, full.names = T, pattern = ".Rmd")
    slides <- slides[!stringr::str_detect(slides, "template")]
    out <- sapply(slides, compile_slides)
}
