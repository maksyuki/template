/*
#########################################################################################                                                                    
#                  	Command: MDKP                                     					#
#                  	Skill File: MDSkill_Keepout.il                   					#
#                  	How To Load: Command> (load("MDSkill_Keepout.il"))				#
#               	How To Execute: Command> MDKP  			   							#
#               	Write by:: Karthikeyan.K 				   							#
#########################################################################################
*/

axlCmdRegister("MDKP" 'MDSkill_Keepout ?cmdType "interactive")

procedure( MDSkill_Keepout()

	radius=axlEnterString(?prompts list("Enter radius of antipad:"))

	radius=atof(radius)

	axlSetFindFilter(?enabled list("noall" "pins") ?onButtons list("noall" "pins"))


	axlSelect()

	pin_dbids=axlGetSelSet()

	foreach(one pin_dbids

		pin_loc=one->xy


		x1=nth(0 pin_loc)
		y1=nth(1 pin_loc)

		path = axlPathStartCircle(list(x1:y1, radius) 0) 

		shape=axlDBCreateShape(path t "Route Keepout/All")

	)
	axlDBRefreshId(pin_dbids)
	axlDBRefreshId(t)

)

