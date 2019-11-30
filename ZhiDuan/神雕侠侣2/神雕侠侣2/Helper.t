
--任务表
TaskTable={}
--任务完成表
TaskOverTable={}

--退出队伍
function ExitTeam()
    --关闭遮挡页面
    TapCloseButton()
    sleep(1000)    
    xGame.Show("正在 退出队伍..")
    if xGame.Find({"界面","背包"}) then
        
        --点击队伍tab
        xGame.Find({"界面","队伍tab未选中状态"},true)
        
        sleep(1000)
        
        if xGame.Find({"界面","队伍tab选中状态"}) then
            
            if  xGame.Find({"界面","未在队伍状态"}) then
                return true
            else               
                tap(1045,160) --点击自己
                sleep(500) 
                tap(935,237)--点击退出
                sleep(500)
                tap(737,438) --确定退出
                sleep(500)
                return true
            end            
        end           
    else
        xGame.Show("不在主页.无法进行队伍操作..")
        return false
    end 
end

--坐标超时(在原地不动了)
function ZBTimeOut(list)
    local zbColorNum_old=0 --旧坐标色点数
    local zbColorNum_new=0 --新坐标色点数
    local timeOut=0--超时时间
    local timeOutState=false --超时状态
    --检查是否完成
    while true do
        sleep(1000)
        xGame.Show("提示:\n任务完成后,角色会停止移动(正常现象)\n然后脚本会进行任务判定..\n"..list.name.."进行中..")
        sleep(1000)
        zbColorNum_new = xGame.FindNumRet({"界面","坐标色点"})        
        
        if 2 < zbColorNum_new and zbColorNum_new < 450 then                        
            
            --判断坐标是否发生变化
            if zbColorNum_old==zbColorNum_new then   
                
                timeOut=timeOut+2
                xGame.Show(list.name.."任务完成判定倒计时(请勿移动角色):"..timeOut.."/20",true)
                if timeOut>=20 then
                    --超时
                    timeOutState=true
                end
            else                               
                --左边变动,重置超时时间
                zbColorNum_old=zbColorNum_new
                timeOut=0                
            end
        end       
        
        --关掉对话
        if zbColorNum_new==0 then
            if xGame.Find({"界面","跳过对话"}) then                 
                if xGame.Timer(list.name.."跳过对话",4) then
                    跳过对话() 
                    TapCloseButton(false)                    
                end
                sleep(2000)
            end
        else
            xGame.TimerInit(list.name.."跳过对话")
        end        
        
        --超时
        if timeOutState then            
            return true
        end        
    end     
end

--进入任务 入口
function TaskEnter(list)
    while true do
        sleep(1000)
        if xGame.Find({"任务",list.name.."入口"},true) then           
            return true
        else
            xGame.Show("等待[ "..list.name.." ]入口..大概20秒..",true)
            --20s后 超时
            if xGame.Timer(list.name.."入口",20) then
                
                xGame.Show("等待[ "..list.name.." ]入口 超时.重新领取任务..")
                
                sleep(1000)
                return false 
            end
        end
    end
end

