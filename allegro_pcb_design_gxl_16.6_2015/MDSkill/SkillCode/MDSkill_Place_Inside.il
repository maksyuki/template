/*
#########################################################################################                                                                    
#         	Skill File: MDSkill_Place_Inside.il                   					#
#         	How To Load: Command> (load("MDSkill_Place_Inside.il"))					#
#			Modify by:  longxf 2020-1-1 Download Addr:https://pcbbar.com/ 				#
#			How To Execute: Command> MDPI												# 
#			Original author : Skny														#
#########################################################################################
*/

axlCmdRegister("MDPI" 'MDSkill_Place_Inside)         ;"pi" Ϊ��������ؼ���,�����Զ���˹ؼ��֡�

defun( MDSkill_Place_Inside ()
     let(()
     formcreate()
        ) ;let
     ) ;defun
      
defun( move ()   
      axlShell("unrats all")
      Com_area=axlEnterBox(?prompts list("First rectangle point, please..." "Second rectangle point, please...")) 
      if(caar(Com_area)>car(cadr(Com_area)) then
       	 new_x=car(cadr(Com_area))
       	 big_x=caar(Com_area)
      else
      	 new_x=car(car(Com_area))
      	 big_x=car(cadr(Com_area))
      	)
      if(cadr(cadr(Com_area))>cadr(car(Com_area)) then
      	  new_y=cadr(cadr(Com_area))
      else
      	  new_y=cadr(car(Com_area))
      	  )
       sym_dy=0
       sym_dx=0
       H_dy=0
       pls_x=new_x+1
       pls_y=new_y-1
       pls_xy=list(pls_x,pls_y)
       all_dy=0
       
       axlClearSelSet()
       axlSetFindFilter(?enabled list( "noall" "symbols") ?onButtons list( "noall" "symbols"))
       foreach(ref reflist
               dSyms = axlSelectByName("REFDES" ref)
               dSym=car(dSyms)
               foreach(db0 dSym->children
                       layer = cadr(parseString(db0->layer "/"))
                       if(layer == "PLACE_BOUND_TOP" || layer == "PLACE_BOUND_BOTTOM"  then
                          sym_boundary = db0->bBox
                          downleft_xy=car(sym_boundary)  
                          upright_xy=car(cdr(sym_boundary)) 
                          left_x=car(downleft_xy)
                          up_y=car(cdr(upright_xy))
                          right_x=car(upright_xy)
                          down_y=car(cdr(downleft_xy))
                          if(pls_x<big_x then 
                             ix=pls_x-left_x
                             iy=pls_y-up_y
                             axlTransformObject(dSym, ?move ix:iy)
                             
                             axlDehighlightObject(dSym) 
                             sym_dx=right_x-left_x
                             pls_x=pls_x+sym_dx+5   
                             sym_dy=up_y-down_y
                             pls_xy=list(pls_x,pls_y)
                             if(sym_dy>H_dy then
                             	 H_dy=sym_dy
                             else
                                H_dy=H_dy
                                );if(sym_dy>H_dy then
	           
                          else
                           	 all_dy=H_dy+all_dy+5
                           	 pls_x=new_x+1
                           	 pls_y=new_y-all_dy
                           	 ix=pls_x-left_x
                             iy=pls_y-up_y
                         	   axlTransformObject(dSym, ?move ix:iy) 
                         	   axlDehighlightObject(dSym)  
                             sym_dy=up_y-down_y
                             sym_dx=right_x-left_x
                             pls_x=pls_x+sym_dx+5 
                             pls_xy=list(pls_x,pls_y)
                             H_dy=sym_dy
                             ) ;if(pls_x<big_x then 
                          );if(layer
                      );foreach(db0
                );foreach(ref
     );defun
     
defun( formcreate ()
       let((place)
           path_place="./place_in.form"
           place= outfile(path_place "w")
           
           fprintf(place "FILE_TYPE=FORM_DEFN VERSION=2\n")
           fprintf(place "FORM\n")
           fprintf(place "FIXED\n")
           fprintf(place "PORT 30 5\n")
           fprintf(place "HEADER \"Place_inside\"\n")
           fprintf(place "TILE\n")
             
        	 fprintf(place "FIELD Place\n")
        	 fprintf(place "FLOC 17 19\n")
        	 fprintf(place "MENUBUTTON \"Place\" 10 4\n")
        	 fprintf(place "ENDFIELD\n")
        	 
        	 fprintf(place "FIELD Select\n")
        	 fprintf(place "FLOC 17 12\n")
        	 fprintf(place "MENUBUTTON \"Select\" 10 4\n")
        	 fprintf(place "ENDFIELD\n")
        
           fprintf(place "TEXT \"Symbols:\"\n")
           fprintf(place "FLOC 3 1\n")
           fprintf(place "ENDTEXT\n")
        
           fprintf(place "TEXT\n")
           fprintf(place "FLOC 10 1\n")
           fprintf(place "INFO Sym_Count 20\n")
           fprintf(place "FSIZE 20 2\n")
           fprintf(place "ENDTEXT\n")
           
           fprintf(place "FIELD ref_sym\n")
           fprintf(place "FLOC 2 3\n")
           fprintf(place "LIST \"\" 10 10\n")
           fprintf(place "OPTIONS multiselect\n")                
           fprintf(place "ENDFIELD\n")
           
           fprintf(place "FIELD Toggle\n")
           fprintf(place "FLOC 17 5\n")
           fprintf(place "MENUBUTTON \"On/Off\" 10 4\n")
           fprintf(place "ENDFIELD\n")
        
           fprintf(place "TEXT\n")
           fprintf(place "FLOC 23 2\n")
           fprintf(place "INFO msg 20\n")
           fprintf(place "FSIZE 20 2\n")
           fprintf(place "ENDTEXT\n")
           
           fprintf(place "TEXT \"Function:\"\n")
           fprintf(place "FLOC 15 2\n")
           fprintf(place "ENDTEXT\n")
        
        	 fprintf(place "ENDTILE\n")
           fprintf(place "ENDFORM\n")
           close(place)
        
           axlFormCreate('place_in "./place_in.form" '("msgLines" 1) 'placeAction t nil)
           axlFormDisplay(place_in)
           axlUIWPrint(place_in "Please Turn ON the function!")
           deleteFile(path_place)
       );end let
           sts = 0
           axlFormSetField( place_in "msg"         "OFF")
           axlFormSetField( place_in "Sym_Count"  "0"  )
     );end defun

defun( placeAction (place_in)
       targ = nil
       case(place_in->curField
                    ("Place"         
                        if(reflist == nil  then 
                           axlUIWPrint(place_in "Please Select symbols First!!")
                        else
                           axlShell("done")
                           move()
                           axlFormSetField( place_in "Sym_Count"  "0" )
                           axlFormListDeleteAll(place_in "ref_sym" )
                           axlUIWPrint(place_in "Done")
                           reflist = nil
                          );if
                      );Place
                    ("Select" 
                        if(sts == 0 then
                           axlUIWPrint(place_in "Please Open the function First!!")
                        else
                        	 axlUIWPrint(place_in "Selecting......")
                           hilight()
                          );if
                      );Select
                    ("Toggle" 
                        Toggle_Sts()
                      );Toggle
             );case
       reflist = nil
     );defun
defun( hilight ()
       targ = nil
       axlFormListDeleteAll(place_in "ref_sym" )
       axlShell("hilight")
       axlSetFindFilter(?enabled list( "noall" "symbols") ?onButtons list( "noall" "symbols"))
     );

defun( myxprobe (items)
       if(car(items) == 'highlight then
          targ = cons(caadr(items)->refdes targ)
          );if
       axlFormListDeleteAll(place_in "ref_sym" )
       when(member(nil targ) targ = remove(nil targ))
       targ = sort(unique(targ) nil)
       axlFormSetField( place_in "ref_sym"         targ)
       reflist = targ
       Sym_cnt=length(reflist)
       axlFormSetField( place_in "Sym_Count" Sym_cnt  )
     );defun

defun( Toggle_Sts ()
       if(sts == 0 then
          sts = 1
          axlTriggerSet('xprobe 'myxprobe)
          axlFormSetField( place_in "msg"         "ON")
          axlUIWPrint(place_in "Please Select symbols!")
                  
       else
          sts = 0
          axlTriggerClear('xprobe 'myxprobe)
          axlFormSetField( place_in "msg"         "OFF")
          axlUIWPrint(place_in "Please Open the function!")
          axlFormListDeleteAll(place_in "ref_sym" )
          axlFormSetField( place_in "Sym_Count"  "0"  )
          reflist = nil
          );if
      );defun