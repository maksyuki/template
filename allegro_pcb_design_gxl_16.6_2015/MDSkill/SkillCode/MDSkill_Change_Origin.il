
/*
#########################################################################################                                                                    
#                  	Command: MDCH                                     					#
#                  	Skill File: MDSkill_Change_Origin.il                   			#
#                  	How To Load: Command> (load("MDSkill_Change_Origin.il"))			#
#               	How To Execute: Command> MDCH  			   							#
#########################################################################################
*/
axlCmdRegister( "MDCH" `MDSkill_Change_Origin)


(defun MDSkill_Change_Origin ()
		points1 = nil
		points2 = nil
       axlClearSelSet()
       axlSetFindFilter(?enabled `("PINS") ?onButtons `("PINS"))
       points1 = axlEnterPoint()
	   
       p_s1 = axlSingleSelectPoint(points1)
	   
	   
       if( p_s1 
           then 
             pins = axlGetSelSet() 
             apin = car(pins)
             xpos1 = car(apin->xy)
             ypos1 = cadr(apin->xy)
            ; axlClearSelSet()
             axlSetFindFilter(?enabled `("PINS") ?onButtons `("PINS"))
			 
			 ;printf("--xpos1---%f  :  %f----ypos1--\n" xpos1 ypos1)
			 axlDBRefreshId(apin)
			 axlDBRefreshId(pins)
			 axlDBRefreshId(t)
             points2 = axlEnterPoint()
             p_s2 = axlSingleSelectPoint(points2)
             if( p_s2 
               then 
                 pins = axlGetSelSet() 
                 apin = car(pins)
                 xpos2 = car(apin->xy)
                 ypos2 = cadr(apin->xy)
                 x_o = (xpos1+xpos2)/2
                 y_o = (ypos1+ypos2)/2
                 axlDBChangeDesignOrigin(-x_o:-y_o)
				 axlDBRefreshId(apin)
				 axlDBRefreshId(pins)
				 axlDBRefreshId(t)
                 ;printf("++++++xpos1+++%f  :  %f+ypos1+++\n" xpos1 ypos1)
                 ;printf("+++++xpos2+++%f  :  %f+++++ypos2+++\n" xpos2 ypos2)
                 ;printf("+++++x_o++++%f  :  %f+++++y_o++++" x_o y_o)
              )
          )		 	  
)

        
