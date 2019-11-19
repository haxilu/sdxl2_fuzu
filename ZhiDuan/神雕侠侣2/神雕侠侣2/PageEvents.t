

CheckboxTable={
"翰林求学"
,"恩仇录"
,"踏雪无痕"

,"烽火令"
,"丝绸之路"
,"名人轶事"

--时间较长的任务
,"师门任务"
,"帮派任务"
,"天下奇闻"
,"竞技场"

--每日副本一条龙
,"夜袭敌营"
,"五绝令"
,"勇闯绝情谷"
,"江湖同游"

,"领取每日活动奖励"
,"爆刷姜小虎奖牌"
}

local btnId="allChoice" 
local btnName_all="✔全选"
local btnName_notall="✖不选"
local btnName_wait="(￣3￣)稍等"
--全选/不选
function AllChoice_Click()      
    
    local content=buttongettext(btnId)  
    
    if content==btnName_all then        --全选
        
        BtnWait()     
        ChoiceBox(true)
        buttonsettext(btnId,btnName_notall)
        
    elseif content==btnName_notall then  --不选
        
        BtnWait()
        ChoiceBox(false)        
        buttonsettext(btnId,btnName_all)
        
    else
        --不做操作
    end  
end
--按钮改为稍等
function BtnWait()
    sleep(100)
    buttonsettext(btnId,btnName_wait)
    sleep(100)
end
--改变多选框
function ChoiceBox(isChoice)
    for k,v in ipairs(CheckboxTable) do       
        
        if checkgetselected(v)~=isChoice then
            
            if v == "爆刷姜小虎奖牌" then
                checksetselected(v,false)
            else
                checksetselected(v,isChoice)
                sleep(100)
            end
        end
        
    end
end

function Github()   

   cmdroot("am start -a android.intent.action.VIEW -d https://github.com/xxxxue/sdxl2_fuzu")
    
end

function QQGroup()
    setclipboard("780091710")  

    messagebox("Q群复制成功,请粘贴到QQ中查找.")
end