@echo off

FOR /F %%A IN ('git branch --merged') DO IF /I NOT %%A==* git branch -D %%A
