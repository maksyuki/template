/*
#############################################################################                                                                    
#                  	Command: MDCW                                     		#
#                  	Skill File: MDSkill_ChooseGrid.il                   	#
#                  	How To Load: Command> (load("MDSkill_ChooseGrid.il"))	#
#               	How To Execute: Command> MDCW  			   				#
#              	 	Write by: Richard L            							#
#############################################################################
*/

axlCmdRegister("MDCW" `MDSkill_ChooseGrid)

GridsZoomList='(200 100 50 39.37 31.5 25 10 5 1 0.1) 
GridsZoomName=nil

/*---------------------------------
CreateFormForGrids()
---------------------------------*/
defun(CreateFormForGrids (units)
	MainFormFile=axlTempFile()
	p=outfile(MainFormFile "w")

	GridsZoomName=nil
	for(i 0 length(GridsZoomList)-1
		sprintf(filename,"%g",cnv_factor*nth(i GridsZoomList))
		GridsZoomName=cons(filename,GridsZoomName)
	)

	totalWidth=0
	for(i 0 length(GridsZoomName)-1
		totalWidth=totalWidth+strlen(nth(i GridsZoomName))+3
	)
	
	sprintf(title,"Grids Tool - Units : %s",units)
	f_FormBegin(p totalWidth,0,title,"TOOLWINDOW")
	xpos=1
	for(i 0 length(GridsZoomList)-1
		f_CheckList(p nth(i GridsZoomName) xpos 0 nth(i GridsZoomName) "gg")
		xpos=xpos+strlen(nth(i GridsZoomName))+3
	)
	f_FormEnd(p)

	close(p)
	MainFormFile
);func

defun(MDSkill_ChooseGrid ()
; creates conversion factors for different db units
; -------------------------------------------------
units=car(axlDBGetDesignUnits())
	cond(
		(equal(units "microns") 	(cnv_factor=1000.00))
		(equal(units "mils") 		  (cnv_factor=1.00))
		(equal(units "inches") 		(cnv_factor=0.10))
		(equal(units "millimeters") (cnv_factor=1.0))
		(equal(units "centimeters") (cnv_factor=0.254))
	)

	drain()
	gform_file=CreateFormForGrids(units)
	gridsform=axlFormCreate((gensym) gform_file '("NE" "msglines" 0) 'g_Action t nil)
	axlUIWPerm(gridsform t)
	axlFormDisplay(gridsform)
	deleteFile(gform_file)
); end of grids
;--------------------------------------------------------
; what to do on form actions
; --------------------------
defun(g_Action (gridsform)
	for(i 0 length(GridsZoomList)-1
		if(evalstring(gridsform->curField)==cnv_factor*nth(i GridsZoomList) 
		UC_grids_script_create(cnv_factor*nth(i GridsZoomList)) 	
		)
	)
); end g_Action
;--------------------------------------------------------
defun(UC_grids_script_create (cur_grid)
	ScriptFileName=axlTempFile()
	Script_File=outfile(ScriptFileName "w")
	fprintf(Script_File "scriptmode +i\n")
	fprintf(Script_File "define grid \nsetwindow form.grid\n")
	fprintf(Script_File "FORM grid non_etch non_etch_x_grids %n \n" cur_grid)
	fprintf(Script_File "FORM grid non_etch non_etch_y_grids %n \n" cur_grid)
	fprintf(Script_File "FORM grid all_etch all_etch_x_grids %n %n %n %n %n \n" cur_grid/5 cur_grid/5 cur_grid/5 cur_grid/5 cur_grid/5)
	fprintf(Script_File "FORM grid all_etch all_etch_y_grids %n %n %n %n %n \n" cur_grid/5 cur_grid/5 cur_grid/5 cur_grid/5 cur_grid/5)
	fprintf(Script_File "FORM grid done\n")
	close(Script_File)
	sprintf(runScript,"replay %s",ScriptFileName)
	axlShell(runScript)
	axlUIWPrint(gridsform axlPPrint(units)) 
	deleteFile(ScriptFileName)
); end UC_grids_script_create



