/*
#################################################################################################                                                                    
#                  	Command: MDCUT                                     							#
#                  	Skill File: MDSkill_CutClines_Lines_Shapes.il                   			#
#                  	How To Load: Command> (load("MDSkill_CutClines_Lines_Shapes.il"))			#
#               	How To Execute: Command> MDCUT  			   								#
#              	 	Write by: Wanghh Download Addr:https://github.com/whh5118/GTOpen 			#
#################################################################################################
*/

axlCmdRegister("MDCUT" 'MDSkill_CutClines_Lines_Shapes ?cmdType "interactive")

procedure( MDSkill_CutClines_Lines_Shapes()
let((tt tt0 minleng mypopup sels mypath poly0 linesets poly1 mark selbox lineleng linexy0 linexy1)
	mark = axlDBTransactionStart()
	minleng = expt(0.1 cadr(axlDBGetDesignUnits()))
	mypopup = axlUIPopupDefine(nil;axlUIGetUserData()->popupId
		list(
			list("Done" "axlDBTransactionCommit(mark) axlUIPopupSet(nil) axlFinishEnterFun()")
	    list("Oops" "axlDBTransactionOops(mark)")
	    list("Cancel" "axlDBTransactionRollback(mark) axlUIPopupSet(nil) axlCancelEnterFun()")
		)
	)
	axlSetFindFilter(?enabled '("NOALL" "vias" "CLINESEGS" "shapes" "LINESEGS") ?onButtons '("noall" "vias" "CLINESEGS" "shapes"))
	axlClearSelSet()
	axlUIPopupSet(mypopup)
	while(selbox = axlEnterBox(?prompts list(">>\307\353\312\344\310\353\265\332\322\273\270\366\265\343" ">>\307\353\312\344\310\353\265\332\266\376\270\366\265\343")) ;
		axlUIPopupSet(mypopup)
		axlDBTransactionMark(mark)
	  axlSingleSelectBox(selbox)
	  sels = axlGetSelSet()
		axlClearSelSet()
		foreach(n0 sels
			case(n0->objType
				("line"|"arc"
					mypath = axlMakeDynamicsPath(list(
						list(xCoord(selbox) list(xCoord(xCoord(selbox)) yCoord(yCoord(selbox))) 0.)
						list(list(xCoord(xCoord(selbox)) yCoord(yCoord(selbox))) yCoord(selbox) 0.)
						list(yCoord(selbox) list(xCoord(yCoord(selbox)) yCoord(xCoord(selbox))) 0.)
						list(list(xCoord(yCoord(selbox)) yCoord(xCoord(selbox))) xCoord(selbox) 0.)
					))
					poly0 = axlPolyFromDB(mypath)
					linesets = nil
					poly1 = axlPolyFromDB(n0)
					foreach(n1 axlPolyOperation(poly1 poly0 'ANDNOT)
						tt = setof(x0 n1->vertices (member(x0 car(poly1)->vertices) == nil))
						tt0 = setof(x0 n1->vertices (member(x0 car(poly1)->vertices) != nil))
						when(tt0
							lineleng = axlDistance(caar(tt) caar(tt0)) - n0->width
							tt = axlMXYSub(car(n0->startEnd) caar(tt0))
							when(abs(car(tt)) + abs(cadr(tt)) <= minleng*2 + n0->width
								linexy0 = car(n0->startEnd)
								linexy1 = axlMUniVector(linexy0 cadr(n0->startEnd) lineleng)
								linesets = cons(list(linexy0 linexy1) linesets)
							)
							tt = axlMXYSub(cadr(n0->startEnd) caar(tt0))
							when(abs(car(tt)) + abs(cadr(tt)) <= minleng*2 + n0->width
								linexy0 = cadr(n0->startEnd)
								linexy1 = axlMUniVector(linexy0 car(n0->startEnd) lineleng)
								linesets = cons(list(linexy0 linexy1) linesets)
							)
						)
					)
					tt = ncons(nil)
					tt->width = n0->width
					tt->layer = n0->layer
					tt->netname = n0->net->name
					axlDeleteObject(n0)
					foreach(n1 linesets
						tt0 = axlDBCreateLine(n1 tt->width tt->layer tt->netname)
						when(caar(tt0)->net->name != tt->netname && tt->netname
							axlDeleteObject(caar(tt0))
						)
					)
				)
				("via"
					axlDeleteObject(n0)
				)
				("shape"
					when(n0->net
						mypath = axlMakeDynamicsPath(list(
							list(xCoord(selbox) list(xCoord(xCoord(selbox)) yCoord(yCoord(selbox))) 0.)
							list(list(xCoord(xCoord(selbox)) yCoord(yCoord(selbox))) yCoord(selbox) 0.)
							list(yCoord(selbox) list(xCoord(yCoord(selbox)) yCoord(xCoord(selbox))) 0.)
							list(list(xCoord(yCoord(selbox)) yCoord(xCoord(selbox))) xCoord(selbox) 0.)
						))
						poly0 = axlPolyFromDB(mypath)
						
						shapeid = n0
						when(n0->shapeBoundary
							shapeid = n0->shapeBoundary
						)
						poly1 = axlPolyFromDB(shapeid)
						tt = ncons(nil)
						tt->fill = shapeid->fill
						tt->layer = shapeid->layer
						tt->netname = shapeid->net->name
						axlDeleteObject(shapeid)
						foreach(n1 axlPolyOperation(poly1 poly0 'ANDNOT)
							axlDBCreateShape(n1 tt->fill tt->layer tt->netname)
						)
					)
				)
			)
		)
	)
	axlDBRefreshId(nil)
	axlDBTransactionCommit(mark)
	axlUIPopupSet(nil)
)
)





