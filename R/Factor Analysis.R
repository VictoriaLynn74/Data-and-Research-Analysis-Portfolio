 # Factor Analysis - KMO and Bartlett's Test
                                                                                                                          
install.packages("haven")
install.packages("psych")
library(psych)
                                                                                                                          
attach(updated_organizational_data)
                                                                                                                          
coord_model= data.frame(Operationcord, Collaborates, Efectivchange, Strategicpart, Reviewbuss, Effectivecod, Leadership )
KMO(coord_model)
bartlett.test(coord_model)
                                                                                                                          
leadership_model = data.frame(Settinggoals, Tolerance, Continousplng, Communicatn, Inyouropinion, Decisionmakn, Stronglearning)
KMO(leadership_model)
bartlett.test(leadership_model)
                                                                                                                          
orgperfom_model = data.frame(Deliveryontime, Image, Newproducts, Processes, Newcustomer, Retention, Swiftresponse, Clearlydefined)
KMO(orgperfom_model)
bartlett.test(orgperfom_model)     

# Factor Analysis

coord_fa <- fa(coord_model, nfactors = 2, rotate = "varimax") # Adjust nfactors based on your needs
print(coord_fa)
leadership_fa <- fa(leadership_model, nfactors = 2, rotate = "varimax")
print(leadership_fa)
orgperfom_fa <- fa(orgperfom_model, nfactors = 2, rotate = "varimax")
print(orgperfom_fa)
