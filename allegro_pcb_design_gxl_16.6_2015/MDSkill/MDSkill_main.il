/*
#########################################################################################
#           How To Load: Command> (load("MDSkill_main.il"))                           
#           Modify by:  maksyuki 2020-3-30
#           Original author : Wanghh Download Addr:https://github.com/whh5118/GTOpen    #
#########################################################################################
*/

procedure( MDSkill_menu_load(@optional window timerId_lj elapsedTime)
    prog((port menuexit menuList tt file line port offset)
        file = axlTempFile()
        axlUIMenuDump(file)
        port = infile(file)
        menuexit = nil
        while(gets(line port)
            when(rexMatchp("https://github.com/maksyuki/" line)
                menuexit = t
            )
        )
    close(port)
    deleteFile(file)
    
    if(menuexit then
        return(t)
    else
        timerId = axlUIWTimerAdd(nil 5000 t 'MDSkill_menu_load)
    )
    
    menuList = '(
            (popup "&MDSkill")

                (popup "Package")
                    ("Change Origin" "skill MDSkill_Change_Origin")
                    ("Create Oblong Thermal" "skill CreateOblongThermal")
                    ("Create Keepout" "skill MDSkill_Keepout")
                    ("Change Pad" "change pad")
                    ("Rename Pin Number" "rpn")
                (end)
                
                (separator)                
                (popup "Layout")
                    ("Align Objects" "MDAL")
                    ("Grid Choose" "skill MDSkill_ChooseGrid")
                    ("Move Step" "skill Jun_DirKeyTool")
                    ("Place Comp" "skill MDSkill_Place_Inside")
                (end)            
                
                (separator)
                (popup "Router")
                    (popup "Cut/Link Cline")
                       ("Cut Clines/Lines/Shapes" "skill MDSkill_CutClines_Lines_Shapes")
                       ("Link Cline" "skill MDSkill_Cline_Cross")
                    (end)
                    ("View net Message" "Jun_NetTool")
                    ("Change via net" "ch_via_net")
                    ("Replace via" "Jun_ReplaceVia")
                    ("Ref to Component" "Jun_RefdesSet")
                    ("Artwork Setup" "Jun_Artwork")
                (end)
            
                (separator)
                (popup "Utility Tools")            
                    ("Calculator" "skill gt_calculator_main")
                    ("Set Text" "skill MDSkill_Set_Text")
                    ("Set Color" "skill MDSkill_Color_Setting")
                    ("Export Device" "skill MDSkill_Export_Device")
                    ("Import Logo" "skill MDSkill_Logo")    
                    ("Clean Directory" "skill MDSkill_Clean")               
                (end)
                
                (separator)
                (popup "Help")
                    ("Tool About" "http https://github.com/maksyuki/")
                (end)
            (end)
    )
    
    
    offset = "-1"

  axlUIMenuFind(nil readstring(offset))
  axlUIMenuInsert(nil menuList)
)
)

