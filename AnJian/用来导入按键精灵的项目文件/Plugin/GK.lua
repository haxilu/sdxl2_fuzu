--本插件由果壳王子出品   插件版本号V3.21   果壳王子QQ237154778   果壳王子微信号 gkwz1983   果壳学院疯狂编程教学群(QQ②群)：465560580
local U_F_O,mini_X,max_X,mini_Y,max_Y
function ScanTable(tbl)
    local ret = ""
    for key, value in pairs(tbl) do
        if (key ~= "_G") and (key ~= "package") then
            if type(value) == "table" then
                ret = ret .. "\r\n" .. key .. ScanTable(value)
            elseif type(value) == "function" then
                ret = ret .. "\r\n" .. key .. "(" .. type(value) .. ")"
            elseif type(value) == "userdata" then
                ret = ret .. "\r\n" .. key .. "(" .. type(value) .. ")"
            else
                ret = ret .. "\r\n" .. key .. "=" .. value .. "(" .. type(value) .. ")"
            end
        end
    end
    return ret
end

function QMPlugin.WC()
    return ScanTable(_G)
end
function UFO(s)
	U_F_O=s
end 
QMPlugin.UFO=UFO
function MM(x1,y1,x2,y2)
	mini_X=x1
	max_X=y1
	mini_Y=x2
	max_Y=y2
end 
QMPlugin.MM=MM
function CLK(...)
	local colorarg,x1,y1,x
	counter()	
	if ...==nil then
		return  
	end
	if type(...) == "table" then
		colorarg = ...
	else	
		colorarg = {...}
	end
	if type(colorarg[3])~="null" and type(colorarg[4])~="null" then
		
		x1,y1=CBD(colorarg) 
	 
		TapClick(colorarg[1],colorarg[2],x1,y1)
	else
		TapClick(colorarg[1],colorarg[2])	
	end
end 
QMPlugin.CLK=CLK
function CBD(colorarg)
	local x1,y1
	if U_F_O==nil then
		return colorarg
	end	
	x = LuaAuxLib.GetScreenInfo()
	if x==U_F_O then
		x1=colorarg[3]
		y1=colorarg[4] 
		return x1,y1 
	end
	if U_F_O < x then
		x1=colorarg[4]
		y1=(-colorarg[3]) 
	else
		x1=(-colorarg[4])
		y1=colorarg[3] 
	end	 
	return x1,y1	
end	
function FullWordUBEX2(data,TM,click)
	local l={}
	local k	
	if type(TM)=="boolean" then
		click=TM
		TM=5
	end 
	local T=1000,good
	if data==nil then return end
	if TM==nil or TM=="" or TM==0 or type(TM)=="boolean" then 
		if type(TM)=="boolean" then
			click=TM
		end	
		TM=5
	end
	for p=1,#data do
		k=k+1
		l[k]=#data[p]
	end	
	local find=false
	for ii=1,#data do 
		local t=data[ii]
		if click==false then
			if type(t[l[ii]]) =="boolean" then
				t[l[ii]]=false 
			else
				t[l[ii]+1]=false 	
			end 
		else
			if type(t[l[ii]]) =="boolean" then
				t[l[ii]]=true 
			else
				t[l[ii]+1]=true 	
			end	 
		end
		good=FullWordEX2(t) 
		if good[1]~=-1 then 
			find=true break 
		end  	 
	end 
	local good2		
	if find then
		for i=1,TM do 
			 
			sleep()
			local ok=false
			for ii=1,#data do 
				local t=data[ii]
				if click==false then
					if type(t[l[ii]]) =="boolean" then
						t[l[ii]]=false 
					else
						t[l[ii]+1]=false 	
					end 
				else
					if type(t[l[ii]]) =="boolean" then
						t[l[ii]]=true 
					else
						t[l[ii]+1]=true 	
					end	 
				end
				good2 = FullWord2(t)  
				if good2[1]~=-1 then 
					ok=true
				end    
			end 
			if ok==false then return good end 
		end 		
	end	
	return good
end
QMPlugin.FullWordUBEX2=FullWordUBEX2
function FullWordUBTM2(data,TM,click)
	local OK 
	if data==nil then return(false) end	
	if TM==nil or TM=="" or TM==0 or type(TM)=="boolean" then 
		if type(TM)=="boolean" then
			click=TM
		end	
		TM=5
	end
	for i=1,TM do
		sleep()	 
		OK=FullWordUB2(data,click)  
		if  OK[1]~=-1 then
			return OK
		end  		
	end 
	 
	return OK
end 
QMPlugin.FullWordUBTM2=FullWordUBTM2
function FullWordUBTMEX2(data,TM,click)
	if TM==nil or TM=="" or TM==0 or type(TM)=="boolean" then 
		if type(TM)=="boolean" then
			click=TM
		end	
		TM=5
	end
	local GOOD={-1}
	local ii=0
	local OK = FullWordUBTM2(data,TM,click)  
	if OK[1]~=-1 then
		for i=1,TM do
			ii=ii+1 
			sleep()
			GOOD=FullWordUB2(data,click) 
			if GOOD[1]==-1 then 
				return OK
			end
		end 
		if ii==TM then
			OK[1]=-1
		end
	end
	return OK	
end 
QMPlugin.FullWordUBTMEX2=FullWordUBTMEX2
function FullWordUB2(data,click)
	
	if data==nil then return(false) end	 	
	local find=false
	local l={}
	local k
	local ok={-1}
	
	for p=1,#data do
		k=k+1
		l[k]=#data[p]
	end
	
	for i=1,#data do 
		local t=data[i]
		
		if click==false then
			if type(t[l[i]]) =="boolean" then
				t[l[i]]=false 
			else
				t[l[i]+1]=false 	
			end 
		else
			if type(t[l[i]]) =="boolean" then
				t[l[i]]=true 
			else
				t[l[i]+1]=true 	
			end	 
		end 
		
		ok=FullWord2(t) 
		if ok[1]~=-1 then 
			return(ok)
		end 	
	end 
	return(ok)
end 
QMPlugin.FullWordUB2=FullWordUB2
function FullWordUBTMEX(data,TM,click)
	if TM==nil or TM=="" or TM==0 or type(TM)=="boolean" then 
		if type(TM)=="boolean" then
			click=TM
		end	
		TM=5
	end
	local ii=0
	local GOOD={-1}
	if FullWordUBTM(data,TM,click) then
		for i=1,TM do
			ii=ii+1 
			sleep()
			GOOD=FullWordUB2(data,click) 
			if GOOD[1]==-1 then 
				return true
			end
		end 
		if ii==TM then
			return false
		end
	else
		return false
	end