--等待副本结束
function WaitFuBenOver(list)
    
    GetTaskingMsg(list)
    
    if 进入活动_道具() then        
        sleep(1000)
        if OrganizeTeam(list) then
            if xGame.Switch("副本组队成功") then
                --组队成功
                return list.name
            else
                xGame.Show("已经组过队伍..开始副本.")
            end            
        else
            --任务已经完成 无需组队 
            return TaskOver(list.name)
        end
        
        if xGame.Find({"任务",list.name},true) then
            
            --走到副本入口
            if Tap_副本按钮() then
                
                sleep(1000)
                tap(1047,581) --进入副本
                sleep(500)
                
                xGame.Wait(list,180) --等待180秒
                
                local zbColorNum_old=0 --旧坐标色点数
                local zbColorNum_new=0 --新坐标色点数
                local timeOut=0--超时时间
                local timeOutState=false --超时状态                
                
                while true do
                    sleep(3000)     
                    
                    if timeOutState==false then 
                        
                        zbColorNum_new = xGame.FindNumRet({"界面","坐标色点"})               
                        
                        if 2 < zbColorNum_new and zbColorNum_new < 450 then                        
                            
                            --判断坐标是否发生变化
                            if zbColorNum_old==zbColorNum_new then   
                                
                                timeOut= timeOut + 3
                                xGame.Show("卡机判断:"..timeOut.."/30")
                                if timeOut>=30 then
                                    --超时
                                    timeOutState=true
                                end
                            else                               
                                --左边变动,重置超时时间
                                zbColorNum_old=zbColorNum_new
                                timeOut=0
                            end
                        end                        
                    else                        
                        xGame.Show(list.name.." 卡机状态..  正在处理...",true)
                        --卡机
                        if xGame.Find({"任务","副本内队伍界面"},true) then
                            sleep(2000)
                            xGame.RndTap(1119,193)                           
                        elseif xGame.Find({"任务","副本内任务界面"}) then
                            sleep(2000)
                            xGame.RndTap(1119,193)                            
                        else
                            ErrorAction()
                            
                            if xGame.Timer(list.name.."副本卡机状态",20) then
                                
                                if  xGame.Find({"任务","退出副本按钮"},true) then
                                    sleep(1000)
                                    xGame.RndTap(726,438) --点击确认
                                    sleep(5000)
                                else
                                    sleep(1000)
                                    xGame.RndTap(652,43) 
                                    sleep(2000)
                                    xGame.RndTap(726,438)
                                    sleep(5000)
                                end
                                return list.name --退出任务
                            end
                            
                            
                        end
                        
                        timeOutState=false
                    end  
                    if xGame.Timer(list.name.."副本内关闭窗口",30) then
                        xGame.Show("正在关闭遮挡窗口..")
                        TapCloseButton()                    
                    end
                    
                    --寻找结束页面
                    if xGame.Find({"任务","副本结算页面"},true) then            
                        xGame.Show("["..list.name.."]副本结束...",true)                                               
                        
                        --点击 取消继续副本
                        sleep(2000)     
                        tap(578,442)
                        TapCloseButton()
                        return list.name
                    else
                        if xGame.TimerFirst(list.name.."进行中",12) then
                            Doing(list)                            
                        end
                    end
                    
                end
                
                --                if WaitFuBenOver(list) then
                --                    return list.name
                --                end               
                
            else
                xGame.Msg("等待 "..list.name.."副本入口超时")
            end
        else
            return TaskOver(list.name)
        end   
    else
        xGame.Show("进入[活动]页面失败...")
        ErrorAction()
    end
    return list.name
end

--组5人队伍
function OrganizeTeam(list)    
    if xGame.Switch("副本组队") then
        
        if xGame.Find({"任务",list.name}) then                      
            
            TapCloseButton()
            xGame.Show(list.name.."状态为 [可领取] ,开始组队..")
            sleep(1000)
            if xGame.Find({"界面","背包"}) then
                
                --点击队伍tab
                xGame.Find({"界面","队伍tab未选中状态"},true)
                
                sleep(1000)
                
                if xGame.Find({"界面","队伍tab选中状态"}) then
                    
                    if  xGame.Find({"界面","未在队伍状态"}) then
                        
                    else
                        xGame.Show("检查队伍人数...")
                        --点击5号位置
                        tap(1071,485)
                        sleep(1000)
                        --未找到5号位置,则退出现有队伍,重新匹配队友 
                        if xGame.Find({"界面","五号位置请离按钮"}) then
                            xGame.Show("队伍5人,完成组队....") 
                            return true                            
                        else
                            xGame.Show("队伍不满5人,退出退伍.开始组队....")     
                            
                            tap(1045,160) --点击自己
                            sleep(500) 
                            tap(935,237)--点击退出
                            sleep(500)
                            tap(737,438) --确定退出
                            sleep(500)                              
                        end                           
                    end
                    xGame.Show("队伍不满5人,退出退伍.开始组队....")     
                    --组建队伍
                    BuildTeam()
                    
                    xGame.Show("正在组队中.....")   
                    
                    --确认组队是否完成
                    while true do        
                        sleep(3000)
                        if  xGame.Find({"界面","背包"})   then
                            --找到背包证明没有匹配成功
                            xGame.Show("正在组队中.....")                            
                        else            
                            if  xGame.Find({"界面","队伍满人按钮"},true) then
                                xGame.Show("组队成功!!!!")
                                sleep(2000)
                                return true
                            else
                                xGame.Show("正在组队中.....")
                            end
                        end
                    end
                    
                    sleep(500)
                    
                end           
            else
                xGame.Show("不在主页,无法进行队伍操作..")
            end 
            
        else            
            xGame.Show("任务已经完成 无需组队--")
            return false --任务已完成
        end        
    else
        traceprint("已经组过队伍..")
        return true --已经本次已经组过队
    end    
    
