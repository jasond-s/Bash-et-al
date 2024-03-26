@echo off

for /f %%i in ('git rev-parse --abbrev-ref HEAD') do set BRANCH=%%i

git checkout main
git pull
git checkout %BRANCH%