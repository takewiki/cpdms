




# Hello
# Hello
# Hello
## Hello
 Hello
insertText("# Hello\n")


# Hel# Hello
# Hello
# Hello
# Hello
# Hello
lo






















documentId(allowConsole = T)


library(rstudioapi)

#insert at the 1st row
insertText(c(1,1),"# Hello\n")
#insert aat the last row
insertText(Inf,text = "# Hello\n")

pos <- Map(c, 1:5, 1)
pos
insertText(pos, "# ")


rng <- Map(c, Map(c, 1:5, 1), Map(c, 1:5, 3))
rng
modifyRange(rng, "")



#close the file
rstudioapi::documentClose()

?rstudioapi::insertText()
# Hello
# Hello
# Hello
# Hello
# Hello
# Hello