end


--领取每日活动奖励
function GetEverydayActivityReward(x,y)
    sleep(500) 
    tap(x,y) 
    
    sleep(500)    
    tap(218,472)    --点击空白处
    
end

--任务超时提醒
function TimeOut(list,taskTypeName)    
    taskTypeName = taskTypeName or ""
    list.taskOutTime = list.taskOutTime or 20
    if xGame.Timer(list.name..taskTypeName,list.taskOutTime) then
        xGame.Show("["..list.name..taskTypeName .."]超时...重新开始任务..",true)
        sleep(2000)
        return true                    
    else
        xGame.Show("开始判断["..list.name..taskTypeName.."]超时, 大约"..list.taskOutTime.."秒")
        
    end
    
    return false    
end

--出现错误后的动作
function ErrorAction()
    
    --关闭按钮
    TapCloseButton()    
    xGame.Show("可能发生了卡机,调整位置中..",true)
    xGame.Swipe(651,364,487,357,5,2000)
    xGame.Swipe(651,364,551,234,5,2000)
    xGame.Swipe(651,364,751,217,5,2000)
    xGame.Swipe(651,364,812,391,5,2000)
    xGame.Swipe(651,364,619,463,5,2000)
    xGame.Swipe(651,364,751,487,5,2000)        
    
end
--领取任务提示
function GetTaskingMsg(list)
    xGame.Show("正在领取["..list.name.."]任务...")
end

--显示任务信息
function ShowTaskMsg()    
    local taskMsg=""
    if #TaskTable==0 then
        taskMsg=taskMsg.."⭐⭐⭐任务已经全部完成\n"  
        taskMsg=taskMsg.."--------------------------------\n"
    end
    
    --拼接显示信息
    for i=1,#TaskOverTable,1 do        
        taskMsg=taskMsg..i..". "..TaskOverTable[i].."\n"         
    end     
    taskMsg=taskMsg.."--------------------------------\n"
    --拼接显示信息
    for i=1,#TaskTable,1 do        
        taskMsg=taskMsg..i..". "..TaskTable[i].."\n"  
    end      
    
    if #TaskTable>0 then
        taskMsg=taskMsg.."--------------------------------\n"
        taskMsg=taskMsg.."\n⭐⭐⭐任务添加成功..4秒后 开始执行..."   
    end  
    
    xGame.Msg(taskMsg,344,68)  
    sleep(1000)
end
function 跳过对话()
    
    while true do
        
        if xGame.Find({"界面","跳过对话"},true) then
            
        else
            sleep(1000)
            return true
        end
        sleep(2000)
    end
    
    
end

--是否是战斗界面
function IsCombatFace()
    return xGame.Find({"界面","战斗界面"})
end

--移除 x个队友
function RemoveTeammate(num)
    xGame.Show("移除"..num.."名队友..")
    xGame.Find({"界面","队伍tab未选中状态"},true) 
    sleep(500)
    --移除x个一条队友
    for i=1,num,1 do
        
        tap(1083,261)
        sleep(500)
        tap(929,261)
        sleep(500)
        tap(732,438)
        sleep(500)
    end 
end


--正在进行的任务
function Doing(list)
    xGame.Show("***["..list.name.."]进行中-->>>>>>")   
end

--关闭使用物品界面
function TapCloseGoods()    
    sleep(500)
    while true do
        
        if xGame.Find({"界面","关闭使用物品界面"},true) then            
            
        else           
            return true             
        end       
        sleep(500)
    end
    
end