end 
QMPlugin.FullWordUBTMEX=FullWordUBTMEX
function FullWordUBEX(data,TM,click)
	local l={}
	local k
	if type(TM)=="boolean" then
		click=TM
		TM=5
	end 
	local T=1000
	if data==nil then return end
	if TM==nil or TM=="" or TM==0 or type(TM)=="boolean" then 
		if type(TM)=="boolean" then
			click=TM
		end	
		TM=5
	end
	for p=1,#data do
		k=k+1
		l[k]=#data[p]
	end
	local find=false
	for ii=1,#data do 
		local t=data[ii]
		if click==false then
			if type(t[l[ii]]) =="boolean" then
				t[l[ii]]=false 
			else
				t[l[ii]+1]=false 	
			end 
		else
			if type(t[l[ii]]) =="boolean" then
				t[l[ii]]=true 
			else
				t[l[ii]+1]=true 	
			end	 
		end
		if FullWord(t) then 
			find=true break 
		end	
	end 
			
	if find then
		for i=1,TM do 
			 
			sleep()
			local ok=false
			for ii=1,#data do 
				local t=data[ii]
				if click==false then
					if type(t[l[ii]]) =="boolean" then
						t[l[ii]]=false 
					else
						t[l[ii]+1]=false 	
					end 
				else
					if type(t[l[ii]]) =="boolean" then
						t[l[ii]]=true 
					else
						t[l[ii]+1]=true 	
					end	 
				end
				if FullWord(t) then 
					ok=true  
				end	
			end 
			if ok==false then return true end 
		end 		
	end 		
	return false
end
QMPlugin.FullWordUBEX=FullWordUBEX
function FullWordUBTM(data,TM,click)
	if data==nil then return(false) end	
	if TM==nil or TM=="" or TM==0 or type(TM)=="boolean" then 
		if type(TM)=="boolean" then
			click=TM
		end	
		TM=5
	end
	for i=1,TM do
		sleep()	 
		if FullWordUB(data,click) then 
			 return true
		end  		
	end 
	return false
end 
QMPlugin.FullWordUBTM=FullWordUBTM
function FullWordUB(data,click)
	
	if data==nil then return(false) end	 	
	local find=false
	local l={}
	local k
	for p=1,#data do
		k=k+1
		l[k]=#data[p]
	end	
	for i=1,#data do 
		local t=data[i]
		if click==false then
			if type(t[l[i]]) =="boolean" then
				t[l[i]]=false 
			else
				t[l[i]+1]=false 	
			end 
		else
			if type(t[l[i]]) =="boolean" then
				t[l[i]]=true 
			else
				t[l[i]+1]=true 	
			end	 
		end
		if FullWord(t) then
			find=true break 
		end	
	end 
	if find then return true else return false end
end 
QMPlugin.FullWordUB=FullWordUB
function FullOcr(...)
	local colorarg
	local x1,y1,x2,y2,s1,sim
	counter()	
	if ...==nil then
		return  
	end	 
	
	if type(...) == "table" then
		colorarg = ...
	else	
		colorarg = {...}
	end
	if type(colorarg[1])=="number" then
		x1=colorarg[1]
		y1=colorarg[2]
		x2=colorarg[3]
		y2=colorarg[4]
		s1=colorarg[5]
		sim=colorarg[6] 
	else
		x1=0
		y1=0
		x2=0
		y2=0	
		s1=colorarg[1]
		sim=colorarg[2]
	end 	
	if type(sim)== "null" then
		sim = 0.9
	end 
	CJ3(colorarg)
	if U_F_O~=nil then
		if type(colorarg[1])=="number" then
			x1=colorarg[1]
			y1=colorarg[2]
			x2=colorarg[3]
			y2=colorarg[4]
		end	
	end	
	return LuaAuxLib.Ocr(x1,y1,x2,y2,s1,sim)
end 
QMPlugin.FullOcr=FullOcr
function FullWordTMEX2(data,TM)
	if TM==nil or TM=="" or TM==0 or type(TM)=="boolean" then 
		if type(TM)=="boolean" then
			click=TM
		end	
		TM=5
	end
	local GOOD={-1}
	local ii=0
	local OK = FullWordTM2(data,TM)  
    if  OK[1]~=-1 then
		for i=1,TM do
			ii=ii+1 
			sleep() 
			GOOD=FullWord2(data,TM) 
			if GOOD[1]==-1 then 
				return OK
			end
		end 
		if ii==TM then
			OK[1]=-1
		end
	end
	return OK
end 	
QMPlugin.FullWordTMEX2=FullWordTMEX2
function FullWordEX2(data,TM)
	 
	local T=1000,yes
	if data==nil then 
		return
	end  
	if TM==nil or TM=="" or TM==0 or type(TM)=="boolean" then 
		if type(TM)=="boolean" then
			click=TM
		end	
		TM=5
	end
	local find=false
	yes=FullWord2(data)
	if yes[1]>=0 then
		find=true
	end 		
	if find then
		for i=1,TM do 
			
			sleep()
			local OK
			local GOOD=false 
			OK= FullWord2(data)
			if OK[1]>=0 then
				GOOD=true  	
			end		
			if GOOD==false then return yes end 
		end 		
	end 	
	yes[1]=-1
	return yes
end
QMPlugin.FullWordEX2=FullWordEX2
function FullWordTMEX(data,TM)
	if TM==nil or TM=="" or TM==0 or type(TM)=="boolean" then 
		if type(TM)=="boolean" then
			click=TM
		end	
		TM=5
	end
	if FullWordTM(data,TM) and FullWordEX(data,TM) then
		return true
	else
		return false
	end
end 	
QMPlugin.FullWordTMEX=FullWordTMEX
function FullWordTM2(data,TM)
	local OK
	if data==nil then return(false) end	
	if TM==nil or TM=="" or TM==0 or type(TM)=="boolean" then 
		if type(TM)=="boolean" then
			click=TM
		end	
		TM=5
	end
	for i=1,TM do
		sleep()	 
		OK=FullWord2(data)   
		if OK[1]~=-1 then 
			return OK
		end  			
	end 
	return OK
end 
QMPlugin.FullWordTM2=FullWordTM2
function FullWord(...)
	local colorarg
	local x1,y1,x2,y2,s1,s2,sim,ok,x,y,z,click
	counter()	
	if ...==nil then
		return  
	end	 
	if type(...) == "table" then
		colorarg = ...
	else	
		colorarg = {...}
	end
	if type(colorarg[1])=="number" then
		x1=colorarg[1]
		y1=colorarg[2]
		x2=colorarg[3]
		y2=colorarg[4]
		s1=colorarg[5]
		s2=colorarg[6]
		if type(colorarg[7])=="boolean" then
			sim=0.9
			click=colorarg[7]
			 
		elseif type(colorarg[7])=="number" then
			sim = colorarg[7] 
			click=colorarg[8]
			 
		elseif type(colorarg[7])=="null" then
			sim =0.9
			click=true
			 
		end
	else
		x1=0
		y1=0
		x2=0
		y2=0	
		s1=colorarg[1]
		s2=colorarg[2]
		if type(colorarg[3]=="boolean") then 
			sim=0.9
			click=colorarg[3]
		elseif type(colorarg[3]=="number") then
			sim = colorarg[3] 
			click=colorarg[4]	
		end
		click=colorarg[4] 
	end 	
	if type(sim)== "null" then
		sim = 0.9
	end 	
	if type(click) ~= "boolean" then
		if type(click) == "null"  then
			click = true
		else	
			click = false 
		end 		
	end 
	CJ3(colorarg)
	if U_F_O~=nil then
		if type(colorarg[1])=="number" then
			x1=colorarg[1]
			y1=colorarg[2]
			x2=colorarg[3]
			y2=colorarg[4]
		end	
	end	 
	x,y,z= LuaAuxLib.FindStr (x1,y1,x2,y2,s1,s2,sim)	
	if z>=0 then
		if click==true then
			TapClick(x,y)
		end
		return true
	else
		return false
	end	
