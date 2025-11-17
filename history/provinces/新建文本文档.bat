@echo off
setlocal enabledelayedexpansion

:: 设置要添加的内容
set "insert_line=1827.1.1 = { discovered_by = PAP }"

:: 遍历所有子目录中的.txt文件
for /r %%f in (*.txt) do (
    :: 检查文件是否非空（至少有一行非空内容）
    findstr /m "." "%%f" >nul 2>&1
    if !errorlevel! equ 0 (
        :: 创建临时文件
        set "temp_file=%%f.temp"
        
        :: 写入新内容和原内容
        echo %insert_line% > "!temp_file!"
        type "%%f" >> "!temp_file!"
        
        :: 替换原文件
        move /y "!temp_file!" "%%f" >nul
        echo 已处理: %%f
    )
)

echo 操作完成！
pause