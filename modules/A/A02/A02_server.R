var_A02_msg_tip = var_text('A02_msg_tip')
observeEvent(input$A02_click,{
  msg = var_A02_msg_tip()
  pop_notice(msg)
  
})