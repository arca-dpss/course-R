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


# compile_file ----------------------------------------------------------

compile_file <- function(slide){
    name <- basename(slide)
    rmarkdown::render(slide, quiet = T)
    cli::cli_alert_success(paste(cli::col_blue(name), "compiled!"))
    
    if(stringr::str_detect(slide, "slides")){
        slide <- str_replace(slide, ".Rmd", ".html")
        pagedown::chrome_print(slide)
    }
}

# update_material -----------------------------------------------------------

update_material <- function(){
    material <- list.files(".", recursive = TRUE, full.names = T, pattern = ".Rmd")
    material <- material[!stringr::str_detect(material, "template")]
    out <- sapply(material, compile_file) %>% suppressWarnings()
}

# put_random_na -----------------------------------------------------------

put_random_na <- function(data, n){
    
    pos <- list(rows = 1:nrow(data),
                cols = 1:ncol(data))
    
    pos <- expand.grid(pos)
    
    na_pos <- sample(1:nrow(pos), n)
    
    for (i in 1:length(na_pos)) {
        
        na_pos_i <- pos[na_pos[i], ]
        
        data[na_pos_i[[1]], na_pos_i[[2]]] <- NA
        
    }
    
    return(data)
    
}