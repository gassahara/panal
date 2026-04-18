convert                                 \    
    original.png                        \    
    \(                                  \    
       -clone 0                         \    
       -fill "#a0132e"                  \    
       -colorize 100                    \    
    \)                                  \    
    +write 0---after-aside1.png         \    
    \(                                  \    
       -clone 0,1                       \    
       +write 1---aside2-cloned.png     \    
       -compose difference              \    
       -composite                       \    
       +write 2---aside2-composite.png  \
       -separate                        \    
       +write 3---aside2-separate.png   \
       +channel                         \    
       -evaluate-sequence max           \    
       +write 4---aside2-evaluate.png   \
       -auto-level                      \    
       +write 5---aside2-autolevel.png  \   
    \)                                  \    
     +write 6---after-aside2.png        \    
     -delete 1                          \    
     +write 7---main-after-delete.png   \
     -alpha off                         \    
     -compose over                      \    
     -compose copy_opacity              \    
     -composite                         \    
     +write 8---main-composite.png      \    
    output.png

