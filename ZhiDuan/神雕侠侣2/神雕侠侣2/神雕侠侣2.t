--
--神雕侠侣
--

Unit.State.Name="TheLegendOfCondorHero"
Settings.Process.IsLoop=true
Settings.Process.SleepTime=1000
Settings.Process.IsXMLog=true

--------------↑-----↑-------↑---↑----设置↑--------↑---↑------

--任务表
TaskTable={}
--任务完成表
TaskOverTable={}


--调度器
Unit.Param.TheLegendOfCondorHero={name="TheLegendOfCondorHero"}
function Unit.State.TheLegendOfCondorHero(list)
    
    if XM.Switch("初始化") then
        
        --指端广告入口
        showscriptad()     
        
        --检查环境信息
        CheckRun()
        
        --获取界面选择的任务
        GetSelectTask()       
        
    end
    TapCloseButton()
    if #TaskTable >0 then
        
        Debug("执行任务>>>>"..TaskTable[1],true)
        return TaskTable[1]
    else        
        
        ShowTaskMsg()         
        sleep(990000)
    end
    
    return list.name
end


Unit.Param.翰林求学={name="翰林求学"}
function Unit.State.翰林求学(list) --✔
    
    GetTaskingMsg(list)
    if 进入活动_休闲() then
        
        if XM.Find({"任务","翰林求学"},true) then
            
            --答案坐标ABCD
            Answer={
            {711,341}
            ,{1019,337}
            ,{702,467}
            ,{1006,467}
            }     
            
            for i=0,10,1 do 
                sleep(2000)
                --随机数
                an= Answer[rnd(1,4)]        
                tap(an[1],an[2])    
                
            end   
            sleep(1000)
            tap(342,459)
            sleep(2000)
            tap(1138,76) 
            sleep(2000)            
            XM.Find({"任务","翰林求学未领取奖励确定领取按钮"},true)                        
        else        
            return TaskOver(list.name) 
        end       
        
    else
        Debug("进入[活动]页面失败...")
        ErrorAction()
    end
    return list.name
end


Unit.Param.恩仇录={name="恩仇录"}
function Unit.State.恩仇录(list)--✔
    GetTaskingMsg(list)
    if 进入活动_道具() then
        
        if XM.Find({"任务","恩仇录"},true) then        
            
            while true do
                sleep(1000)
                if TaskEnter(list) then  
                    Doing(list)
                    sleep(2000)
                    tap(1018,545)  --进入扫荡
                    
                    sleep(500)
                    tap(761,435)--确定 退出组队状态                
                    
                    while true do                    
                        
                        if XM.Find({"界面","背包"}) then
                            sleep(2000)
                            tap(1212,275)
                            return TaskOver(list.name)
                        else
                            Doing(list)
                        end
                        sleep(3000)                     
                    end                
                else
                    TapCloseButton()
                    return list.name                    
                end
                
            end       
            
        else        
            return TaskOver(list.name)
        end
    else
        Debug("进入[活动]页面失败...")
        ErrorAction()
    end
    return list.name
end


Unit.Param.踏雪无痕={name="踏雪无痕"}
function Unit.State.踏雪无痕(list)--✔
    GetTaskingMsg(list)
    if 进入活动_休闲() then       
        
        if XM.Find({"任务","踏雪无痕"},true) then        
            
            while true do                
                
                if TaskEnter(list) then                
                    sleep(2000)
                    if XM.Find({"任务","踏雪无痕次数上限"},true) then                    
                        return TaskOver(list.name)
                    end            
                    --等待25秒
                    Wait(list,25)
                    while true do
                        Doing(list)
                        
                        if XM.Find({"任务","踏雪无痕胜利"}) then
                            sleep(1000)
                            tap(285,578)    
                            return TaskOver(list.name)
                        end
                        sleep(2000)                       
                        
                        --超时
                        if TimeOut(list,"结束") then
                            return list.name
                        end 
                    end                
                else                   
                    TapCloseButton()
                    return list.name
                    
                end                
                sleep(3000)
            end       
            
        else
            return TaskOver(list.name)
        end
    else
        Debug("进入[活动]页面失败...")
        ErrorAction()
    end
    return list.name
end


Unit.Param.烽火令={name="烽火令"}
function Unit.State.烽火令(list)--✔
    GetTaskingMsg(list)
    
    if 进入活动_经验() then
        
        if XM.Find({"任务","烽火令"},true) then              
            
            sleep(3000)
            if XM.Find({"任务","烽火令领取"},true) then                
                Debug("领取成功...")            
            else
                Debug("玩家没有勾选 [ 自动 烽火令 ].3秒后跳过烽火令任务..") 
                sleep(3000)
            end
            
            sleep(1000)
            
            return TaskOver(list.name)
        else
            return TaskOver(list.name)
        end   
    else
        Debug("进入[活动]页面失败...")
        ErrorAction()
    end
    return list.name    
