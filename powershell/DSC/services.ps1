Configuration CheckIWSServices {

    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Node DK01SV9041 {
        
        Service IWS_Service 
            {
                Name = "tws_cpa_agent_scdom_pdtau"
                Ensure = "Present"
            }
                   
    }

}

CheckIWSServices DK01SV9041
