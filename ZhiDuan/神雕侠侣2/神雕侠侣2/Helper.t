--退出队伍
function ExitTeam()
    --关闭遮挡页面
    TapCloseButton()
    sleep(1000)    
    Debug("正在 退出队伍..")
    if XM.Find({"界面","背包"}) then
        
        --点击队伍tab
        XM.Find({"界面","队伍tab未选中状态"},true)
        
        sleep(1000)
        
        if XM.Find({"界面","队伍tab选中状态"}) then
            
            if  XM.Find({"界面","未在队伍状态"}) then
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
        Debug("不在主页.无法进行队伍操作..")
        return false
    end 
end

--进入修行
function EnterPractice()
    sleep(1000)
    XM.Find({"界面","功能展开箭头"},true) --功能展开箭头
    sleep(1500)
    XM.Find({"界面","修行按钮"},true) --修行按钮      
    sleep(1500)
    if XM.Find({"任务","修行多倍经验开"},true)  then --去掉多倍勾选
        Debug("关闭 多倍")
    else
        Debug("多倍为 关闭状态.")
    end
    sleep(300)
    XM.Find({"任务","修行进入按钮"},true) 
    sleep(1000)
    XM.Find({"任务","修行自动多倍提示框取消按钮"},true) 
    
end

--开始打老虎
function BattleTiger()
    local changeNum=tonumber(editgettext("爆刷姜小虎奖牌每轮该次开启多倍")) --双倍开启回合 
    local errorCloseExpGoodsNum=tonumber(editgettext("爆刷姜小虎奖牌异常回合数强制关闭多倍"))--强制关闭
    local startTime=timenow() --开始时间    
    local sleepTime=1000 --变速
    local StateMsg="" --提示任务状态信息
    local sw=true --开关(提高性能)
    
    local battleNum = 0 --战斗次数
    local allBattleNum = 0 --总战斗数量
    
    local j_Tiger = false --老虎状态
    local j_TigerNum_All = 0 --老虎数量
    local j_TigerNum_UseExpGoods = 0
    local j_TigerNum_NotUseExpGoods = 0          
    local expGoods=false  --多倍经验 是否开启
    local chance=0
    local bchance=0
    local outTime=0
    while true do
        
        sleep(sleepTime)        
        local runTime= XM.DateRet(timediff("s",startTime,timenow()))
        if XM.Find({"界面","任务tab偏旁"}) then
            sleep(200)            
            
            if XM.Find({"任务","退出修行按钮"}) then     
                
                if XM.Switch("修行界面") then
                    
                    XM.OpenSwitch("战斗界面")                    
                    outTime=0
                    --打了老虎 关闭多倍
                    if j_Tiger or battleNum >= errorCloseExpGoodsNum then
                        
                        j_Tiger=false --关闭 老虎状态
                        
                        if expGoods then                           
                            if ChangeExpGoods(2) then
                                expGoods=false   
                            else
                                --异常处理
                                ErrorExpGoods()
                                return false
                            end                            
                        end
                    end
                    
                    --打开多倍                    
                    if battleNum==changeNum and expGoods==false and j_Tiger==false then                        
                        
                        if ChangeExpGoods(1) then
                            expGoods=true                        
                        else
                            --异常处理
                            ErrorExpGoods()
                            return false
                        end                        
                    end                      
                end
                
                
                if j_TigerNum_All>0 then                    
                    chance=tostring(j_TigerNum_UseExpGoods/j_TigerNum_All) --概率
                    bchance= strleft(chance,strfind(chance,".")+3) *100
                end
                
                --降低提示框的显示频率
                if XM.Timer("状态信息框",3) then
                    StateMsg=runTime .."   间隔: "..(sleepTime/1000) .."s   战斗总数: "..allBattleNum                 
                    StateMsg=StateMsg.."\n--------统计--------"
                    StateMsg=StateMsg.."\n虎数量 (多倍/普通/总计): "..j_TigerNum_UseExpGoods .." / "..j_TigerNum_NotUseExpGoods.." / "..j_TigerNum_All .."  命中率: ".. bchance.." %"
                    StateMsg=StateMsg.."\n-------界面设定-------"
                    StateMsg=StateMsg.."\n开/关多倍 (每轮第x次): ".. changeNum.." / "..errorCloseExpGoodsNum
                    StateMsg=StateMsg.."\n--------状态--------"
                    StateMsg=StateMsg.."\n多倍状态: "..tostring(expGoods).."  接下来本轮第"..(battleNum+1).."次战斗"       
                    
                    Debug(StateMsg)                    
                end
                
            end
            
        else       
            
            sleep(200)
            if XM.Find({"任务","修行战斗界面"}) then                 
                XM.MsgClose()
                if XM.Switch("战斗界面") then   
                    XM.OpenSwitch("修行界面")                    
                    allBattleNum=allBattleNum+1   --战斗总数
                    battleNum=battleNum+1		--当前轮 战斗数     
                    StateMsg="本轮第"..battleNum.."次战斗\n加倍状态:"..tostring(expGoods) 
                end
                outTime=outTime+1
                --老虎开关                 
                if XM.Find({"任务","姜小虎"}) and j_Tiger==false and outTime<=3  then     
                    
                    j_Tiger=true
                    
                    j_TigerNum_All =j_TigerNum_All +1  --所有老虎数
                    
                    StateMsg=StateMsg.."\n遇到姜小虎!!!!"
                    
                    if expGoods then
                        --多倍虎
                        j_TigerNum_UseExpGoods = j_TigerNum_UseExpGoods +1                            
                    else
                        --普通虎
                        j_TigerNum_NotUseExpGoods = j_TigerNum_NotUseExpGoods  +1
                    end
                    
                    local logs="总虎: "..j_TigerNum_All .." 多倍/普通虎: "..j_TigerNum_UseExpGoods .." / "..j_TigerNum_NotUseExpGoods .."命中率: "..bchance.." %  战斗总数: "..allBattleNum.." 本轮战斗数: "..battleNum .."  多倍状态: "..tostring(expGoods).." 界面设定第 ".. changeNum.." 次后开多倍  脚本运行时长: "..runTime
                    
                    battleNum=0 --重置战斗次数
                    
                    if battleNum==0 then
                        Debug("每轮次数 归0 成功!!",true)
                        StateMsg=StateMsg.."\n每轮次数 归0 成功!!"                            
                        
                    else
                        Debug("每轮次数 归0 失败!!",true)
                        StateMsg=StateMsg.."\n每轮次数 归0 失败!!"
                        
                        WriteTxtFile(logs)
                        Debug(StateMsg)
                        ErrorExpGoods()
                        return false
                    end
                    
                    WriteTxtFile(logs)
                else                    
                    if outTime<=3 then                     
                        StateMsg=StateMsg.."\n计时: "..outTime.."/3"
                    else
                        StateMsg="停止寻找老虎.."
                    end                    
                end
                
                Debug(StateMsg)
            end            
        end       
        
    end