end 	
QMPlugin.FullWord=FullWord
function FullWordEX(data,TM)
	local T=1000
	if data==nil then return end
	if TM==nil or TM=="" or TM==0 or type(TM)=="boolean" then 
		if type(TM)=="boolean" then
			click=TM
		end	
		TM=5
	end
	local find=false
	if FullWord(data) then 
		find=true  
	end		
	if find then
		for i=1,TM do 
			sleep()
			local ok=false
			if FullWord(data) then 
				ok=true  
			end	
			if ok==false then return true end 
		end 		
	end 		
	return false
end
QMPlugin.FullWordEX=FullWordEX


function FullWordTM(data,TM)
	if data==nil then 
		return(false) 
	end
	if TM==nil or TM=="" or TM==0 or type(TM)=="boolean" then 
		if type(TM)=="boolean" then
			click=TM
		end	
		TM=5
	end
	for i=1,TM do
		
		sleep()	 
		if FullWord(data) then 
			 return true
		end  		
	end 
	return false
end 	
QMPlugin.FullWordTM=FullWordTM


function FullWord2(...)
	local colorarg
	local x1,y1,x2,y2,s1,s2,sim,ok,x,y,z,click
	counter()	
	if ...==nil then
		return  
	end	 
	if type(...) == "table" then
		colorarg = ...
	else	
		colorarg = {...}
	end
	if type(colorarg[1])=="number" then
		x1=colorarg[1]
		y1=colorarg[2]
		x2=colorarg[3]
		y2=colorarg[4]
		s1=colorarg[5]
		s2=colorarg[6]
		if type(colorarg[7])=="boolean" then
			sim=0.9
			click=colorarg[7]
		 
		elseif type(colorarg[7])=="number" then
			sim = colorarg[7] 
			click=colorarg[8]
			 
		elseif type(colorarg[7])=="null" then
			sim =0.9
			click=true
			 
		end
	else
		x1=0
		y1=0
		x2=0
		y2=0	
		s1=colorarg[1]
		s2=colorarg[2]
		if type(colorarg[3]=="boolean") then 
			sim=0.9
			click=colorarg[3]
		elseif type(colorarg[3]=="number") then
			sim = colorarg[3] 
			click=colorarg[4]	
		end
		click=colorarg[4] 
	end 	
	if type(sim)== "null" then
		sim = 0.9
	end 	
	if type(click) ~= "boolean" then
		if type(click) == "null"  then
			click = true
		else	
			click = false 
		end 		
	end 
	CJ3(colorarg)
	if U_F_O~=nil then
		if type(colorarg[1])=="number" then
			x1=colorarg[1]
			y1=colorarg[2]
			x2=colorarg[3]
			y2=colorarg[4]
		end	
	end	
	x,y,z= LuaAuxLib.FindStr (x1,y1,x2,y2,s1,s2,sim)	
	if z>=0 and click==true then
		TapClick(x,y)
	end
	local t={z,x,y}
	return t
end 	
QMPlugin.FullWord2=FullWord2
function Split(s, sp)
    local res = {}
    local temp = s
    local len = 0
    while true do
        len = string.find(temp, sp)
        if len ~= nil then
            local result = string.sub(temp, 1, len-1)
            temp = string.sub(temp, len+1)
            table.insert(res, result)
        else
            table.insert(res, temp)
            break
        end
    end
    return res
end
function CJ4(colorarg)
	 if U_F_O==nil then
		return colorarg
	 end 	
	 local x1,y1,x,y
	 x = LuaAuxLib.GetScreenInfo()
	 if x==U_F_O then
		return colorarg 
	 end
	 
	if U_F_O < x then
		y=U_F_O
	end	
	if y~=nil then 
		x1=colorarg[2]
		y1=(y-colorarg[1]-1)	
    else		
		x1=(x-colorarg[2]-1)
		y1=colorarg[1]
    end 		
	colorarg[1]=x1
	colorarg[2]=y1
	return colorarg
end
function CJ3(colorarg)
	local x1,y1,x2,y2,x
	if U_F_O==nil then
	   return colorarg
	end 
	x = LuaAuxLib.GetScreenInfo()
	if x==U_F_O then
		return colorarg 
	end
	if type(colorarg[1])=="number" then
		x1,y1,x2,y2=CJJ(colorarg,x)
		colorarg[1]=x1
		colorarg[2]=y1
		colorarg[3]=x2
		colorarg[4]=y2
	end
	return colorarg
end	
function CJ2(colorarg)
	local x1,y1,x2,y2,x,arr,yes,ok,wc_
	if U_F_O==nil then
	   return colorarg
	end 
	x = LuaAuxLib.GetScreenInfo()
	if x==U_F_O then
		return colorarg 
	end
	if type(colorarg[1])=="number" then
		x1,y1,x2,y2=CJJ(colorarg,x)
		colorarg[1]=x1
		colorarg[2]=y1
		colorarg[3]=x2
		colorarg[4]=y2
		wc_=6 
	else
		wc_=2	
	end
	arr=Split(colorarg[wc_],",") 
	for i in pairs(arr) do  
		ok=Split(arr[i],"|")
		if U_F_O < x then	
			arr[i]=ok[2].."|"..(-ok[1]).."|"..ok[3]
		else	
			arr[i]=(-ok[2]).."|"..ok[1].."|"..ok[3]
		end
		yes=yes..arr[i]
		if i~=#arr then
			yes=yes..","
		end 
	end 	
	colorarg[wc_]=yes
	return colorarg
end
function CJJ(colorarg,x)
	local x1,y1,x2,y2,y
	if U_F_O < x then
		y=U_F_O
	end	
	if y~=nil then 
		x1=colorarg[2]
		y1=(y-colorarg[1]-1)	
		x2=colorarg[4]
		y2=(y-colorarg[3]-1) 
    else		
		x1=(x-colorarg[2]-1)
		y1=colorarg[1]
		x2=(x-colorarg[4]-1)
		y2=colorarg[3]
    end
	return x1,y1,x2,y2
end