--任务结束
function TaskOver(str)  
    
    TapCloseButton()
    if #TaskTable >0 then
        table.remove(TaskTable,1)        
        table.insert(TaskOverTable,(#TaskOverTable+1),str.." -----------✔已完成")        
    end    
    
    if #TaskTable > 0 then --防止无任务后 报错
        xGame.Show("["..str.."]已完成...进行下一个任务 --->>>> "..TaskTable[1],true)
    end    
    sleep(2000)    
    return "TheLegendOfCondorHero"
end

--点击关闭按钮
--	isCloseGoods: 传入false 则  不关闭物品  (默认: 同时关闭物品)
function TapCloseButton(isCloseGoods)
    
    sleep(500)    
    xGame.Find({"界面","关闭"},true) 
    
    if isCloseGoods==nil then
        isCloseGoods= true   
    end
    
    if isCloseGoods then        
        --关闭物品
        TapCloseGoods()   
    end
    
    sleep(500)
    xGame.Find({"界面","关闭"},true) 
end

--获取页面选择的任务
function GetSelectTask()    
    
    --清空任务表
    TaskTable={}
    
    --遍历多选框结果.
    for i=#CheckboxTable,0,-1 do        
        if xGame.GetUI(CheckboxTable[i]) then           
            --加入任务表
            table.insert(TaskTable,1,CheckboxTable[i])                       
        end   
    end     
    sleep(1000)    
end


--创建队伍
function  BuildTeam()
    xGame.Show("创建队伍,开始匹配....")
    --进入队伍页面
    tap(1181,120)
    sleep(1000)    
    
    --创建新的队伍   
    
    sleep(1500)
    tap(869,142) --点击目标
    
    sleep(1500)
    xGame.Swipe(329,235,327,414) --划动列表
    
    sleep(1500)            
    tap(303,171)--点击日常活动
    
    sleep(1500)
    tap(412,398)--点击组队副本 箭头
    
    sleep(1500)
    tap(565,170)--点击夜袭敌营
    
    sleep(1500)
    tap(725,592) --点击创建队伍
    
    sleep(1500)
    tap(1049,583) --点击开始匹配
    
    sleep(1500)                    
    tap(1161,55)--关闭选择地图页面
    
    sleep(1500)
    tap(1247,43)   --关闭 组队页面
    
    TapCloseButton()
end


--点击副本按钮
function Tap_副本按钮()
    for i=20,0,-2 do                  
        if xGame.Find({"任务","副本入口按钮"},true) then            
            return true
        else
            xGame.Show("没有到达副本门口..倒计时:"..i)
        end
        sleep(2000)                   
    end  
    return false
end

function 进入活动_经验()
    --进入活动页面
    if GoActivity_All() then
        
        sleep(2000)
        if xGame.Find({"界面","活动界面"}) then 
            
            Tap_经验页面()
            
            sleep(1000)
            
            return true
            
        else
            return false
        end
    else
        return false
    end    
    
end

function 进入活动_休闲()  
    
    --进入活动页面
    if GoActivity_All() then
        
        sleep(2000)
        if xGame.Find({"界面","活动界面"}) then 
            
            Tap_休闲界面()
            
            sleep(1000)
            
            return true
            
        else
            return false
        end
    else
        return false
    end   
end

function 进入活动_道具()    
    --进入活动页面
    if GoActivity_All() then        
        sleep(1000)
        if xGame.Find({"界面","活动界面"}) then             
            Tap_道具界面()            
            sleep(1000)            
            return true            
        else            
            return false
        end
    else
        return false
    end   
end

--进入活动_全部
function GoActivity_All()
    --是否是战斗界面    
    if IsCombatFace()  then
        xGame.Show("战斗界面...")  
        return false
    else        
        return xGame.Find({"界面","活动按钮"},true)         
    end    
    
end

function Tap_经验页面()    
    ResetTaskCard()
    tap(541,152)
end
--点击 道具界面
function Tap_道具界面()   
    ResetTaskCard()
    tap(675,152)
end
--点击 休闲界面
function Tap_休闲界面()
    ResetTaskCard()
    tap(813,151)
end
--重置任务卡 位置
function ResetTaskCard()
    sleep(500)
    xGame.RndTap(212,281)
    sleep(500)
    xGame.RndTap(202,200)
    sleep(500)
end