end

--姜小虎任务 多倍开关 异常处理
function ErrorExpGoods()
    
    sleep(200)
    while true do
        Debug("开始 异常处理.")
        if XM.Find({"任务","退出修行按钮"},true) then
            
            sleep(500)
            XM.RndTap(730,436)
            return true
        end
    end
    
end

--切换多倍经验
function ChangeExpGoods(cType)
    XM.MsgClose()
    local res=false
    XM.RndTap(425,38)  
    sleep(1300)
    
    XM.RndTap(673,40)
    sleep(1000)
    
    
    if cType==1 then       --打开多倍
        
        if  XM.Find({"任务","修行多倍经验开"}) then
            Debug("多倍 状态为开,不需要再次开启",true) 
            res=true
        else
            if XM.Find({"任务","修行多倍经验关"},true) then
                Debug("多倍 开启成功",true)  
                res=true
            else
                Debug("***系统错误:开 多倍时请联系作者..",true)
            end
        end
        
        
    elseif cType==2 then    --关闭多倍
        
        if  XM.Find({"任务","修行多倍经验关"}) then
            Debug("多倍 状态为关,不需要再次关闭",true) 
            res=true
        else
            if XM.Find({"任务","修行多倍经验开"},true) then
                Debug("多倍 关闭成功",true)  
                res=true
            else
                Debug("***系统错误: 关 多倍时 请联系作者..",true)
            end
        end
        
    end
    
    sleep(500)    
    XM.RndTap(1120,71)
    
    sleep(1000)    
    XM.RndTap(754,39)
    sleep(1000)
    return res
end


