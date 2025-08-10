

-- Define the whitelist of User IDs
local whitelist = {
    7404802184, 3219789093, 4990801456, 3380703051, 1240860265,
    2821207193, 3211853358, 4488667209, 2494574929, 1891233823,
    8062000685, 3818320344, 5073104640, 7838102998 
}

local player = game.Players.LocalPlayer
local playerId = player.UserId

print("👤 Player ID detected:", playerId)

-- Function to check if the player is whitelisted
local function isPlayerWhitelisted(playerId)
    for _, id in ipairs(whitelist) do
        if id == playerId then
            return true
结束
结束
    return false
结束

-- Check if the player is whitelisted
if not isPlayerWhitelisted(playerId) then
    warn("❌ Access denied for ID:", playerId)
    player:Kick("🚫 You are not allowed to use this script.")
返回
end

print("✅ ID " .. playerId .. " allowed. Loading the script...")

-- Function to safely load a script from a URL
local function safeLoad(url, name)
    print("🔄 Loading: " .. name)
    local success, result = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)

    如果不成功那么
    warn("❌ 加载失败："..名称.."-"..字符串(结果))
    返回零
    结束

    打印("✅ "..名称.."成功加载！")
    返回结果
结束

--要加载的主脚本的URL
local mainScriptUrl="https://raw.githubusercontent.com/SLHhub/Yamskrtt/refs/heads/main/TRYHARDERKIDDD"--确保此URL正确

--尝试加载主脚本
本地mainSuccess，mainResult=pcall(函数()
返回loadstring(game:HttpGet(mainScriptUrl))()--在此处直接使用URL
结束)

如果不是mainSuccess，则
warn("❌ 加载主脚本时出错："..toString(mainResult))
播放器：踢("❌ Error："..toString(mainResult))
返回
结束

打印(“✅ 主脚本加载成功！”)

--加载其他库
本地库=安全加载("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"，"流畅库")
本地SaveManager=Safeload("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/SaveManager.luau"，"Save Manager")
本地接口管理器=安全加载("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/InterfaceManager.luau"，"接口管理器")


--ðŸ创建
本地窗口=库：CreateWindow{
title="SLHV2付费脚本"，
subtitle="Yamss"，
tabwidth=125，
尺寸=UDim2.从偏移(830，525)，
resize=true，
MINSIZE=Vector2.new(470，380)，
丙烯酸=真，
主题="万象火星"，
MinimizeKey=枚举.KeyCode.RightControl
}本地选项卡={
main=窗口：CreateTab{
标题="主要"，
图标=“荧光粉-住宅-粗体”
	},
自动农场=窗口：CreateTab{
标题="自动农场"，
图标="磷光体-机器人-粗体"
	},
重生=窗口：CreateTab{
title="OP重生"，
图标="荧光粉-箭头-顺时针-粗体"
	},
杀手=窗口：CreateTab{
标题="杀手"，
图标=“荧光-剑-粗体”
	},
stats=窗口：CreateTab{
标题="统计"，
图标="磷光体-闪耀-粗体"
    },
Reb=窗口：CreateTab{
标题="正常再生"，
图标="荧光粉-箭头-顺时针-粗体"
	},
}


本地切换=tabs.Main:CreateToggle("night"，{
标题="夜间"，
默认值=false，
回调=函数(值)
如果值，则
--如果开关打开，则将时间设置为午夜
game.Lighting.TimeOfDay="00:00:00"--午夜
其他
--如果切换关闭，则将时间设置为白天(例如12:00:00)
game.Lighting.TimeOfDay="12:00:00"--正午或任何所需日间值
结束
结束
})

本地cleanupLoop--保存清理循环的变量

--通过销毁某些实例来消除滞后的函数
局部函数RemoveLag()
for_，v成对(游戏：GetDescendants())do
如果v:Isa("粒子发射器")或v:Isa("效果")或v:Isa("烟雾")或v:Isa("火")或v:Isa("爆炸")，则
v：销毁()
否则，如果v:Isa("贴花")或v:Isa(“纹理”)，则
v：销毁()
结束
结束
结束

本地切换=tabs.Main:CreateToggle("AutoSize"，{
title="FPS升压"，
description="IDK Tbh"，
默认值=false，
回调=函数(值)
如果值，则
--如果打开切换，则启动清除循环
RemoveLag()--初始清理
cleanupLoop=task.spawn(函数()
当价值--使用值参数检查切换是否仍处于活动状态
等待(30)--等待30秒
RemoveLag()--再次清理
结束
结束)
其他
--如果关闭切换，则停止清理循环
如果cleanupLoop，则
task.cancel(cleanupLoop)--停止循环
cleanupLoop=nil
结束
结束
结束
})


本地选项=库.选项
本地MainSection=Tabs.Main:CreateSection("⌘基本控件⌘")
本地selectedSize="2"

本地输入=MainSection:AddInput("SizeChanger"，{
标题="尺寸转换器"，
描述="输入大小"，
本地玩家=game.Players.LocalPlayer
本地playerID=player.UserId
numeric=true，
打印("👤 检测到玩家ID："，playerId)
回调=函数(值)
--检查播放器是否列入白名单的功能
本地函数isPlayerWhitelisted(playerId)
for_，ipair中的id(白名单)do
如果ID==playerId，则
返回true
--要加载的主脚本的URL

返回假的
--尝试加载主脚本
本地mainSuccess，mainResult=pcall(函数()
--检查玩家是否进入白名单
如果不是isPlayerWhitelisted(playerId)，则
warn("❌ 访问被拒绝，ID："，playerId)
玩家：踢("🚫 不允许使用此脚本.")
warn("❌ 加载主脚本时出错："..toString(mainResult))
播放器：踢("❌ Error："..toString(mainResult))
返回
打印(允许"✅  ID“..playID..”。正在加载脚本...")
})

本地函数Safeload(url，name)
打印("🔄 加载："..名称)
本地成功，结果=pcall(函数()
返回载荷串(游戏：HttpGet(url))()
结束)
默认值="125"，
占位符="输入速度"，
--ðŸ创建
本地窗口=库：CreateWindow{
title="SLHV2付费脚本"，
subtitle="Yamss"，
tabwidth=125，
尺寸=UDim2.从偏移(830，525)，
resize=true，
MINSIZE=Vector2.new(470，380)，
丙烯酸=真，
local mainScriptUrl="https://raw.githubusercontent.com/SLHhub/Yamskrtt/refs/heads/main/TRYHARDERKIDDD"--确保此URL正确
MinimizeKey=枚举.KeyCode.RightControl

main=窗口：CreateTab{
标题="自动设置速度"，
描述="自动设置您选择的速度"，
默认值=false，
回调=函数(值)
标题="自动农场"，
图标="磷光体-机器人-粗体"
if game.Players.LocalPlayer.Character和游戏。玩家。本地玩家。角色：寻找第一个孩子(“人形”)然后
游戏。玩家。本地玩家。性格。人形行走速度=T编号(selectedSpeed)
title="OP重生"，
打印("✅ 主脚本加载成功！")
结束
杀手=窗口：CreateTab{
标题="杀手"，

Tabs.Main:createButton{
标题="免费自动升降游戏通行证"，
回调=函数()
本地gameepassFolder=game:GetService("复制存储")。gameepassId
Loca
