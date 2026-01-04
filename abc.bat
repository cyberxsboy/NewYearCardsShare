@echo off
setlocal EnableDelayedExpansion

rem 提示用户输入起始序号
set /p start=请输入起始序号（例如 1 或 100）： 

if not defined start (
    echo 未输入起始序号，使用默认值 1。
    set start=1
)

set count=%start%

rem 列出所有图像文件，按文件名排序（/on），保存到临时文件
dir /b /on *.jpg *.jpeg *.png *.gif *.bmp *.tif *.tiff *.webp *.ico *.svg > temp_files.txt 2>nul

rem 处理临时文件列表中的每个文件
for /f "delims=" %%F in (temp_files.txt) do (
    if exist "%%F" (
        rem 补零到4位（可修改0数量调整位数，或删除这两行用 !count! 代替）
        set "formatted=0000!count!"
        set "formatted=!formatted:~-4!"
        
        rem 获取原文件扩展名（包括点，如 .jpg 或 .JPG）
        set "ext=%%~xF"
        
        ren "%%F" "!formatted!!ext!"
        set /a count+=1
    )
)

rem 删除临时文件
del temp_files.txt 2>nul

echo.
echo 重命名完成！从 %start% 开始，共处理了 %count% - %start% 个文件。
pause