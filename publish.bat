@echo off
REM 发布 ztools-api-types 到 npm 的脚本（Windows 版本）

echo 📦 准备发布 ztools-api-types 到 npm...
echo.

REM 检查是否登录
npm whoami >nul 2>&1
if errorlevel 1 (
    echo ❌ 错误：未登录 npm，请先运行 'npm login'
    exit /b 1
)

echo ✅ 已登录 npm
for /f %%i in ('npm whoami') do set NPM_USER=%%i
echo    用户名: %NPM_USER%
echo.

REM 显示当前版本
for /f "tokens=*" %%i in ('node -p "require(\"./package.json\").version"') do set CURRENT_VERSION=%%i
echo 📌 当前版本: %CURRENT_VERSION%
echo.

REM 确认发布
echo ⚠️  即将发布以下内容:
npm pack --dry-run
echo.

set /p CONFIRM="确认发布？(y/N) "
if /i not "%CONFIRM%"=="y" (
    echo ❌ 已取消发布
    exit /b 0
)

REM 发布
echo 🚀 正在发布...
REM 如果是组织包，使用: npm publish --access public
REM 如果是个人包，使用: npm publish
npm publish --access public

echo.
echo ✅ 发布成功！
echo.
echo 📝 下一步:
echo    1. 访问 https://www.npmjs.com/package/@ztools-center/ztools-api-types
echo    2. 验证包信息
echo    3. 在插件项目中测试安装:
echo       npm install @ztools-center/ztools-api-types --save-dev
echo.
pause
