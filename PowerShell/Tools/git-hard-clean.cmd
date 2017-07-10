@echo off

FOR /F %%A IN ('git branch -v') DO IF /I NOT %%A==master git branch -D %%A
