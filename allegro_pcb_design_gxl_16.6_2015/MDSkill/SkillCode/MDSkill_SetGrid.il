/*
#############################################################################                                                                    
#                   Command: MDG x x                                    	#
#                   Skill File: MDSkill_SetGrid.il                       	#
#                  	How To Load: Command> (load("MDSkill_SetGrid.il"))    #
#               	How To Execute: Command> MDG x x  			   			#
#               	Write by Rock.guo@2007.09.13 					        #
#############################################################################
*/

axlCmdRegister( "MDG" 'MDSkill_SetGrid)

defun( MDSkill_SetGrid (@optional (n_e "") (a_e "") (n1 "") (n2 ""))
 
cond( 
		((n_e != "")&&(a_e != "")
		runscr(n_e a_e)
		)
		
		((n_e != "")&&(a_e = "")
		a_e=n_e	
		runscr(n_e a_e)
		)
		
		((n_e = "")&&(a_e = "")
		axlShell("define grid")
		)
)
)


defun( runscr (n_e a_e)

ScriptFileName=axlTempFile()
Script_File=axlDMOpenFile("Grid_SCRIPT", ScriptFileName, "w") 

fprintf(Script_File "scriptmode +i\n\n")
fprintf(Script_File "setwindow pcb\n")
fprintf(Script_File "define grid \n")
fprintf(Script_File "setwindow form.grid\n")
fprintf(Script_File "FORM grid non_etch non_etch_x_grids %L \n" n_e)
fprintf(Script_File "FORM grid non_etch non_etch_y_grids %L \n" n_e)
fprintf(Script_File "FORM grid all_etch all_etch_x_grids %L %L %L %L %L \n" a_e a_e a_e a_e a_e)
fprintf(Script_File "FORM grid all_etch all_etch_y_grids %L %L %L %L %L \n" a_e a_e a_e a_e a_e)
fprintf(Script_File "FORM grid done \n")

axlDMClose(Script_File) 
sprintf(runScript,"replay %s",ScriptFileName) 
axlShell(runScript)
deleteFile(ScriptFileName)
)