end


Unit.Param.丝绸之路={name="丝绸之路"}
function Unit.State.丝绸之路(list)--✔ 
    
    GetTaskingMsg(list)
    
    if 进入活动_道具() then
        
        if XM.Find({"任务","丝绸之路"},true) then  
            
            while true do
                
                tap(1038,602)            
                
                TapCloseGoods()
                sleep(500)
                if XM.Find({"任务","丝绸之路装备提交"}) then
                    tap(1089,495)  
                end            
                
                sleep(500)
                if XM.Find({"任务","丝绸之路结束"}) then
                    
                    sleep(1000)
                    --领取奖励
                    tap(376,578)
                    sleep(2000)
                    --关闭界面
                    tap(1105,103)
                    
                    return TaskOver(list.name)
                else
                    Doing(list)
                end             
                
            end
        else
            return TaskOver(list.name)
        end
    else
        Debug("进入[活动]页面失败...")
        ErrorAction()
    end
    return list.name
end


Unit.Param.名人轶事={name="名人轶事"}
function Unit.State.名人轶事(list)--✔    
    GetTaskingMsg(list)
    
    if   进入活动_休闲() then
        
        if XM.Find({"任务","名人轶事"},true) then  
            
            while true do
                sleep(1000)
                if TaskEnter(list) then              
                    sleep(2000)
                    tap(1208,30)                
                    return TaskOver(list.name)      
                    
                else 
                    TapCloseButton()
                    return list.name                    
                end
                
            end    
        else
            return TaskOver(list.name)
        end
    else
        Debug("进入[活动]页面失败...")
        ErrorAction()
    end
    return list.name
end


Unit.Param.师门任务={name="师门任务"}
function Unit.State.师门任务(list)--✔
    GetTaskingMsg(list)    
    if 进入活动_经验()  then
        
        if XM.Find({"任务","师门任务"},true) then 
            
            local zbColorNum_old=0 --旧坐标色点数
            local zbColorNum_new=0 --新坐标色点数
            local timeOut=0--超时时间
            local timeOutState=false --超时状态
            
            while true do
                sleep(3000)
                
                zbColorNum_new = XM.FindNumRet({"界面","坐标色点"})               
                
                if 2 < zbColorNum_new and zbColorNum_new < 450 then                        
                    
                    --判断坐标是否发生变化
                    if zbColorNum_old==zbColorNum_new then   
                        
                        timeOut=timeOut+3
                        Debug("卡机判断:"..timeOut.."/30")
                        if timeOut>=30 then
                            --超时
                            timeOutState=true
                        end
                    else                               
                        --左边变动,重置超时时间
                        zbColorNum_old=zbColorNum_new
                        timeOut=0
                        Wait(list,15)
                    end
                end
                
                if timeOutState then                    
                    --卡机则从头开始任务
                    return list.name
                end
                
                
                --师门结束判断
                if XM.Find({"任务","师门任务结束"}) then                
                    sleep(1000)
                    tap(647,351)
                    sleep(4000)
                    tap(647,351)                     
                    sleep(2000)
                    return TaskOver(list.name)
                else
                    if XM.TimerFirst("师门结束判定",7) then
                        Doing(list)                        
                    end
                end
                
            end   
            
        else
            return TaskOver(list.name)
        end
    else
        Debug("进入[活动]页面失败...")
        ErrorAction()
    end
    return list.name
end


Unit.Param.帮派任务={name = "帮派任务",sw = true}
function Unit.State.帮派任务(list) --✔
    GetTaskingMsg(list) 
    sleep(1000)
    if 进入活动_经验() then
        
        if XM.Find({"任务","帮派任务"},true) then
            TapCloseGoods()
            Doing(list)
            sleep(1000)             
            
            --任务判定
            while true do                                       
                Doing(list)            
                sleep(2000)
                --切换循环体的开关(配合Timer使用)
                if list.sw then
                    
                    --正常进入则等待240秒
                    if TaskEnter(list) then
                        Wait(list,240)                
                    end
                    
                    list.sw=false
                    
                else                  
                    
                    ZBTimeOut(list)                    
                    return list.name
                end    
                
            end             
            
        else
            return TaskOver(list.name)
        end
    else
        Debug("进入[活动]页面失败...")
        ErrorAction()
    end
    return list.name
end


