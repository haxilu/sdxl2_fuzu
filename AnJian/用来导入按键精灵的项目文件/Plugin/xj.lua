function QMPlugin.ReturnDate(t)		--返回天时分
    t = tonumber(t) or 0
    
        local str = ""
        local list = {}
        local sList = {"天", "小时", "分", "秒"}
        list[1] = math.floor((t / 60 / 60) / 24)--天 
        list[2] = math.floor((t / 60 / 60) % 24)--时
        list[3] = math.floor((t / 60) % 60)--分
        list[4] = math.floor(t % 60)--秒
        for i = 1, #list do
            if list[i] > 0 then
                str = str .. list[i]..sList[i]
            end
        end
        return str
   
end