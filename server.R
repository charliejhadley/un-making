function(input, output, session){
  
  
  # observe({
  #   req(input$gallery_click_id)
  #   req(input$gallery_click_value)
  #   
  #   print(input$gallery_click_id)
  #   print(input$gallery_click_value)
  # })
  
  observeEvent(input$gallery_click_value, {
    print(input$gallery_page_range)
    showModal(modalDialog(
      title = str_glue("You just clicked image {input$gallery_click_value}"),
      input$gallery_click_id,
      easyClose = TRUE,
      footer = NULL
    ))
  })
  
  output$gallery <- renderGallery({
    gallery(tib_images, height = 150, options = list(
      "detailsLabel" = "Details",
      "titleLabel" = "Title", "subtitleLabel" = "Subtitle"
    ))
  })
  
  
}