procedure( MDSkill_Clean()
    shell("
        del /f /s /q  *.log
        del /f /s /q  *.dbk
        del /f /s /q  *.opj
        del /f /s /q  *.jrl
        del /f /s /q  *.cnv
        del /f /s /q  *.sav
        del /f /s /q  *.ldf
        del /f /s /q  *.csv
        del /f /s /q  *.scr
        del /f /s /q  *.xml
        del /f /s /q  *.dml
        del /f /s /q  *.dml,1
        del /f /s /q  *.XRF
        del /f /s /q  *.bdf
        del /f /s /q  *.tag
        del /f /s /q  *.form
        rd /s /q Indesign
        rd /s /q signoise.run
    ")
)

;------��ݼ�����
procedure( MDSkill_HotKey()
    ;���õ�ͬ�� funckey z ch_via_net     
    ;axlSetFunckey("z" "MDCH")                         ;����ԭ��
    ;axlSetFunckey("z" "MDCOT")                     ;�½�����Flash
    ;axlSetFunckey("z" "MDKP")                         ;����KEEPOUT/ALL
    ;axlSetFunckey("z" "change pad")                 ;���Ӻ���Ԫ��
    ;axlSetFunckey("z" "rpn")                         ;��������������
    ;axlSetFunckey("z" "MDAL")                         ;���빤��
    ;axlSetFunckey("Z" "MDCW")                         ;���ø��  Ҳ��ʹ��MDG����
    ;axlSetFunckey("X" "Jun_DirKeyTool")             ;�������ò����Ĺ̶����빤��
    ;axlSetFunckey("z" "MDPI")                         ;ָ�����������������
    ;axlSetFunckey("C" "MDCUT")                         ;��Ϲ���
    ;axlSetFunckey("z" "MDCL")                         ;�Զ����Ӳ���
    ;axlSetFunckey("z" "Jun_ReplaceVia")             ;�滻ѡ�����
    ;axlSetFunckey("z" "Jun_RefdesSet")             ;����������λ�ŷ��õ���������λ��
    ;axlSetFunckey("z" "Jun_Artwork")                 ;���ù�湤��
    ;axlSetFunckey("z" "MDCA")                         ;���õ�λ�л�����
    ;axlSetFunckey("z" "MDST")                         ;����ϵͳ�ַ���С����������������λ��Ϊ2������
    ;axlSetFunckey("z" "MDCOL")                     ;������ɫ������������������MDCOL  MDCOL1    MDCOL2
    ;axlSetFunckey("z" "MDED")                         ;���������ļ������з�װ��Device�ļ�
    ;axlSetFunckey("z" "Jun_SymbolTool M")             ;�������ŵ�Bottom����ͬλ��
    ;axlSetFunckey("z" "MDLG")                         ;���뵥ɫλBMP��ʽLOGO�ļ�
    
    ;axlSetFunckey("p" "Jun_SymbolTool A")             ;���Ķ��뺸��/��
    ;axlSetFunckey("z" "ch_via_net")                 ;�л���������
    ;axlSetFunckey("l" "Jun_LayerEtch")              ;�л���ָ����
    ;axlSetFunckey("L" "Jun_LayerTool")                ;�򿪲���ʾ����
    axlSetFunckey("," "Jun_LayerEtch Down")            ;�л�����һ��
    axlSetFunckey("." "Jun_LayerEtch Up")            ;�л�����һ��
    axlSetFunckey("jk" "Jun_LayerTool st t")        ;�л�������˿ӡ����
    axlSetFunckey("kk" "Jun_LayerTool sb t" )        ;�л�������˿ӡ�ײ�
    
    ;axlSetFunckey("at" "Jun_LayerTool at t")        ;�л�������
    ;axlSetFunckey("atp" "Jun_LayerTool atp t")        ;�л�������+Placebound
    ;axlSetFunckey("ab" "Jun_LayerTool ab t")        ;�л����ײ�
    ;axlSetFunckey("abp" "Jun_LayerTool abp t")        ;�л����ײ�+Placebound    
    ;axlSetFunckey("stp" "Jun_LayerTool stp t" )        ;�л�������˿ӡ����+Placebound
    ;axlSetFunckey("sbp" "Jun_LayerTool sbp t" )        ;�л�������˿ӡ�ײ�+Placebound
    ;axlSetFunckey("all" "Jun_LayerTool all")        ;��ʾ���в�
    ;axlSetFunckey("no" "Jun_LayerTool no")            ;�ر����в�
)

;------��������
procedure( MDSkill_int()
prog((file port InstallPath tt)
    unless(boundp('MDSkill_global)
        defvar(MDSkill_global ncons(nil))
    )
    InstallPath = nil
    tt = setof(x0 getSkillPath() (isFile(strcat(x0 "/allegro.ilinit")) == t))
    file = strcat(axlOSSlash(car(tt)) "/allegro.ilinit")
    port = infile(file)
    while(gets(n0 port)
        when(rexMatchp("load.*MDSkill_main.il\")+" n0)
            InstallPath = car(axlDMFileParts(cadr(parseString(n0 " ()\t\n\""))))
            InstallPath = buildString(reverse(cdr(reverse(parseString(InstallPath "/\\")))) "/")
        )
    )
    close(port)
    MDSkill_global->InstallPath = "C:/Users/abcd/Documents/GitHub/template/allegro_pcb_design_gxl_16.6_2015"
    load(strcat(MDSkill_global->InstallPath "/MDSkill/SkillCode/MDSkill_CutClines_Lines_Shapes.il"))
    load(strcat(MDSkill_global->InstallPath "/MDSkill/SkillCode/MDSkill_Cline_Cross.il"))
    load(strcat(MDSkill_global->InstallPath "/MDSkill/SkillCode/MDSkill_Calculator.il"))
    load(strcat(MDSkill_global->InstallPath "/MDSkill/SkillCode/MDSkill_SetGrid.il"))
    load(strcat(MDSkill_global->InstallPath "/MDSkill/SkillCode/MDSkill_ChooseGrid.il"))
    load(strcat(MDSkill_global->InstallPath "/MDSkill/SkillCode/MDSkill_Color_Setting.il"))
    load(strcat(MDSkill_global->InstallPath "/MDSkill/SkillCode/MDSkill_Set_Text.il"))
    load(strcat(MDSkill_global->InstallPath "/MDSkill/SkillCode/MDSkill_Change_Origin.il"))
    load(strcat(MDSkill_global->InstallPath "/MDSkill/SkillCode/MDSkill_Create_Oblong_Thermal.il"))
    load(strcat(MDSkill_global->InstallPath "/MDSkill/SkillCode/MDSkill_Keepout.il") "keepout")
    load(strcat(MDSkill_global->InstallPath "/MDSkill/SkillCode/MDSkill_Place_Inside.il"))
    load(strcat(MDSkill_global->InstallPath "/MDSkill/SkillCode/Form/MDSkill_fform.il"))
    load(strcat(MDSkill_global->InstallPath "/MDSkill/SkillCode/MDSkill_Export_Device.il"))
    load(strcat(MDSkill_global->InstallPath "/MDSkill/SkillCode/MDSkill_Logo.il"))
    load(strcat(MDSkill_global->InstallPath "/MDSkill/SkillCode/Align/align.il"))
    load(strcat(MDSkill_global->InstallPath "/MDSkill/SkillCode/Align/align_do.il"))
    load(strcat(MDSkill_global->InstallPath "/MDSkill/SkillCode/Align/align_utils.il"))
    load(strcat(MDSkill_global->InstallPath "/MDSkill/Skill/Artwork.il") "Jun")
    load(strcat(MDSkill_global->InstallPath "/MDSkill/Skill/FormFunc.il") "Jun")
    load(strcat(MDSkill_global->InstallPath "/MDSkill/Skill/DirKeyTool.il") "Jun")
    load(strcat(MDSkill_global->InstallPath "/MDSkill/Skill/change_pad.il") "Jun")
    load(strcat(MDSkill_global->InstallPath "/MDSkill/Skill/RefdesTool.il") "Jun")
    load(strcat(MDSkill_global->InstallPath "/MDSkill/Skill/FormM.il") "Jun")
    load(strcat(MDSkill_global->InstallPath "/MDSkill/Skill/Replace_Via.il") "Jun")
    load(strcat(MDSkill_global->InstallPath "/MDSkill/Skill/SymbolTool.il") "Jun")
    load(strcat(MDSkill_global->InstallPath "/MDSkill/Skill/Change_LayerTool.il") "Jun")
    load(strcat(MDSkill_global->InstallPath "/MDSkill/Skill/View_Net_Message.il") "Jun")
    load(strcat(MDSkill_global->InstallPath "/MDSkill/Skill/ch_via_net.il") "www.allegro-skill.com")
    load(strcat(MDSkill_global->InstallPath "/MDSkill/Skill/Rename_Pin_Number.il") "www.eda365.com")
    timerId = axlUIWTimerAdd(nil 1000 t 'MDSkill_menu_load) ;<5000
    axlCmdRegister("MDSkill" 'MDSkill_menu_load ?cmdType "general")
    axlTriggerSet('menu 'MDSkill_menu_load)
    MDSkill_HotKey()
)
)
MDSkill_int()
