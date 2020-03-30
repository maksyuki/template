/*
#########################################################################################                                                                    
#         	Skill File: MDSkill_Cline_Cross.il                   						#
#         	How To Load: Command> (load("MDSkill_Cline_Cross.il"))					#
#			Modify by:  longxf 2020-1-1 Download Addr:https://pcbbar.com/ 				#
#			How To Execute: Command> MDCL												# 
#			Original author : Wanghh Download Addr:https://github.com/whh5118/GTOpen 	#
#########################################################################################
*/

axlCmdRegister("MDCL" 'MDSkill_Cline_Cross ?cmdType "interactive")

procedure( MDSkill_Cline_Cross()
let((selbox mark mypopup sels file port segs cline0 cline1 linex startxy0 startxy1 tt tt0 line0xy line1xy)
	mark = axlDBTransactionStart()
	mypopup = axlUIPopupDefine(nil
		list(
			list("Done" "axlDBTransactionCommit(mark) axlUIPopupSet(nil) axlFinishEnterFun()")
	    list("Oops" "axlDBTransactionOops(mark)")
	    list("Cancel" "axlDBTransactionRollback(mark) axlUIPopupSet(nil) axlCancelEnterFun()")
		)
	)
	axlSetFindFilter(?enabled '("NOALL" "ratsnests") ?onButtons '("all"))
	axlClearSelSet()
	axlUIPopupSet(mypopup)
	while(selbox = axlEnterBox(?prompts list(">>\307\353\312\344\310\353\265\332\322\273\270\366\265\343" ">>\307\353\312\344\310\353\265\332\266\376\270\366\265\343"))
		axlUIPopupSet(mypopup)
		axlDBTransactionMark(mark)
	  axlSingleSelectBox(selbox)
	  sels = axlGetSelSet()
		axlClearSelSet()
		foreach(n0 sels
			file = car(axlShowObjectToFile(n0))
			port = infile(file)
			while(gets(line port)
				when(rexMatchp("end points:+" lowerCase(line))
					gets(line port)
					tt = member("xy" parseString(line " ()\t\n"))
					line0xy = list(atof(cadr(tt)) atof(nth(2 tt)))
					if(member("xy" cdr(tt)) then
						line1xy = list(atof(nth(4 tt)) atof(nth(5 tt)))
					else
						gets(line port)
						tt = member("xy" parseString(line " ()\t\n"))
						line1xy = list(atof(cadr(tt)) atof(nth(2 tt)))
					)
				)
			)
			close(port)
			deleteFile(file)
			segs = '()
			foreach(n1 n0->net->branches~>children
				foreach(n2 setof(x0 n1 ((x0->objType == "path" && x0->segments != nil) || x0->objType == "via" || x0->objType == "pin"))
					when(n2->segments
						segs = append(n2->segments segs)
					)
					when(n2->objType == "via" || n2->objType == "pin"
						segs = cons(n2 segs)
					)
				)
			)
			cline0 = car(setof(x0 segs (member(line0xy x0->startEnd) != nil)))
			via0 = car(setof(x0 segs (line0xy == x0->xy && x0->objType == "via")))
			pin0 = car(setof(x0 segs (line0xy == x0->xy && x0->objType == "pin")))
			cline1 = car(setof(x0 segs (member(line1xy x0->startEnd) != nil)))
			via1 = car(setof(x0 segs (line1xy == x0->xy && x0->objType == "via")))
			pin1 = car(setof(x0 segs (line1xy == x0->xy && x0->objType == "pin")))
			when(cline0 && cline1
				if(axlLineSlope(cline0->startEnd) != axlLineSlope(cline1->startEnd) then
		  		linex = axl_ol_ol2(cline0->startEnd cline1->startEnd)
					startxy0 = car(remd(line0xy cline0->startEnd))
					startxy1 = car(remd(line1xy cline1->startEnd))
					while(car(linex) != cadr(linex)
						tt = list(startxy0 axlMUniVector(startxy0 car(linex) axlDistance(startxy0 car(linex))+nth(2 linex)))
						tt0 = list(startxy1 axlMUniVector(startxy1 cadr(linex) axlDistance(startxy1 cadr(linex))+nth(2 linex)))
						linex = axl_ol_ol2(tt tt0)
					)
					
					tt = ncons(nil)
					tt->width = cline0->width
					tt->layer = cline0->layer
					tt->netname = cline0->net->name
					tt0 = ncons(nil)
					tt0->width = cline1->width
					tt0->layer = cline1->layer
					tt0->netname = cline1->net->name
					axlDeleteObject(cline0)
					axlDeleteObject(cline1)
					axlDBCreateLine(list(car(linex) startxy0) tt->width tt->layer tt->netname)
					axlDBCreateLine(list(car(linex) startxy1) tt0->width tt0->layer tt0->netname)
					when(via0
						axlChangeNet(via0 tt->netname)
					)
					when(via1
						axlChangeNet(via1 tt->netname)
					)
					unless(car(linex) == via0->xy || car(linex) == via1->xy
						when((tt->layer != tt0->layer)
							axlDBCreateVia(car(axlCnsGetViaList("")) car(linex) tt->netname)
						)
					)
				else
					linex = axl_ol_ol2(cline0->startEnd cline1->startEnd)
					when(axlLineSlope(cline0->startEnd) == axlLineSlope(list(car(linex) cadr(linex)))
						axlDBCreateLine(list(car(linex) cadr(linex)) cline0->width cline0->layer cline0->net->name)
						unless(car(linex) == via0->xy || car(linex) == via1->xy
							when(cline0->layer != cline1->layer
								axlDBCreateVia(car(axlCnsGetViaList("")) cadr(linex) cline0->net->name)
							)
						)
					)
				)
			)
;			when(cline0 && pin1 || cline1 && pin0
;				println(axlLineSlope(list(line0xy line1xy)))
;				println(axlLineSlope(cline1->startEnd))
;				println(pin0)
;			)
		)
	)
	axlDBRefreshId(nil)
	axlDBTransactionCommit(mark)
	axlUIPopupSet(nil)
)
)





