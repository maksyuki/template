/*
#################################################################################                                                                    
#                  	Command: MDED                                     			#
#                  	Skill File: MDSkill_Export_Device.il                   	#
#                  	How To Load: Command> (load("MDSkill_Export_Device.il"))	#
#               	How To Execute: Command> MDED  			   					#
#              	 	Write by: deargds            								#
#################################################################################
*/
axlCmdRegister( "MDED" 'MDSkill_Export_Device ?cmdType "general")

defun( MDSkill_Export_Device ()
prog(()
        dra_list =  rexMatchList(".dra$" getDirFiles(".\\"))
        foreach( p dra_list
                when( axlOpenDesign(?design p ?mode "wf") 
                        when( axlDesignType(t) == "PACKAGE"
                                ScriptFileName = axlTempFile()
                                Script_File = axlDMOpenFile("TEMP", ScriptFileName, "w") 
                                        
                                fprintf(Script_File "scriptmode +i\n\n")
                                fprintf(Script_File "setwindow pcb \n")
                                fprintf(Script_File "create device \n")
                                fprintf(Script_File "setwindow form.crdevice \n")
                                fprintf(Script_File "FORM crdevice done \n")
                                fprintf(Script_File "setwindow pcb \n")
                                
                                axlDMClose(Script_File) 
                                sprintf(runScript, "replay %s" , ScriptFileName) 
                                axlShell(runScript)
                        )
                )
        )
))
