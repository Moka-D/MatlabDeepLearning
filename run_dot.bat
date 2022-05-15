@echo off

set DOT_BIN_PATH="C:\Program Files\Graphviz\bin"

%DOT_BIN_PATH%\dot %1 -T %2 -o %3

exit /b