Unit.Param.天下奇闻={name="天下奇闻",sw=true}
function Unit.State.天下奇闻(list)--✔
    GetTaskingMsg(list) 
    if 进入活动_经验() then
        
        if XM.Find({"任务","天下奇闻"},true) then  
            
            while true do
                Doing(list)
                sleep(2000)
                
                if list.sw then   
                    
                    if TaskEnter(list) then
                        --选择奖励,开始任务
                        sleep(2000)
                        tap(514,278)
                        sleep(2000)
                        tap(961,622)    
                        Doing(list)
                        
                        --休息230秒
                        Wait(list,240)
                    end    
                    list.sw=false                    
                else  
                    
                    ZBTimeOut(list)
                    
                    return list.name
                end
                
            end    
        else
            return TaskOver(list.name)
        end
        
    else
        Debug("进入[活动]页面失败...")
        ErrorAction()
    end
    return list.name
end


Unit.Param.竞技场={name="竞技场",maxValue=getselectscheckitemindex("竞技场次数")+1}
function Unit.State.竞技场(list)--✔
    GetTaskingMsg(list) 
    if 进入活动_道具() then
        
        if XM.Find({"任务","竞技场"},true) then
            sleep(1000)
            local nowValue = 0
            
            --竞技场入口
            if TaskEnter(list) then
                
                sleep(2000)
                tap(844,295)    --进入战斗            
                nowValue=nowValue+1                    
                Debug(nowValue.."竞技场进行中,剩余"..(list.maxValue-nowValue).."次..")
                while true do
                    
                    --跳出 结算页面
                    sleep(5000)                    
                    tap(680,592)
                    sleep(1000)
                    tap(680,592)                    
                    
                    if XM.Find({"界面","竞技场界面"}) then
                        sleep(3000)
                        --满足次数则退出
                        if nowValue>=list.maxValue then
                            sleep(2000)
                            tap(659,490)
                            sleep(1000)
                            tap(779,487)         
                            
                            return TaskOver(list.name)
                        end                        
                        
                        tap(844,295)  --进入战斗,次数加1
                        nowValue=nowValue+1
                    else
                        Debug(nowValue.."竞技场进行中,剩余"..(list.maxValue-nowValue).."次..")
                    end
                end         
            else
                TapCloseButton()
                return list.name
            end            
            
        else
            return TaskOver(list.name)
        end
    else
        Debug("进入[活动]页面失败...")
        ErrorAction()
    end
    return list.name
end

Unit.Param.夜袭敌营={name="夜袭敌营"}
function Unit.State.夜袭敌营(list)--✔
    
    return WaitFuBenOver(list)
end

Unit.Param.五绝令={name="五绝令"}
function Unit.State.五绝令(list)--✔
    
    return WaitFuBenOver(list)
end

Unit.Param.勇闯绝情谷={name="勇闯绝情谷"}
function Unit.State.勇闯绝情谷(list)--✔
    
    return WaitFuBenOver(list)
end

Unit.Param.江湖同游={name="江湖同游"}
function Unit.State.江湖同游(list)--✔
    GetTaskingMsg(list) 
    sleep(1000)
    
    if 进入活动_休闲() then
        
        if XM.Switch(list.name.."组队") then   
            XM.OpenSwitch("副本组队")
            --组队
            if OrganizeTeam(list) then                
                --移除3个队友
                RemoveTeammate(3)
                sleep(1000)
                return list.name
            else    
                return TaskOver(list.name)
            end            
        end
        
        if XM.Find({"任务","江湖同游"},true) then         
            
            --江湖同游入口
            if TaskEnter(list) then
                
                Doing(list)                
                
                Wait(list,100)
                
                --等待结束
                ZBTimeOut(list)
                
                return list.name
                
            else
                ZBTimeOut(list)
                TapCloseButton()
                return list.name
            end                        
        else
            --退出队伍
            ExitTeam()
            return TaskOver(list.name)
        end
    else
        Debug("进入[活动]页面失败...进行异常处理...")
        ErrorAction()
    end
    return list.name
end


Unit.Param.领取每日活动奖励={name="领取每日活动奖励"}
function Unit.State.领取每日活动奖励(list)--✔
    Doing(list)  
    TapCloseButton()
    sleep(2000)
    
    if  GoActivity_All() then
        
        sleep(2000)
        
        local xyReward={
        {518,589},
        {669,592},
        {818,588},
        {975,589},
        {1116,590},
        }       
        
        for i=1,#xyReward,1 do    
            Debug("领取第"..i.."个奖励..")
            GetEverydayActivityReward(xyReward[i][1],xyReward[i][2]) --1 
        end   
    else
        Debug("进入[活动]页面失败...")
        ErrorAction()
    end
    return TaskOver(list.name)
    
end