--坐标超时(在原地不动了)
function ZBTimeOut(list)
    local zbColorNum_old=0 --旧坐标色点数
    local zbColorNum_new=0 --新坐标色点数
    local timeOut=0--超时时间
    local timeOutState=false --超时状态
    --检查是否完成
    while true do
        sleep(1500)
        Debug("提示:\n任务完成后,角色会停止移动(正常现象),然后脚本会进行任务判定..")
        sleep(1500)
        zbColorNum_new = XM.FindNumRet({"界面","坐标色点"})
        
        if XM.TimerFirst(list.name.."进行中",7) then                            
            Doing(list)
        end
        
        if 2 < zbColorNum_new and zbColorNum_new < 450 then                        
            
            --判断坐标是否发生变化
            if zbColorNum_old==zbColorNum_new then   
                
                timeOut=timeOut+3
                Debug(list.name.."任务完成判定倒计时(请勿移动角色):"..timeOut.."/30",true)
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
        
        --关掉对话
        if zbColorNum_new==0 then
            if XM.Find({"界面","跳过对话"}) then                 
                if XM.Timer(list.name.."跳过对话",4) then
                    跳过对话() 
                    TapCloseButton(false)                    
                end
                sleep(3000)
            end
        else
            XM.TimerInit(list.name.."跳过对话")
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
        if XM.Find({"任务",list.name.."入口"},true) then           
            return true
        else
            Debug("等待[ "..list.name.." ]入口..大概20秒..",true)
            --20s后 超时
            if XM.Timer(list.name.."入口",20) then
                
                Debug("等待[ "..list.name.." ]入口 超时.重新领取任务..")
                
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
            if XM.Switch("副本组队成功") then
                --组队成功
                return list.name
            else
                Debug("已经组过队伍..开始副本.")
            end            
        else
            --任务已经完成 无需组队 
            return TaskOver(list.name)
        end
        
        if XM.Find({"任务",list.name},true) then
            
            --走到副本入口
            if Tap_副本按钮() then
                
                sleep(1000)
                tap(1047,581) --进入副本
                sleep(500)
                
                Wait(list,180) --等待180秒
                
                local zbColorNum_old=0 --旧坐标色点数
                local zbColorNum_new=0 --新坐标色点数
                local timeOut=0--超时时间
                local timeOutState=false --超时状态                
                
                while true do
                    sleep(3000)     
                    
                    if timeOutState==false then 
                        
                        zbColorNum_new = XM.FindNumRet({"界面","坐标色点"})               
                        
                        if 2 < zbColorNum_new and zbColorNum_new < 450 then                        
                            
                            --判断坐标是否发生变化
                            if zbColorNum_old==zbColorNum_new then   
                                
                                timeOut= timeOut + 3
                                Debug("卡机判断:"..timeOut.."/30")
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
                        Debug(list.name.." 卡机状态..  正在处理...",true)
                        --卡机
                        if XM.Find({"任务","副本内队伍界面"},true) then
                            sleep(2000)
                            XM.RndTap(1119,193)                           
                        elseif XM.Find({"任务","副本内任务界面"}) then
                            sleep(2000)
                            XM.RndTap(1119,193)                            
                        else
                            ErrorAction()
                            
                            if XM.Timer(list.name.."副本卡机状态",20) then
                                
                                if  XM.Find({"任务","退出副本按钮"},true) then
                                    sleep(1000)
                                    XM.RndTap(726,438) --点击确认
                                    sleep(5000)
                                else
                                    sleep(1000)
                                    XM.RndTap(652,43) 
                                    sleep(2000)
                                    XM.RndTap(726,438)
                                    sleep(5000)
                                end
                                return list.name --退出任务
                            end
                            
                            
                        end
                        
                        timeOutState=false
                    end  
                    if XM.Timer(list.name.."副本内关闭窗口",30) then
                        Debug("正在关闭遮挡窗口..")
                        TapCloseButton()                    
                    end
                    
                    --寻找结束页面
                    if XM.Find({"任务","副本结算页面"},true) then            
                        Debug("["..list.name.."]副本结束...",true)                                               
                        
                        --点击 取消继续副本
                        sleep(2000)     
                        tap(578,442)
                        TapCloseButton()
                        return list.name
                    else
                        if XM.TimerFirst(list.name.."进行中",12) then
                            Doing(list)                            
                        end
                    end
                    
                end
                
                if WaitFuBenOver(list) then
                    return list.name
                end               
                
            else
                Msg("等待 "..list.name.."副本入口超时")
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

