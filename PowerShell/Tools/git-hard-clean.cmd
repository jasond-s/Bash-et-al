@echo off

FOR /F %%A IN ('git branch -v') DO IF /I NOT %%A==main git branch -D %%A
