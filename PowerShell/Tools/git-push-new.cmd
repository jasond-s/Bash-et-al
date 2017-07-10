@echo off

for /f %%i in ('git rev-parse --abbrev-ref HEAD') do set BRANCH=%%i

git push -u origin %BRANCH%
