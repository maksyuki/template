/*
#########################################################################################                                                                    
#                  	Command: MDLG                                     					#
#                  	Skill File: MDSkill_Logo.il                   					#
#                  	How To Load: Command> (load("MDSkill_Logo.il"))					#
#               	How To Execute: Command> MDLG  			   							#
#              	 	Write by: Wanghh Download Addr:https://github.com/whh5118/GTOpen 	#
#########################################################################################
*/


axlCmdRegister("MDLG" 'MDSkill_Logo ?cmdType "interactive")


procedure( MDSkill_Logo()
let((form)
	
	axlShell("noappmode")
	form = gtopen_Logo_Createform()
	gtopen_Logo_Int_Var(form)
	gtopen_Logo_Update_form(form)
)
)




procedure( gtopen_Logo_Createform()
let((file form)
	;file = strcat(MDSkill_global->InstallPath "/MDSkill/SkillCode/gtopen_Logo.form")
	;printf( "file----------------(%s)",  file)
	;printf( "file1----------------(%s)",  MDSkill_global->InstallPath)
	;file = "C:/Cadence/SPB_16.6/share/local/pcb/skill/MDSkill/SkillCode/gtopen_Logo.form"
	;file = strcat(getSkillPath() "/MDSkill/SkillCode/form/gtopen_Logo.form")
	when('gtopen_Logoform && boundp('gtopen_Logoform)
		when(axlIsFormType(eval('gtopen_Logoform))
			axlFormClose(eval('gtopen_Logoform))
		)
	)
	
	
	form = axlFormCreate('gtopen_Logoform "Logo.form" nil 'gtopen_Logo_CB t)
	
	form
)
)


procedure( gtopen_Logo_Int_Var(form)
let((_getFontList)
	form->pop = ncons(nil)
	form->pop->layerclass = list("BOARD GEOMETRY" "PACKAGE GEOMETRY" "MANUFACTURING" "ETCH" "DRAWING FORMAT")

	
	form->var = ncons(nil)
	form->var->layerclass = "BOARD GEOMETRY"
	form->var->layersubclass = "DIMENSION"
	form->var->pic_size = 1
	form->var->neg = nil
)
)


procedure( gtopen_Logo_CB(form)
prog((tt bmp_show Blockw Blockh width height pixel_size box pick)
	case(form->curField
		("layerclass"
			form->var->layerclass = form->curValue
			form->var->layersubclass = car(axlSubclasses(form->var->layerclass))
		)
		("layersubclass" | "neg" | "pic_size"
			evalstring(sprintf(nil "form->var->%s = form->curValue" form->curField))
		)
		("vis"
			if(form->curValue then
				axlVisibleLayer(strcat(form->var->layerclass "/" form->var->layersubclass) t)
			else
				axlVisibleLayer(strcat(form->var->layerclass "/" form->var->layersubclass) nil)
			)
			axlVisibleUpdate(t)
		)
		("load"
			tt = axlDMFileBrowse("\321\241\324\361\315\274\306\254" nil ?optFilters "BMP Files(*.bmp)|*.bmp")
			when(tt
				if(isFile(tt) && member(upperCase(lastelem(axlDMFileParts(tt))) list("BMP")) then
					form->var->bmpinput = tt
				else
					printf(">>\262\273\326\247\263\326\315\274\306\254\270\361\312\275\n")
				)
			)
		)
		("place"
			when(form->bmpdate
				tt = axlGetParam(sprintf(nil "paramTextBlock:%d" form->var->pic_size))
				Blockw = tt->width
				Blockh = tt->height
				width = (form->bmpdate[21] << 24) + (form->bmpdate[20] << 16) + (form->bmpdate[19] << 8) + form->bmpdate[18]
				height = (form->bmpdate[25] << 24) + (form->bmpdate[24] << 16) + (form->bmpdate[23] << 8) + form->bmpdate[22]
				pixel_size = max(Blockw/width Blockh/height)
				box = list(list(0 0) list(width*pixel_size height*pixel_size))
				axlClearDynamics()
				axlAddSimpleMoveDynamics(0:0 axlPathStart(box) "box" ?ref_point 0:0)
				pick = axlEnterPoint()
				axlClearDynamics()
				when(pick
					axlDBCloak(gtopen_Logo_addshape(form pick) 'shape)
				)
			)
		)
		("textset"
			axlShell("define text")
		)
		(t
			return(t)
		)
	)
	gtopen_Logo_Update_form(form)
)
)

procedure( gtopen_Logo_Update_form(form)
let((tt port bmpdate)

	form->pop->layersubclass = nil
	foreach(n0 axlSubclasses(form->var->layerclass)
		when(axlIsLayer(buildString(list(form->var->layerclass n0) "/"))
			form->pop->layersubclass = cons(list(n0 n0 axlLayerGet(buildString(list(form->var->layerclass n0) "/"))->color) form->pop->layersubclass)
		)
	)
	tt = axlLayerGet(strcat(form->var->layerclass "/" form->var->layersubclass))
	if(tt->visible then
		form->var->vis = tt->color
		axlFormSetField(form "vis" t)
	else
		form->var->vis = 0
		axlFormSetField(form "vis" nil)
	)
	
	foreach(n0 form->pop->?
		tt = member(n0 form->pop)
		axlFormBuildPopup(form symbolToString(car(tt)) cadr(tt))
	)
	foreach(n0 form->var->?
		tt = member(n0 form->var)
		axlFormSetField(form symbolToString(car(tt)) cadr(tt))
	)
	when(form->curField == "load" && form->var->bmpinput
		form->bmpsize = fileLength(form->var->bmpinput)
		axlFormSetField(form "bmp_show" form->var->bmpinput)
		port = infile(form->var->bmpinput)
		declare(bmpdate[form->bmpsize])
		for(i 0 form->bmpsize-1
			bmpdate[i] = charToInt(getc(port))
		)
		close(port)
		form->bmpdate = bmpdate
	)
	if(form->var->bmpinput then
		axlFormSetFieldEditable(form "place" t)
	else
		axlFormSetFieldEditable(form "place" nil)
	)
	axlFormAutoResize(form)
	axlFormDisplay(form)
)
)

procedure( gtopen_Logo_addshape(form pickxy)
prog((tt Blockw Blockh number num row max_column column max_w bit x y offset width height Grid imagesize path polys symbolid)
	tt = axlGetParam(sprintf(nil "paramTextBlock:%d" form->var->pic_size))
	Blockw = tt->width
	Blockh = tt->height
	
	offset = (form->bmpdate[13] << 24) + (form->bmpdate[12] << 16) + (form->bmpdate[11] << 8) + form->bmpdate[10]
	width = (form->bmpdate[21] << 24) + (form->bmpdate[20] << 16) + (form->bmpdate[19] << 8) + form->bmpdate[18]
	height = (form->bmpdate[25] << 24) + (form->bmpdate[24] << 16) + (form->bmpdate[23] << 8) + form->bmpdate[22]
	imagesize = form->bmpsize - offset
	
	max_column = (imagesize / height) << 3
	max_w = (imagesize / width) << 3
	number = offset + imagesize - 1
	Grid = 1/min(width/Blockw height/Blockh)
	column = 0
	polys = '()
	if(!axlSelectByName("SYMTYPE" "GTLogo") then
    axlDBCreateSymDefSkeleton(list("GTLogo" "mechanical") list(list(0 0) list(width height)))
	else
	  axlClearSelSet()
	)
	symbolid = car(axlDBCreateSymbolSkeleton(list("GTLogo" "mechanical") pickxy nil 0.0 nil))
	axlMeterCreate("\275\370\263\314\326\320" "" t)
	for(i offset number
		tt = fix((50*i) / (imagesize-1))
		when(tt == 12 || tt == 25 || tt == 37 || tt == 50
			axlMeterUpdate(tt sprintf(nil "\315\352\263\311\266\310 :%d / %d" (i-offset) (imagesize-1)))
		)
		
		y = Grid * fix((i - offset) / (max_column >> 3)) + cadr(pickxy)
		for(j 0 7
	    bit = bitfield1(form->bmpdate[i] (7 - j))
	    when(form->var->neg
	    	bit = abs(bit-1)
	    )
	    x = Grid * column + car(pickxy)
			when(zerop(bit) && (column < width)
				path = axlPathStart(list(x:y))
				axlPathLine(path 0.0 x:(y+1.1*Grid))
				axlPathLine(path 0.0 (x+1.1*Grid):(y+1.1*Grid))
				axlPathLine(path 0.0 (x+1.1*Grid):y)
				axlPathLine(path 0.0 x:y)
				polys = append(axlPolyFromDB(path) polys)
			)
	    column++
		)
		when(column == max_column
	    column = 0
		)
	)
	polys = axlPolyOperation(car(polys) cdr(polys) 'OR)
	num = 1
	foreach(n0 polys
		tt = fix((50*num) / length(polys)) + 50
		when(tt == 62 || tt == 75 || tt == 87 || tt == 100
			axlMeterUpdate(tt sprintf(nil "\315\352\263\311\266\310 :%d / %d" num length(polys)))
		)
		tt = axlDBCreateShape(n0 t strcat(form->var->layerclass "/" form->var->layersubclass) nil symbolid)
		axlCustomColorObject(car(tt) 0)
		num++
	)
	axlMeterDestroy()
	axlVisibleUpdate(t)
	
)
)








