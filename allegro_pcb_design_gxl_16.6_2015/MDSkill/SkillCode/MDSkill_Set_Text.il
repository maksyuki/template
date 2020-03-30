/*
#########################################################################################                                                                    
#                  	Command: MDST                                     					#
#                  	Skill File: MDSkill_Set_Text.il                   				#
#                  	How To Load: Command> (load("MDSkill_Set_Text.il"))				#
#               	How To Execute: Command> MDST  			   							#
#					Modify by:  longxf 2020-1-1 Download Addr:https://pcbbar.com/ 		#
#              	 	Write by: kevin wong											 	#
#########################################################################################
*/
axlCmdRegister("MDST" 'MDSkill_Set_Text)

defun( MDSkill_Set_Text ()
let( (curdsnunit)
		  curdsnunit = axlGetParam("paramDesign")->units
		   case(curdsnunit
	        ("mils"  du = 1)
		    ("millimeters" du = 0.0254 )
			;(u can add other units)
		      )


old_visList = axlVisibleGet()

setTextSize()
axlVisibleSet(old_visList)
))



defun( setTextSize ()
		let(()
		;1,GET ����
		Text_need = '("1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "12" "13" "14" "15" "16")
	  
		foreach(text_block Text_need
			p = axlGetParam(strcat("paramTextBlock:" text_block))
			block_pl = atoi(text_block) ;change string to num   (1.0/du)
		   
			case(block_pl
				(1 
					p->width = 20*(1.0/du)
					p->height = 30*(1.0/du)
					p->lineSpace = 30*(1.0/du)
					p->photoWidth = 4*(1.0/du)
					p->charSpace = 5*(1.0/du)
				)
				(2
					p->width = 30*(1.0/du)
					p->height = 35*(1.0/du)
					p->lineSpace = 35*(1.0/du)
					p->photoWidth = 6*(1.0/du)
					p->charSpace = 3*(1.0/du)
				)
				(3
					p->width = 38*(1.0/du)
					p->height = 50*(1.0/du)
					p->lineSpace = 63*(1.0/du)
					p->photoWidth = 6*(1.0/du)
					p->charSpace = 10*(1.0/du)
				)
				(4
					p->width = 10*(1.0/du)
					p->height = 15*(1.0/du)
					p->lineSpace = 2*(1.0/du)
					p->photoWidth = 2*(1.0/du)
					p->charSpace = 2*(1.0/du)
				)
				(5
					p->width = 80*(1.0/du)
					p->height = 80*(1.0/du)
					p->lineSpace = 100*(1.0/du)
					p->photoWidth = 8*(1.0/du)
					p->charSpace = 20*(1.0/du)
				)
				(t
					p->width = (15 + 5*block_pl)*(1.0/du)
					p->height = (20 + 5*block_pl)*(1.0/du)
					p->lineSpace = 25*(1.0/du)
					p->photoWidth = 6*(1.0/du)
					p->charSpace = 5*(1.0/du)
				)
			)
			axlSetParam(p)	
	 	)
	  ;set the textblock size
	  


	  
	  axlVisibleDesign(nil)
	  axlVisibleLayer("REF DES/SILKSCREEN_TOP" t)
	  axlVisibleLayer("REF DES/SILKSCREEN_BOTTOM" t)
	  ;if u need other text ,please add below:
	  ;axlVisibleLayer("REF DES/assembly_TOP" t)
	  
	  
	  axlClearSelSet()
	  axlSetFindFilter( ?enabled (list "noall" "text" "clinesegs") , ?onButtons (list "text"))
	  allrefs = axlGetSelSet(axlAddSelectAll())
	  foreach(i allrefs   
	          axlDBChangeText(i nil 2)
	          )
	  ;change the resdes
	  
	  ; axlVisibleDesign(nil)
	  ; axlVisibleLayer("PACKAGE GEOMETRY/SILKSCREEN_TOP" t)
	  ; axlVisibleLayer("BOARD GEOMETRY/SILKSCREEN_TOP" t)
	  ; axlVisibleLayer("PACKAGE GEOMETRY/SILKSCREEN_BOTTOM" t)
	  ; axlVisibleLayer("BOARD GEOMETRY/SILKSCREEN_BOTTOM" t)
	  ; axlClearSelSet()
	  ; axlSetFindFilter( ?enabled (list "noall" "text" "clinesegs") , ?onButtons (list "text"))
	  ; alloth_text = axlGetSelSet(axlAddSelectAll())
	  ; foreach(i alloth_text
	  ; axlDBChangeText(i nil 1))
	  ;change all other text
	  ))