--组5人队伍
function OrganizeTeam(list)    
    if XM.Switch("副本组队") then
        
        if XM.Find({"任务",list.name}) then                      
            
            TapCloseButton()
            Debug(list.name.."状态为 [可领取] ,开始组队..")
            sleep(1000)
            if XM.Find({"界面","背包"}) then
                
                --点击队伍tab
                XM.Find({"界面","队伍tab未选中状态"},true)
                
                sleep(1000)
                
                if XM.Find({"界面","队伍tab选中状态"}) then
                    
                    if  XM.Find({"界面","未在队伍状态"}) then
                        
                    else
                        Debug("检查队伍人数...")
                        --点击5号位置
                        tap(1071,485)
                        sleep(1000)
                        --未找到5号位置,则退出现有队伍,重新匹配队友 
                        if XM.Find({"界面","五号位置请离按钮"}) then
                            Debug("队伍5人,完成组队....") 
                            return true                            
                        else
                            Debug("队伍不满5人,退出退伍.开始组队....")     
                            
                            tap(1045,160) --点击自己
                            sleep(500) 
                            tap(935,237)--点击退出
                            sleep(500)
                            tap(737,438) --确定退出
                            sleep(500)                              
                        end                           
                    end
                    Debug("队伍不满5人,退出退伍.开始组队....")     
                    --组建队伍
                    BuildTeam()
                    
                    Debug("正在组队中.....")   
                    
                    --确认组队是否完成
                    while true do        
                        sleep(3000)
                        if  XM.Find({"界面","背包"})   then
                            --找到背包证明没有匹配成功
                            Debug("正在组队中.....")                            
                        else            
                            if  XM.Find({"界面","队伍满人按钮"},true) then
                                Debug("组队成功!!!!")
                                sleep(2000)
                                return true
                            else
                                Debug("正在组队中.....")
                            end
                        end
                    end
                    
                    sleep(500)
                    
                end           
            else
                Debug("不在主页,无法进行队伍操作..")
            end 
            
        else            
            Debug("任务已经完成 无需组队--")
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
    if XM.Timer(list.name..taskTypeName,list.taskOutTime) then
        Debug("["..list.name..taskTypeName .."]超时...重新开始任务..",true)
        sleep(2000)
        return true                    
    else
        Debug("开始判断["..list.name..taskTypeName.."]超时, 大约"..list.taskOutTime.."秒")
        
    end
    
    return false    
end

--出现错误后的动作
function ErrorAction()
    
    --关闭按钮
    TapCloseButton()    
    Debug("可能发生了卡机,调整位置中..",true)
    XM.Swipe(651,364,487,357,5,2000)
    XM.Swipe(651,364,551,234,5,2000)
    XM.Swipe(651,364,751,217,5,2000)
    XM.Swipe(651,364,812,391,5,2000)
    XM.Swipe(651,364,619,463,5,2000)
    XM.Swipe(651,364,751,487,5,2000)        
    
end
--领取任务提示
function GetTaskingMsg(list)
    Debug("正在领取["..list.name.."]任务...")
end

--显示任务信息
function ShowTaskMsg()    
    local taskMsg=""
    if #TaskTable==0 then
        taskMsg=taskMsg.."⭐⭐⭐⭐⭐⭐⭐⭐任务已经全部完成⭐⭐⭐⭐⭐⭐⭐⭐\n"  
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
        taskMsg=taskMsg.."\n⭐⭐⭐⭐⭐⭐⭐⭐任务添加成功..4秒后 开始执行..."   
    end  
    
    XM.Msg(taskMsg,344,68)  
    sleep(1000)
end
function 跳过对话()
    
    while true do
        
        if XM.Find({"界面","跳过对话"},true) then
            
        else
            sleep(1000)
            return true
        end
        sleep(2000)
    end
    
    
end

--是否是战斗界面
function IsCombatFace()
    return XM.Find({"界面","战斗界面"})
end

--移除 x个队友
function RemoveTeammate(num)
    Debug("移除"..num.."名队友..")
    XM.Find({"界面","队伍tab未选中状态"},true) 
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
    Debug("***["..list.name.."]进行中-->>>>>>")   
end

--关闭使用物品界面
function TapCloseGoods()    
    sleep(500)
    while true do
        
        if XM.Find({"界面","关闭使用物品界面"},true) then            
            
        else           
            return true             
        end       
        sleep(500)
    end
    
