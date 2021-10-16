# This function create a new folder for a new lecture

create_new_lecture <- function(folder_name, slides_name = folder_name){
    
    template_folder <- "slides/ZZZ_template"
    new_folder <- file.path("slides", folder_name)
    fs::dir_copy(template_folder, new_folder)
    
    # Renaming
    
    slides_name <- paste0(slides_name, ".Rmd")
    file.rename(file.path(new_folder, "template.Rmd"), file.path(new_folder, slides_name))
}
