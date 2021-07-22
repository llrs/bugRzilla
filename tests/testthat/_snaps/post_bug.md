# post_bug() works [plain]

    Code
      expect_type(pg, "list")

# post_bug() fails [plain]

    Code
      expect_error(post_bug("This is the test description", "TEST!!!"),
      "Do it and then return please.")
    Message <cliMessage>
      > Please, pick a component:
    Output
      
       1: Accuracy                      2: Add-ons                    
       3: Analyses                      4: Documentation              
       5: Graphics                      6: I/O                        
       7: Installation                  8: Language                   
       9: Low-level                    10: Mac GUI/Mac specific       
      11: Misc                         12: Models                     
      13: S4methods                    14: Startup                    
      15: System-specific              16: Translations               
      17: Windows GUI/Window specific  18: Wishlist                   
      
      
      -- Documentation ---------------------------------------------------------------
    Message <cliMessage>
      > Have you read the documentation recently?
    Output
      (0 to cancel)
      
      1: Yup
      2: Negative
      3: Nope
      
    Message <cliMessage>
      v Opening documentation...