end


--任务结束
function TaskOver(str)    
    Debug("["..str.."]已完成...")
    TapCloseButton() 
    if #TaskTable >0 then
        table.remove(TaskTable,1)        
        table.insert(TaskOverTable,(#TaskOverTable+1),str.." -----------✔已完成")        
    end    
    
    if #TaskTable > 0 then --防止无任务后 报错
        Debug("["..str.."]已完成...进行下一个任务 --->>>> "..TaskTable[1],true)
    end 
    
    sleep(2000)
    
    return "TheLegendOfCondorHero"
end

--点击关闭按钮
function TapCloseButton(isCloseGoods)
    
    sleep(500)    
    XM.Find({"界面","关闭"},true) 
    
    if isCloseGoods==nil then
        isCloseGoods= true   
    end
    
    if isCloseGoods then        
        --关闭物品
        TapCloseGoods()   
    end
    
    sleep(500)
    XM.Find({"界面","关闭"},true) 
end

--检查屏幕信息
function CheckRun()
    
    setfloatwindowlocation(5,718)    
    Debug("调整悬浮窗位置到左下角")
    
    local msg=""
    local list = XM.GetScreenSimulator() --当前分辨率    
    
    msg=msg.."推荐分辨率: 720 * 1280  DPI: 320 \n当前分辨率: "..list[1].." * "..list[2].."  DPI: "..list[3]
    
    msg=msg.."\n---------------------------------------------"
    msg=msg.."\n【飞天助手】海量免费辅助搭配【红手指】\n免充电、免Root、免流量、24小时离线挂机!"
    msg=msg.."\n---------------------------------------------"
    msg=msg.."\n任务日志 在设备的 【根目录 / 神雕2脚本日志】 文件夹中  \n文件名格式: 年 - 月 - 日.txt  \n(可以查看此文件查看历史任务情况)\n\n脚本出现异常可以将此日志发给作者.."
    msg=msg.."\n---------------------------------------------"    
    msg=msg.."\n请确保\n1.已经进入游戏\n2.所有窗口已关闭\n3.画质为 [省电]\n4.打开[匹配机器人]"
    msg=msg.."\n---------------------------------------------"  
    if list[1]==720 and list[2]==1280 and list[3]==320 then
        
    else 
        msg=msg.."\n分辨率不匹配.脚本运行过程可能不稳定."        
    end     
    
    msg=msg.."\n智能检测运行环境,正在启动【新版防封框架】..."  
    
    msg=msg.."\n---------------------------------------------"  
    for i=5,0,-1 do
        sleep(1000)
        CenterMsg(msg.."\n"..i.."秒后开始运行脚本....")        
    end    
    
end

--获取页面选择的任务
function GetSelectTask()    
    
    --清空任务表
    TaskTable={}
    
    --遍历多选框结果.
    for i=#CheckboxTable,0,-1 do        
        if XM.GetUI(CheckboxTable[i]) then           
            --加入任务表
            table.insert(TaskTable,1,CheckboxTable[i])                       
        end   
    end     
    sleep(1000)    
end


--创建队伍
function  BuildTeam()
    Debug("创建队伍,开始匹配....")
    --进入队伍页面
    tap(1181,120)
    sleep(1000)    
    
    --创建新的队伍   
    
    sleep(1500)
    tap(869,142) --点击目标
    
    sleep(1500)
    XM.Swipe(329,235,327,414) --划动列表
    
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
--屏幕中间显示提示
function CenterMsg(msg)
    XM.Msg(msg,442,24)    
end

--点击副本按钮
function Tap_副本按钮()
    for i=20,0,-2 do                  
        if XM.Find({"任务","副本入口按钮"},true) then            
            return true
        else
            Debug("没有到达副本门口..倒计时:"..i)
        end
        sleep(2000)                   
    end  
    return false
end

function 进入活动_经验()
    --进入活动页面
    if GoActivity_All() then
        
        sleep(2000)
        if XM.Find({"界面","活动界面"}) then 
            
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
        if XM.Find({"界面","活动界面"}) then 
            
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
        if XM.Find({"界面","活动界面"}) then             
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
        Debug("战斗界面...")  
        return false
    else        
        return XM.Find({"界面","活动按钮"},true)         
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
    XM.RndTap(212,281)
    sleep(500)
    XM.RndTap(202,200)
    sleep(500)
end