function CJ(colorarg)
	 if U_F_O==nil then
		return colorarg
	 end 	
	 local ok,yes,str,x,arr,y
	 x = LuaAuxLib.GetScreenInfo()
	 if x==U_F_O then
		return colorarg 
	 end
	 if U_F_O < x then
		y=U_F_O
	 end		
	 arr=Split(colorarg[1],",") 
	 for i in pairs(arr) do  
		 ok=Split(arr[i],"|")
		 if y~=nil then 
			arr[i]=ok[2].."|"..(y-ok[1]-1).."|"..ok[3]
         else
            arr[i]=(x-ok[2]-1).."|"..ok[1].."|"..ok[3]
         end
		 yes=yes..arr[i]
		 if i~=#arr then
			yes=yes..","
		 end 
	 end 
	 colorarg[1]=yes
	 return colorarg
end
function Full(...)
	counter()	
	if ...==nil then
		return  
	end	 
	local touch ,find,dir,sim= true,false,0,0.9
	local colorarg,tag
	local x1,y1,x2,y2,s1,s2 =0,0,0,0,"",""
	if type(...) == "table" then
		colorarg = ...
	else	
		colorarg = {...}
	end
	
	pcall(function ()	
	if #colorarg == 1 then
		s1 = colorarg[1]
	elseif( #colorarg == 2) then
		s1 =colorarg[1]
		if (type(colorarg[2]) == "string") then
			s2 =colorarg[2]
		elseif (type(colorarg[2]) =="number" ) then
			if colorarg[2]>0 and colorarg[2]<1 then
				sim = colorarg[2]
			else
				dir = colorarg[2]
			end
		elseif (type(colorarg[2]) == "boolean") then
			touch = colorarg[2]
		end
	elseif(#colorarg == 3) then
		s1 =colorarg[1];
		if(type(colorarg[2]) == "string") then
			s2 =colorarg[2]
		elseif (type(colorarg[2]) == "number") then
			if colorarg[2]>0 and colorarg[2]<1 then
				sim = colorarg[2]
			else
				dir = colorarg[2]
			end
		elseif (type(colorarg[2]) == "boolean") then
			touch = colorarg[2]
		end
		if (type(colorarg[3]) == "number") then
			if colorarg[3]>0 and colorarg[3]<1 then
				sim = colorarg[3]
			else
				dir = colorarg[3]
			end
		elseif (type(colorarg[3]) == "boolean") then
			touch = colorarg[3]
		end
	elseif (#colorarg>3 and #colorarg<6) then
		x1,y1,x2,y2 = 0,0,0,0
		s1 = colorarg[1]
		if(type(colorarg[2]) == "string") then
			s2 =colorarg[2]
		elseif (type(colorarg[2]) == "number") then
			if colorarg[2]>0 and colorarg[2]<1 then
				sim = colorarg[2]
			else
				dir = colorarg[2]
			end
		elseif (type(colorarg[2]) == "boolean") then
			touch = colorarg[2]
		end
		if (type(colorarg[3]) == "number") then
			if colorarg[3]>0 and colorarg[3]<1 then
				sim = colorarg[3]
			else
				dir = colorarg[3]
			end
		elseif (type(colorarg[3]) == "boolean") then
			touch = colorarg[3]
		end
		if (type(colorarg[4]) == "number") then
			if colorarg[4]>0 and colorarg[4]<1 then
				sim = colorarg[4]
			else
				dir = colorarg[4]
			end
		elseif (type(colorarg[4]) == "boolean") then
			touch = colorarg[4]
		end
		if (type(colorarg[5]) == "number") then
			if colorarg[5]>0 and colorarg[5]<1 then
				sim = colorarg[5]
			else
				dir = colorarg[5]
			end
		elseif (type(colorarg[5]) == "boolean") then
			touch = colorarg[5]
		elseif (type(colorarg[5]) == "string") then
			x1,y1,x2,y2 = colorarg[1],colorarg[2],colorarg[3],colorarg[4]
			s1 = colorarg[5] 
		end
	elseif (#colorarg>=6) then
		x1,y1,x2,y2 = colorarg[1],colorarg[2],colorarg[3],colorarg[4]
		s1 = colorarg[5]
		if(type(colorarg[6]) == "string") then
			s2 =colorarg[6]
		elseif (type(colorarg[6]) == "number") then

			if colorarg[6]>0 and colorarg[6]<1 then
				sim = colorarg[6]
			else
				dir = colorarg[6]
			end
		elseif (type(colorarg[6]) == "boolean") then
			touch = colorarg[6]
		end
		if (type(colorarg[7]) == "number") then
			 
			if colorarg[7]>0 and colorarg[7]<1 then
				sim = colorarg[7]
			else
				dir = colorarg[7]
			end
		elseif (type(colorarg[7]) == "boolean") then
			touch = colorarg[7]
		end
		if type(colorarg[8])== "number"then
			if colorarg[8]>0 and colorarg[8]<1 then
				sim = colorarg[8]
			else
				dir = colorarg[8]
			end
		elseif type(colorarg[8])== "boolean" then
			touch = colorarg[8] 
		end
		if #colorarg == 9 then
			touch = colorarg[9]
		end
		
	end
	
	  if type(colorarg[1])== "number" and type(colorarg[2])== "number"  and type(colorarg[3])== "string" then
		    ms("CmpColor")
			local x1=colorarg[1];local y1=colorarg[2];local s1=colorarg[3] 
			 if colorarg[4]==null then 
				sim=0.9 
			 end 
			 x = LuaAuxLib.CmpColor (x1,y1,s1,sim)	
		     if (x>-1) then
				find =true
				 
				if colorarg[4]~=false and type(colorarg[4])~= "number" then
					TapClick(x1,y1)
			 
				elseif type(colorarg[4])== "number" and type(colorarg[5])== "null" then
					TapClick(x1,y1)	 
				elseif type(colorarg[4])== "number" and colorarg[5]== true then
					TapClick(x1,y1)
				end
			 else
				find =false	  
		     end	
		  
		 do return find end 	 	
	  end 	
	
	 if type(colorarg[1])== "number" and type(colorarg[2])== "number"  and type(colorarg[3])== "null" then
				
			    local x1=colorarg[1];local y1=colorarg[2] 
				ms ("GetPixelColor")
				CJ4(colorarg)
				if U_F_O~=nil then
					x1=colorarg[1]
					y1=colorarg[2]
				end 
				x = LuaAuxLib.GetPixelColor (x1,y1,0)	
			    find =x
				do return find end 	       	
	  end  
	 
	tag = string.find(s1, "png")
	if tag then
		if y2==dir then
			dir=0
		end 
		ms("FindPicture") 
		CJ3(colorarg)
		if U_F_O~=nil then
			if type(colorarg[1])=="number" then
				x1=colorarg[1]
				y1=colorarg[2]
				x2=colorarg[3]
				y2=colorarg[4]
			end	
		end	 
		if s2=="" then
			s2="000000"
		end  	
		x,y,z= LuaAuxLib.FindPicture(x1,y1,x2,y2,s1,s2,dir,sim) 
	 
		if (x>-1) then
			find=true
			if touch then
				TapClick(x,y)
			end	
		else
			find=false
		end
		do return find end
	else
	 
		 
		if (#colorarg<3) and (type(colorarg[1])~="string") or (type(colorarg[1])=="string" and type(colorarg[2])=="boolean") or (type(colorarg[1])=="string" and type(colorarg[2])=="number")  then
			
			local sub = string.match(s1,"(%w+)")
		    
			if string.len(tostring(sub)) == 6 then
				ms("FindColor") 
				CJ3(colorarg)
				if U_F_O~=nil then
					if type(colorarg[1])=="number" then
						x1=colorarg[1]
						y1=colorarg[2]
						x2=colorarg[3]
						y2=colorarg[4]
					end	
				end	 
				 
				x,y,z = LuaAuxLib.FindColor(x1,y1,x2,y2,s1,dir,sim)
				 
			 
				if (x>-1) then
					 find=true
					if touch then
						TapClick(x,y)
					end
				else
					find=false
				end
				do return find end
			else
				ms("CmpColorEx") 	
				CJ(colorarg)
				s1=colorarg[1]
				if (LuaAuxLib.CmpColorEx(s1,sim)==1) then
					   find = true
					 
						x,y = string.match(s1,"(%d+)|(%d+)")
						 
						if type(colorarg[2])=="number" and colorarg[3]==true then
							TapClick(x,y)
						elseif type(colorarg[2])=="number" and type(colorarg[3])=="null" then
							TapClick(x,y)			
						elseif type(colorarg[1])=="string" and #colorarg==2 and colorarg[2]==true then
							 TapClick(x,y)		
						end
					 
				else 
					find = false
				end
				do return find end
			end
		else
			 
			if (#colorarg==3 and type(colorarg[3])=="boolean") or (#colorarg==4 and type(colorarg[4])=="boolean") or (#colorarg==1 and type(colorarg[1])=="string") then
				 
				 local findok=true
				 local sub = string.sub(s1,1,6)	
				 local p
				 
				 for p=1,6,1 do 
					 
					 if string.sub(tostring(sub),p,p)=="|" then   
						 
						findok=false
						break
					 end  
				 end
			
				if findok==true and type(colorarg[2])~="string" then
					 ms("FindColor2") 
					CJ3(colorarg)
					if U_F_O~=nil then
						if type(colorarg[1])=="number" then
							x1=colorarg[1]
							y1=colorarg[2]
							x2=colorarg[3]
							y2=colorarg[4]
						end	
					end	 
					x,y,z = LuaAuxLib.FindColor(x1,y1,x2,y2,s1,dir,sim)	 
				  
					if (x>-1) then
						 
						find=true
						if touch then
							TapClick(x,y)
						end
				    else
						find=false
					end
					do return find end
					
		  
				elseif type(colorarg[2])~="string" then
					ms("CmpColorEx2") 	 
					CJ(colorarg)
					s1=colorarg[1]
					if (LuaAuxLib.CmpColorEx(s1,sim)==1) then
						find = true
						 
							x,y = string.match(s1,"(%d+)|(%d+)")
							if colorarg[3]==true or #colorarg==1 then 
								 
								TapClick(x,y)
							end
						 
					else
						find = false
					end
					do return find end
				end
			end
			 
			if type(colorarg[6])== "string" or (type(colorarg[1])=="string" and type(colorarg[2])=="string") then
				ms("FindMultiColor")
				CJ2(colorarg)
				if U_F_O~=nil then
					if type(colorarg[1])=="number" then
						x1=colorarg[1]
						y1=colorarg[2]
						x2=colorarg[3]
						y2=colorarg[4]
						s2=colorarg[6]
					else
						s2=colorarg[2]	
					end	
				end	
				x,y = LuaAuxLib.FindMultiColor(x1,y1,x2,y2,s1,s2,dir,sim)
				if (x>-1) then
				 
					find = true
					if touch then
						TapClick(x,y)
					end
				else
				 
					find = false
				end
			 
				do return find end	
				
			else
				if y2==dir then
					dir=0
				end 
				 
			    ms("FindColor3") 
				CJ3(colorarg)
				if U_F_O~=nil then
					if type(colorarg[1])=="number" then
						x1=colorarg[1]
						y1=colorarg[2]
						x2=colorarg[3]
						y2=colorarg[4]
					end	
				end	 
				x,y,z = LuaAuxLib.FindColor(x1,y1,x2,y2,s1,dir,sim) 
			  
				if (x>-1) then
					find = true
					if touch then
						TapClick(x,y)
					end
				else
					find = false
				end
				do return find end
				
			end
			 
		end
		end
	end)
 
	local pos = {x1,y1,x2,y2,s1,s2,dir,sim}
	pos[9] = x
	pos[10] = y
	pos[11] = touch
	pos[12] = find

	return find
end
QMPlugin.Full=Full
function Full2(...)
	counter()		
	if ...==nil then
		return  
	end	 
	local touch ,find,dir,sim= true,false,0,0.9
	local colorarg,tag
	local x1,y1,x2,y2,s1,s2 =0,0,0,0,"",""

	if type(...) == "table" then
		colorarg = ...
	else
		colorarg = {...}
	end
	pcall(function ()	
	if #colorarg == 1 then
		s1 = colorarg[1]
	elseif( #colorarg == 2) then
		s1 =colorarg[1]
		if (type(colorarg[2]) == "string") then
			s2 =colorarg[2]
		elseif (type(colorarg[2]) =="number" ) then
			if colorarg[2]>0 and colorarg[2]<1 then
				sim = colorarg[2]
			else
				dir = colorarg[2]
			end
		elseif (type(colorarg[2]) == "boolean") then
			touch = colorarg[2]
		end
	elseif(#colorarg == 3) then
		s1 =colorarg[1];
		if(type(colorarg[2]) == "string") then
			s2 =colorarg[2]
		elseif (type(colorarg[2]) == "number") then
			if colorarg[2]>0 and colorarg[2]<1 then
				sim = colorarg[2]
			else
				dir = colorarg[2]
			end
		elseif (type(colorarg[2]) == "boolean") then
			touch = colorarg[2]
		end
		if (type(colorarg[3]) == "number") then
			if colorarg[3]>0 and colorarg[3]<1 then
				sim = colorarg[3]
			else
				dir = colorarg[3]
			end
		elseif (type(colorarg[3]) == "boolean") then
			touch = colorarg[3]
		end
	elseif (#colorarg>3 and #colorarg<6) then
		x1,y1,x2,y2 = 0,0,0,0
		s1 = colorarg[1]
		if(type(colorarg[2]) == "string") then
			s2 =colorarg[2]
		elseif (type(colorarg[2]) == "number") then
			if colorarg[2]>0 and colorarg[2]<1 then
				sim = colorarg[2]
			else
				dir = colorarg[2]
			end
		elseif (type(colorarg[2]) == "boolean") then
			touch = colorarg[2]
		end
		if (type(colorarg[3]) == "number") then
			if colorarg[3]>0 and colorarg[3]<1 then
				sim = colorarg[3]
			else
				dir = colorarg[3]
			end
		elseif (type(colorarg[3]) == "boolean") then
			touch = colorarg[3]
		end
		if (type(colorarg[4]) == "number") then
			if colorarg[4]>0 and colorarg[4]<1 then
				sim = colorarg[4]
			else
				dir = colorarg[4]
			end
		elseif (type(colorarg[4]) == "boolean") then
			touch = colorarg[4]
		end
		if (type(colorarg[5]) == "number") then
			if colorarg[5]>0 and colorarg[5]<1 then
				sim = colorarg[5]
			else
				dir = colorarg[5]
			end
		elseif (type(colorarg[5]) == "boolean") then
			touch = colorarg[5]
		elseif (type(colorarg[5]) == "string") then
			x1,y1,x2,y2 = colorarg[1],colorarg[2],colorarg[3],colorarg[4]
			s1 = colorarg[5]
			 
		end
	elseif (#colorarg>=6) then
		x1,y1,x2,y2 = colorarg[1],colorarg[2],colorarg[3],colorarg[4]
		s1 = colorarg[5]
		if(type(colorarg[6]) == "string") then
			s2 =colorarg[6]
		elseif (type(colorarg[6]) == "number") then

			if colorarg[6]>0 and colorarg[6]<1 then
				sim = colorarg[6]
			else
				dir = colorarg[6]
			end
		elseif (type(colorarg[6]) == "boolean") then
			touch = colorarg[6]
		end
		if (type(colorarg[7]) == "number") then
			 
			if colorarg[7]>0 and colorarg[7]<1 then
				sim = colorarg[7]
			else
				dir = colorarg[7]
			end
		elseif (type(colorarg[7]) == "boolean") then
			touch = colorarg[7]
		end
		if type(colorarg[8])== "number"then
			if colorarg[8]>0 and colorarg[8]<1 then
				sim = colorarg[8]
			else
				dir = colorarg[8]
			end
		elseif type(colorarg[8])== "boolean" then
			touch = colorarg[8] 
		end
		if #colorarg == 9 then
			touch = colorarg[9]
		end
		
	end
	
	  if type(colorarg[1])== "number" and type(colorarg[2])== "number"  and type(colorarg[3])== "string" then
			ms("CmpColor")
			local x1=colorarg[1];local y1=colorarg[2];local s1=colorarg[3] 
			 if colorarg[4]==null then 
				sim=0.9 
			 end 
			 x = LuaAuxLib.CmpColor (x1,y1,s1,sim)	
		     if (x>-1) then
			 
				
				if colorarg[4]~=false and type(colorarg[4])~= "number" then
					TapClick(x1,y1)
			 
				elseif type(colorarg[4])== "number" and type(colorarg[5])== "null" then
					TapClick(x1,y1)	 
				elseif type(colorarg[4])== "number" and colorarg[5]== true then
					TapClick(x1,y1)
				end
			 
				 
			    local t={x,nil,nil}
			    find =t	
				do return find end 	
		     end	
		    local t={-1,nil,nil}
			find =t	
			do return find end 	 	
	  end 	
	
	 if type(colorarg[1])== "number" and type(colorarg[2])== "number"  and type(colorarg[3])== "null" then
				
			    local x1=colorarg[1];local y1=colorarg[2] 
				ms ("GetPixelColor2")
				CJ4(colorarg)
				if U_F_O~=nil then
					x1=colorarg[1]
					y1=colorarg[2]
				end 	
			    x = LuaAuxLib.GetPixelColor (x1,y1,0)	
			    find =x
				do return find end 	       	
	  end  
	 
	tag = string.find(s1, "png")
	if tag then
		if y2==dir then
			dir=0
		end 
		ms("FindPicture2") 
		CJ3(colorarg)
		if U_F_O~=nil then
			if type(colorarg[1])=="number" then
				x1=colorarg[1]
				y1=colorarg[2]
				x2=colorarg[3]
				y2=colorarg[4]
			end	
		end	 
		if s2=="" then
			s2="000000"
		end  		
		x,y,z= LuaAuxLib.FindPicture(x1,y1,x2,y2,s1,s2,dir,sim) 
		t={z,x,y}
		find = t
	 
		if (x>-1) then
			 
			if touch then
				TapClick(x,y)
			end	
	 
		end
		do return find end
	else
	 
		 
		if (#colorarg<3) and (type(colorarg[1])~="string") or (type(colorarg[1])=="string" and type(colorarg[2])=="boolean") or (type(colorarg[1])=="string" and type(colorarg[2])=="number")  then
			
			local sub = string.match(s1,"(%w+)")
		    
			if string.len(tostring(sub)) == 6 then
				ms("FindColor4") 	
				CJ3(colorarg)
				if U_F_O~=nil then
					if type(colorarg[1])=="number" then
						x1=colorarg[1]
						y1=colorarg[2]
						x2=colorarg[3]
						y2=colorarg[4]
					end	
				end	 
				x,y,z = LuaAuxLib.FindColor(x1,y1,x2,y2,s1,dir,sim)
				 
			    t={z,x,y} 
				find = t
				if (x>-1) then
				 
					if touch then
						TapClick(x,y)
					end
				else
				 
				end
				do return find end
			else
				ms("CmpColorEx3") 	
				CJ(colorarg)
				s1=colorarg[1]
				 
				if (LuaAuxLib.CmpColorEx(s1,sim)==1) then
					 
					  
						x,y = string.match(s1,"(%d+)|(%d+)")
						 
						if type(colorarg[2])=="number" and colorarg[3]==true then
							 
							TapClick(x,y)
						elseif type(colorarg[2])=="number" and type(colorarg[3])=="null" then
							 
							TapClick(x,y)		
						elseif type(colorarg[1])=="string" and #colorarg==2 and colorarg[2]==true then
							TapClick(x,y)					
						end
						local t={true,x,y}
						find=t
					 
				else 
					 
					 local t={false,-1,-1}
					 find=t
				end
				do return find end
			end
		else
			 
			if (#colorarg==3 and type(colorarg[3])=="boolean") or (#colorarg==4 and type(colorarg[4])=="boolean") or (#colorarg==1 and type(colorarg[1])=="string") then
				 
				 local findok=true
				 local sub = string.sub(s1,1,6)	
				 local p
				 
				 for p=1,6,1 do 
					 
					 if string.sub(tostring(sub),p,p)=="|" then   
						 
						findok=false
						break
					 end  
				 end
				if findok==true and type(colorarg[2])~="string" then
					ms("FindColor5") 
					CJ3(colorarg)
					if U_F_O~=nil then
						if type(colorarg[1])=="number" then
							x1=colorarg[1]
							y1=colorarg[2]
							x2=colorarg[3]
							y2=colorarg[4]
						end	
					end	 
					x,y,z = LuaAuxLib.FindColor(x1,y1,x2,y2,s1,dir,sim)	 
					
				    t={z,x,y} 
					find = t
					if (x>-1) then
						 
						 
						if touch then
							TapClick(x,y)
						end
				    else
						 
					end
					do return find end
					
		  
				elseif type(colorarg[2])~="string" then
					ms("CmpColorEx4") 
					CJ(colorarg)
					s1=colorarg[1]	 
					if (LuaAuxLib.CmpColorEx(s1,sim)==1) then
							
						x,y = string.match(s1,"(%d+)|(%d+)")
	
						if colorarg[3]==true or #colorarg==1 then 
							TapClick(x,y)
						end

						t={true,x,y} 
					    find = t
						
						
					else
						 
						t={false,-1,-1} 
					    find = t
					end
					do return find end
				end
			end
			 
			if type(colorarg[6])== "string" or (type(colorarg[1])=="string" and type(colorarg[2])=="string") then
				ms("FindMultiColor2") 
				CJ2(colorarg)
				if U_F_O~=nil then
					if type(colorarg[1])=="number" then
						x1=colorarg[1]
						y1=colorarg[2]
						x2=colorarg[3]
						y2=colorarg[4]
						s2=colorarg[6]
					else
						s2=colorarg[2]	
					end	
				end	
				x,y = LuaAuxLib.FindMultiColor(x1,y1,x2,y2,s1,s2,dir,sim)
				
			 
				if (x>-1) then
					t={true,x,y}
					 
					if touch then
						TapClick(x,y)
					end
				else
					t={false,x,y}	
					 
				end
				find=t
				do return find end	
				
			else
				if y2==dir then
					dir=0
				end 
				 
				ms("FindColor6") 
				CJ3(colorarg)
				if U_F_O~=nil then
					if type(colorarg[1])=="number" then
						x1=colorarg[1]
						y1=colorarg[2]
						x2=colorarg[3]
						y2=colorarg[4]
					end	
				end	 
				x,y,z = LuaAuxLib.FindColor(x1,y1,x2,y2,s1,dir,sim)
				
			    t={z,x,y} 
				find = t
				if (x>-1) then
					 
					if touch then
						TapClick(x,y)
					end	 
				end
				do return find end
				
			end
			 
		end
		end
	end)
 
	local pos = {x1,y1,x2,y2,s1,s2,dir,sim}
	pos[9] = x
	pos[10] = y
	pos[11] = touch
	pos[12] = find

	return find
end
QMPlugin.Full2=Full2
function FullUB(data,click)
	if data==nil then return(false) end	 	
	local find=false
	local l={}
	local k 
	for p=1,#data do
		k=k+1
		l[k]=#data[p]
	end
	for i=1,#data do
		local t=data[i]
		if click==false then
			if type(t[l[i]]) =="boolean" then
				t[l[i]]=false 
			else
				t[l[i]+1]=false 	
			end 
		else
			if type(t[l[i]]) =="boolean" then
				t[l[i]]=true 
			else
				t[l[i]+1]=true 	
			end	 
		end
		 
		if Full(t) then 
			find=true break 
		end	
	end 
	if find then return true else return false end 
 
end 
QMPlugin.FullUB=FullUB
function FullUB2(data,click)
	if data==nil then return(false) end	 	
	local find=false
	local ok={-1}
	local l={}
	local k
	for p=1,#data do
		k=k+1
		l[k]=#data[p]
	end
	for i=1,#data do 
		local t=data[i]
		if click==false then
			if type(t[l[i]]) =="boolean" then
				t[l[i]]=false 
			else
				t[l[i]+1]=false 	
			end 
		else
			if type(t[l[i]]) =="boolean" then
				t[l[i]]=true 
			else
				t[l[i]+1]=true 	
			end	 
		end
		ok=Full2(t) 
		if ok[1]~=-1 and ok[1]~=false then 
			return(ok)
		end 	
	end 
	return(ok)
end 
QMPlugin.FullUB2=FullUB2
function FullTM(data,TM)
	if data==nil then return(false) end	
	if TM==nil or TM=="" or TM==0 or type(TM)=="boolean" then 
		if type(TM)=="boolean" then
			click=TM
		end	
		TM=5
	end
	for i=1,TM do
		sleep()	 
		if Full(data) then 
			 return true
		end  		
	end 
	return false
end 
QMPlugin.FullTM=FullTM
function FullTM2(data,TM)
	local OK
	if data==nil then return(false) end	
	if TM==nil or TM=="" or TM==0 or type(TM)=="boolean" then 
		if type(TM)=="boolean" then
			click=TM
		end	
		TM=5
	end
	for i=1,TM do
		sleep()	 
		OK=Full2(data)   
		if OK[1]~=-1 and OK[1]~=false then 
			return OK
		end  			
	end 
	return OK
end 
QMPlugin.FullTM2=FullTM2
function FullUBTM(data,TM,click)
	if data==nil then return(false) end	
	 
	if TM==nil or TM=="" or TM==0 or type(TM)=="boolean" then 
		if type(TM)=="boolean" then
			click=TM
		end	
		TM=5
	end
 
	for i=1,TM do
		sleep()	 
		if FullUB(data,click) then 
			 return true
		end  		
	end 
	return false
end 
QMPlugin.FullUBTM=FullUBTM
function FullUBTM2(data,TM,click)
	local OK
	if data==nil then return(false) end	
	if TM==nil or TM=="" or TM==0 or type(TM)=="boolean" then 
		if type(TM)=="boolean" then
			click=TM
		end	
		TM=5
	end
	for i=1,TM do
		sleep() 
		OK=FullUB2(data,click)  
		if OK[1]~=-1 and OK[1]~=false then
			return OK
		end
	end
	return OK
end 
QMPlugin.FullUBTM2=FullUBTM2
function FullEX(data,TM)
	local T=1000
	if data==nil then return end
	if TM==nil or TM=="" or TM==0 or type(TM)=="boolean" then 
		if type(TM)=="boolean" then
			click=TM
		end	
		TM=5
	end
	local find=false
	if Full(data) then 
		find=true  
	end		
	if find then
		for i=1,TM do 
			sleep()
			local ok=false
			if Full(data) then 
				ok=true  
			end	
			if ok==false then return true end 
		end 		
	end 		
	return false
end
QMPlugin.FullEX=FullEX
function FullEX2(data,TM)
	local T=1000,yes
	if data==nil then return end
	if TM==nil or TM=="" or TM==0 or type(TM)=="boolean" then 
		if type(TM)=="boolean" then
			click=TM
		end	
		TM=5
	end
	local find=false
	yes=Full2(data)   
	if yes[1]==true then
		find=true 
	end 		
	if find then
		for i=1,TM do 
			sleep()
			local OK
			local GOOD=false 
			OK= Full2(data)   
			if OK[1]==true then
				GOOD=true  	
			end		
			if GOOD==false then return yes end 
		end 		
	end 	
	yes[1]=false
	return yes
end
QMPlugin.FullEX2=FullEX2
function FullUBEX(data,TM,click)
	local l={}
	local k	
	if type(TM)=="boolean" then
		click=TM
		TM=5
	end 
	local T=1000
	if data==nil then return end
	if TM==nil or TM=="" or TM==0 or type(TM)=="boolean" then 
		if type(TM)=="boolean" then
			click=TM
		end	
		TM=5
	end
	for p=1,#data do
		k=k+1
		l[k]=#data[p]
	end	
	local find=false
	for ii=1,#data do 
		local t=data[ii]
		if click==false then
			if type(t[l[ii]]) =="boolean" then	 
					t[l[ii]]=false 
				else	 
					t[l[ii]+1]=false 	
				end 
			else
				if type(t[l[ii]]) =="boolean" then	
					t[l[ii]]=true 
					ms(l[ii]) 
				else	 
					t[l[ii]+1]=true 	
				end	 
			end
		if Full(t) then 
			find=true break 
		end	
	end 
	if find then
		for i=1,TM do 
			 
			sleep()
			local ok=false
			for ii=1,#data do 
				local t=data[ii]
				
				
				if click==false then
					if type(t[l[ii]]) =="boolean" then
						 
						t[l[ii]]=false 
					else
						 
						t[l[ii]+1]=false 	
					end 
				else
					if type(t[l[ii]]) =="boolean" then
						
						t[l[ii]]=true 
						ms(l[ii]) 
					else
						 
						t[l[ii]+1]=true 	
					end	 
				end
				
				
				 
				if Full(t) then 
					ok=true  
				end	
			end 
			if ok==false then return true end 
		end 		
	end 		
	return false
end
QMPlugin.FullUBEX=FullUBEX
function FullUBEX2(data,TM,click)
	local l={}
	local k	
	if type(TM)=="boolean" then
		click=TM
		TM=5
	end 
	local T=1000,good
	if data==nil then return end
	if TM==nil or TM=="" or TM==0 or type(TM)=="boolean" then 
		if type(TM)=="boolean" then
			click=TM
		end	
		TM=5
	end
	for p=1,#data do
		k=k+1
		l[k]=#data[p]
	end	
	local find=false
	for ii=1,#data do 
		local t=data[ii]
		if click==false then
			if type(t[l[ii]]) =="boolean" then
				t[l[ii]]=false 
			else
				t[l[ii]+1]=false 	
			end 
		else
			if type(t[l[ii]]) =="boolean" then
				t[l[ii]]=true 
			else
				t[l[ii]+1]=true 	
			end	 
		end
		good=FullEX2(t) 
		if good[1]~=-1 and good[1]~=false then 
			find=true break 
		end  	 
	end 
	local good2		
	if find then
		for i=1,TM do  
			sleep()
			local ok=false
			for ii=1,#data do 
				local t=data[ii]
				if click==false then
					if type(t[l[ii]]) =="boolean" then
						t[l[ii]]=false 
					else
						t[l[ii]+1]=false 	
					end 
				else
					if type(t[l[ii]]) =="boolean" then
						t[l[ii]]=true 
					else
						t[l[ii]+1]=true 	
					end	 
				end
				good2 = Full2(t)  
				if good2[1]~=-1 and good2[1]~=false then 
					ok=true
				end    
			end 
			if ok==false then return good end 
		end 		
	end		
	return good
end
QMPlugin.FullUBEX2=FullUBEX2
function QMPlugin.FullTMEX(data,TM)	
	if TM==nil or TM=="" or TM==0 or type(TM)=="boolean" then 
		if type(TM)=="boolean" then
			click=TM
		end	
		TM=5
	end
	if FullTM(data,TM) and FullEX(data,TM) then
		return true
	else
		return false
	end
end 	
function QMPlugin.FullTMEX2(data,TM)
	if TM==nil or TM=="" or TM==0 or type(TM)=="boolean" then 
		if type(TM)=="boolean" then
			click=TM
		end	
		TM=5
	end
	local GOOD={-1}
	local ii=0
	local OK = FullTM2(data,TM)  
    if  OK[1]~=-1 and OK[1]~=false then
		for i=1,TM do
			ii=ii+1 
			sleep()
			GOOD=Full2(data,TM) 
			if GOOD[1]==-1 or GOOD[1]==false then 
				return OK
			end
		end 
		if ii==TM then
			OK[1]=false
		end	 
	end
	return OK
end 	
function QMPlugin.FullUBTMEX(data,TM,click)
	if TM==nil or TM=="" or TM==0 or type(TM)=="boolean" then 
		if type(TM)=="boolean" then
			click=TM
		end	
		TM=5
	end
	local ii=0
	local GOOD={-1}
	if FullUBTM(data,TM,click) then
		for i=1,TM do
			ii=ii+1 
			sleep()
			GOOD=FullUB2(data,click) 
			if GOOD[1]==-1 or GOOD[1]==false then 
				return true
			end
		end 
		if ii==TM then
			return false
		end
	else
		return false
	end
end 
function QMPlugin.FullUBTMEX2(data,TM,click)
	if TM==nil or TM=="" or TM==0 or type(TM)=="boolean" then 
		if type(TM)=="boolean" then
			click=TM
		end	
		TM=5
	end
	local GOOD={-1}
	local ii=0
	local OK = FullUBTM2(data,TM,click)  
	if OK[1]~=-1 and OK[1]~=false then
		for i=1,TM do
			ii=ii+1 
			sleep()
			GOOD=FullUB2(data,click) 
			if GOOD[1]==-1 or GOOD[1]==false then 
				return OK
			end
		end 
		if ii==TM then
			OK[1]=false
		end
	end
	return OK	
end 
function sleep(tm)
    if tm==nil then tm=1000 end
	LuaAuxLib.KeepReleaseScreenSnapshot(0)  	
	LuaAuxLib.Sleep(tm)
end
function counter()
	LuaAuxLib.URL_OperationGet("http://monster.gostats.cn/bin/count/a_487697/t_5/i_1/counter.png", 3)
	counter = function() end
end
 
function TapClick(x,y,x1,y1)
	local xx,yy,xx1,yy1
	if U_F_O~=nil then
		 xx = LuaAuxLib.GetScreenInfo()
		if xx~=U_F_O then
			xx1=x
			yy1=y
			if U_F_O < xx then
				yy=U_F_O
			end	
			if yy ~=nil  then 
				x=yy1
				y=(yy-xx1-1)	
			else		
				x=(xx-yy1-1)
				y=xx1
			end 	
		end
	end 	
	if mini_X~= nil and max_X~=nil and mini_Y~=nil and max_Y~=nil then
		local mx,my
		mx=math.random(mini_X,max_X)
		my=math.random(mini_Y,max_Y)	
		if x1~=nil then
			LuaAuxLib.Tap(x+x1+mx,y+y1+my)
		else
			LuaAuxLib.Tap(x+mx,y+my)
		end	
	else
		if x1~=nil then
			LuaAuxLib.Tap(x+x1,y+y1)
		else	
			LuaAuxLib.Tap(x,y)
		end
	end
end	
function QMPlugin.R(mini_,max_)
	if max_==nil then
		max_=mini_
		mini_=1
	end
	return math.random(mini_,max_)
end
function ms(...)
     --LuaAuxLib.TracePrint(...)
     --LuaAuxLib.ShowMessage(...)  
end 


