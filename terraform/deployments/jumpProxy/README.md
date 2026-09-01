# Post deployment actions 

1. Make sure the IP address of the new host fits into CIDR blocks of Security Groups intended  to provide SSH access. 
2. Configure DNS to resolve the hostnames of the jump hosts created, so that jump host can be accessed from outside using its host name ( like $ jump coast@tvxjmp-dw-c30001-b.do.xcal.tv ) 

