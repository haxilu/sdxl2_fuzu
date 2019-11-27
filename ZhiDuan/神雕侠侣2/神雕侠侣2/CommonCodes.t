
--设置
Settings={
--[[
##########################状态机设置#######
--]]
Process={
--执行的间隔时间
SleepTime=1000, 

--是否永久循环
IsLoop=false,

--是否开启XM Log
IsXMLog=false

}
--[[
#########################脚本设置#######
--]]
,Script={

--脚本比例尺
Scale_x=720, 
Scale_y=1280,

--消息提示坐标X
MsgBoxPosition_x=233,
MsgBoxPosition_y=1215, 

--Home位置(影响坐标)--例子:下(竖屏) 右(横屏)  左 上
HomeKeyPosition="右"

}

}


--状态机
Unit={
State={
Name="" --脚本启动的入口(需自定义)
},
Param={},
}


--特征表
H={}
--Home键位置枚举
local HomeKeyPositionEnum={下=0,右=1,左=2,上=3,}
--
--初始化 脚本
--
function Init() 
    --加载XM 
    require ("XM")    
    
    --添加特征表表
    XM.AddTable(H) 
    
    --打开XM Log日志  
    if Settings.Process.IsXMLog then
        XM.XMLogExOpen() 
    end    
    
    logopen()
    
    --设置编写脚本时的分辨率,用于同比例屏幕适配
    XM.SetScale(Settings.Script.Scale_x,Settings.Script.Scale_y)    
    
    --设置 Home 键位置
    setrotatescreen(HomeKeyPositionEnum[Settings.Script.HomeKeyPosition])
end

--注册机调用对应的方法
function ProcessState (stateTable,stateName,stateParam)  
    --XM.Print(stateTable)
    if stateTable[stateName] ~= nil  then        
        return stateTable[stateName](stateParam)        
    end
    return "Error"   
end

--脚本启动方法
function floatwinrun()
    Init()    
    if Unit.State.Name~="" then         
        if Settings.Process.IsLoop then             
            while true do
                Main()                
            end             
        else            
            Main()            
        end        
    else
        Debug("程序异常,状态机 State.Name 为空....")
    end
    Debug("脚本结束",true)
    sleep(1000)
    XM.MsgClose()
end

--状态机主程序
function Main()    
    
    --异常处理
    local res,error= pcall(    
    function ()
        XM.KeepScreen() --对图色功能数据进行刷新
        --调用状态机
        Unit.State.Name=ProcessState(
        Unit.State,--所有状态
        Unit.State.Name,--调用的状态
        Unit.Param[Unit.State.Name]--调用状态的参数
        )
        --Debug(timenow()  .."当前状态:"..Unit.State.Name)        
        sleep(Settings.Process.SleepTime)--休息间隔
        
        XM.MsgClose()
    end    
    )
    --提示并记录 错误信息
    if res==false then           
        Debug("发生了错误!!!! \n"..error)   
        if WriteTxtFile(error) then
            Debug("日志记录成功..")
        end        
    end    
    
end

--画面提示信息
function Msg(str)   
    XM.Msg(str,Settings.Script.MsgBoxPosition_x,Settings.Script.MsgBoxPosition_y)  
end

--调试信息
function Print(str)
    XM.Print(str)
end

--debug输出
function Debug(str,isWriteFile)    
    
    isWriteFile=isWriteFile or false
   
    str=tostring(str) 
    Msg(str)     
    logex(str)
    Print(str)
    if isWriteFile then
        WriteTxtFile(str)
    end 
end

--写入txt
function WriteTxtFile(content)    
    
    if XM.Switch("创建文件夹") then
        foldercreate("/sdcard/神雕2脚本日志")
    end       
    
    local res=false
    local res,error= pcall(function ()   

    local dateNow=timenow()
    local logFileName=timeyear(dateNow).."_".. timemonth(dateNow).."_".. timeday(dateNow)
    
    local fd = fileopen("/sdcard/神雕2脚本日志/"..logFileName..".txt","a+")
    
    if(fd > 0) then                
        content="\n"..tostring(timenow()) .."\n\n\t\t".. content
        
        if XM.Switch("日志") then
            content="\n\n\n------------------------------\n"..content        
        end
        
        res= filewriteline(fd,content)
    end
    fileclose(fd) 
    
    end)
    
    if res==false then
        Debug(error)
    end
    
    return res
end

--等待
function Wait(list,num)
    sleep(1000)
    list= list or {name="任务"}
    --间隔x秒               
    local countDown=num          
    while true do
        if countDown<=0 then
            return true
        else            
            Debug("***["..list.name.."]进行中-->>>>>>倒计时:"..XM.DateRet(countDown))
        end
        
        countDown = countDown - 10
        sleep(10000)        
    end
end

--[[

FindNumRet
Find
添加刷新找图

Unit.State.Name="RunApp_Bilibili"
Settings.Process.IsLoop=true
Settings.Process.SleepTime=1000
Settings.Process.IsXMLog=true


ipairs,pairs

videos={
{181,278},
{535,258},
{199,603},
{518,615},
{198,992}
}

if #videos>0 then
    XM.RndTap(videos[1][1],videos[1][2])
    
    return "SendCoin"
else
    return ""
end
table.remove(videos,1)  



Unit.Param.帮派任务={
name="帮派任务"
}
function Unit.State.帮派任务(list)
    
    return list.name
end
--]]