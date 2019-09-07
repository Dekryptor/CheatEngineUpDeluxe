@echo off

REM DOWNLOAD SECTION START
:step1
echo FPC 3.2.0, branch: fixes_3_2, revision 42444
echo Lazarus 2.0.0, tag: lazarus_2_0_0, revision 60307
echo.
echo Download FPC from [o]fficial source or [c]ompressed source or
set /p answer1=compiled FPC [r]ar file [o,c,r]?
set answer1=%answer1:O=o%
set answer1=%answer1:C=c%
set answer1=%answer1:R=r%
if "%answer1%"=="r" (
rem
) else if "%answer1%"=="c" (
rem
) else if NOT "%answer1%"=="o" goto :step1

:step2
echo.
set /p answer2=Download Lazarus from [o]fficial source or [c]ompressed source [o,c]?
set answer2=%answer2:O=o%
set answer2=%answer2:C=c%
if "%answer2%"=="c" (
rem
) else if NOT "%answer2%"=="o" goto :step2

if "%answer1%"=="o" (
  svn.exe checkout    --non-interactive --trust-server-cert -r 42444 https://svn.freepascal.org/svn/fpc/branches/fixes_3_2     fpcsrc
) else if "%answer1%"=="c" (
  if NOT EXIST UnRAR.exe ( svn.exe cat --non-interactive --trust-server-cert -r HEAD "https://github.com/mgrinzPlayer/CheatEngineUpDeluxe/trunk/UnRAR.exe" > UnRAR.exe )
  if NOT EXIST fpcsrc.part01.rar (
    echo Downloading FPC
    svn.exe cat --non-interactive --trust-server-cert -r HEAD "https://github.com/mgrinzPlayer/CheatEngineUpDeluxe/trunk/fpcsrc.part01.rar" > fpcsrc.part01.rar
    echo Downloading FPC: 93%%
    svn.exe cat --non-interactive --trust-server-cert -r HEAD "https://github.com/mgrinzPlayer/CheatEngineUpDeluxe/trunk/fpcsrc.part02.rar" > fpcsrc.part02.rar
    echo Downloading FPC: 100%%
  ) else echo Downloading FPC: 100%%
  echo Extracting FPC...
  UnRAR.exe x -y -idq fpcsrc.part01.rar
) else if "%answer1%"=="r" (
  if NOT EXIST UnRAR.exe ( svn.exe cat --non-interactive --trust-server-cert -r HEAD "https://github.com/mgrinzPlayer/CheatEngineUpDeluxe/trunk/UnRAR.exe" > UnRAR.exe )
  if NOT EXIST compiled_fpc.part01.rar (
    echo Downloading Compiled FPC
    svn.exe cat --non-interactive --trust-server-cert -r HEAD "https://github.com/mgrinzPlayer/CheatEngineUpDeluxe/trunk/compiledFPC/compiled_fpc.part01.rar" > compiled_fpc.part01.rar
    echo Downloading Compiled FPC: 27%%
    svn.exe cat --non-interactive --trust-server-cert -r HEAD "https://github.com/mgrinzPlayer/CheatEngineUpDeluxe/trunk/compiledFPC/compiled_fpc.part02.rar" > compiled_fpc.part02.rar
    echo Downloading Compiled FPC: 54%%
    svn.exe cat --non-interactive --trust-server-cert -r HEAD "https://github.com/mgrinzPlayer/CheatEngineUpDeluxe/trunk/compiledFPC/compiled_fpc.part03.rar" > compiled_fpc.part03.rar
    echo Downloading Compiled FPC: 81%%
    svn.exe cat --non-interactive --trust-server-cert -r HEAD "https://github.com/mgrinzPlayer/CheatEngineUpDeluxe/trunk/compiledFPC/compiled_fpc.part04.rar" > compiled_fpc.part04.rar
    echo Downloading Compiled FPC: 100%%
  ) else echo Downloading Compiled FPC: 100%%
  echo Extracting Compiled FPC...
  UnRAR.exe x -y -idq compiled_fpc.part01.rar
)

if "%answer2%"=="o" (
  svn.exe checkout    --non-interactive --trust-server-cert -r 60307 https://svn.freepascal.org/svn/lazarus/tags/lazarus_2_0_0 lazarus
) else if "%answer2%"=="c" (
  if NOT EXIST UnRAR.exe ( svn.exe cat --non-interactive --trust-server-cert -r HEAD "https://github.com/mgrinzPlayer/CheatEngineUpDeluxe/trunk/UnRAR.exe" > UnRAR.exe )
  if NOT EXIST lazarus.rar (
    echo Downloading Lazarus
    svn.exe cat --non-interactive --trust-server-cert -r HEAD "https://github.com/mgrinzPlayer/CheatEngineUpDeluxe/trunk/lazarus.rar" > lazarus.rar
    echo Downloading Lazarus: 100%%
  ) else echo Downloading Lazarus: 100%%
  echo Extracting Lazarus...
  UnRAR.exe x -y -idq lazarus.rar
)

if "%answer1%"=="r" ( goto :bootstrapnotneeded )
if NOT EXIST UnRAR.exe ( svn.exe cat --non-interactive --trust-server-cert -r HEAD "https://github.com/mgrinzPlayer/CheatEngineUpDeluxe/trunk/UnRAR.exe" > UnRAR.exe )
if NOT EXIST bootstrap.rar (
  echo Downloading bootstrap
  svn.exe cat --non-interactive --trust-server-cert -r HEAD "https://github.com/mgrinzPlayer/CheatEngineUpDeluxe/trunk/bootstrap.rar" > bootstrap.rar
  echo Downloading bootstrap 100%%
) else echo Downloading bootstrap 100%%
echo Extracting bootstrap...
UnRAR.exe x -y -idq bootstrap.rar
:bootstrapnotneeded

if NOT EXIST UnRAR.exe ( svn.exe cat --non-interactive --trust-server-cert -r HEAD "https://github.com/mgrinzPlayer/CheatEngineUpDeluxe/trunk/UnRAR.exe" > UnRAR.exe )
if NOT EXIST mingw.rar (
  echo Downloading GDB
  svn.exe cat --non-interactive --trust-server-cert -r HEAD "https://github.com/mgrinzPlayer/CheatEngineUpDeluxe/trunk/mingw.rar" > mingw.rar
  echo Downloading GDB 100%%
) else echo Downloading GDB 100%%
REM DOWNLOAD SECTION END





REM COMPILATION SECTION START
set compile32bit=OS_SOURCE=win32 CPU_SOURCE=i386 OS_TARGET=win32 CPU_TARGET=i386
set compile64bit=OS_SOURCE=win32 CPU_SOURCE=i386 OS_TARGET=win64 CPU_TARGET=x86_64

set FPCINSTALLPATH=%CD%\fpc\3.2.0
set OLDFPC=%CD%\bootstrap\ppc386.exe
set NEWFPC=%FPCINSTALLPATH%\bin\i386-win32\fpc.exe
set PPC64B=%FPCINSTALLPATH%\bin\i386-win32\ppcrossx64.exe
set fpcmakeppumove=FPCMAKE=%FPCINSTALLPATH%\bin\i386-win32\fpcmake.exe PPUMOVE=%FPCINSTALLPATH%\bin\i386-win32\ppumove.exe
set compOpts="OPT=-vw-n-h-l-d-u-t-p-c- -g- -Xs -O3 -CX -XX -OoREGVAR"

if "%answer1%"=="r" ( goto :dolazarus )

md %FPCINSTALLPATH%\bin\i386-win32
copy /Y bootstrap\*  %FPCINSTALLPATH%\bin\i386-win32

set path=%CD%\bootstrap

rem compile and install FPC 32bit
title 32bit FPC - all install
make --jobs=4 FPC=%OLDFPC% --directory=fpcsrc  %fpcmakeppumove% FPCDIR=fpcsrc INSTALL_PREFIX=%FPCINSTALLPATH% %compile32bit% REVSTR=42444 REVINC=force %compOpts% all install

"%FPCINSTALLPATH%\bin\i386-win32\fpcmkcfg.exe" -d basepath=%FPCINSTALLPATH% -o "%FPCINSTALLPATH%\bin\i386-win32\fpc.cfg"

rem compile and install FPC 64bit (crosscompiler)
title 64bit FPC - compiler_cycle
make --jobs=4 FPC=%NEWFPC% --directory=fpcsrc  %fpcmakeppumove% FPCDIR=fpcsrc INSTALL_PREFIX=%FPCINSTALLPATH% %compile64bit% CROSSINSTALL=1 NOGDBMI=1 %compOpts% compiler_cycle

title 64bit FPC - compiler_install
make --jobs=4 FPC=%NEWFPC% --directory=fpcsrc  %fpcmakeppumove% FPCDIR=fpcsrc INSTALL_PREFIX=%FPCINSTALLPATH% %compile64bit% CROSSINSTALL=1 NOGDBMI=1 %compOpts% compiler_install

title 64bit FPC - rtl
make --jobs=4 FPC=%PPC64B% --directory=fpcsrc  %fpcmakeppumove% FPCDIR=fpcsrc INSTALL_PREFIX=%FPCINSTALLPATH% %compile64bit% CROSSINSTALL=1 NOGDBMI=1 %compOpts% rtl

title 64bit FPC - rtl_install
make --jobs=4 FPC=%PPC64B% --directory=fpcsrc  %fpcmakeppumove% FPCDIR=fpcsrc INSTALL_PREFIX=%FPCINSTALLPATH% %compile64bit% CROSSINSTALL=1 NOGDBMI=1 %compOpts% rtl_install

title 64bit FPC - packages
make --jobs=4 FPC=%PPC64B% --directory=fpcsrc  %fpcmakeppumove% FPCDIR=fpcsrc INSTALL_PREFIX=%FPCINSTALLPATH% %compile64bit% CROSSINSTALL=1 NOGDBMI=1 %compOpts% packages

title 64bit FPC - packages_install
make --jobs=4 FPC=%PPC64B% --directory=fpcsrc  %fpcmakeppumove% FPCDIR=fpcsrc INSTALL_PREFIX=%FPCINSTALLPATH% %compile64bit% CROSSINSTALL=1 NOGDBMI=1 %compOpts% packages_install


:dolazarus
cd lazarus
set path=%FPCINSTALLPATH%\bin\i386-win32\
"%FPCINSTALLPATH%\bin\i386-win32\fpcmkcfg.exe" -d basepath=%FPCINSTALLPATH% -o "%FPCINSTALLPATH%\bin\i386-win32\fpc.cfg"
echo --primary-config-path=%CD%\config>lazarus.cfg

rem compile lazbuild, registration, lazutils, lcl, basecomponents and starter
title Compiling Lazbuild
make          FPC=%NEWFPC% --directory=. %fpcmakeppumove% FPCDIR=fpcsrc INSTALL_PREFIX=.          %compile32bit% USESVN2REVISIONINC=0     %compOpts% lazbuild

title Compiling registration lazutils lcl basecomponents
make          FPC=%NEWFPC% --directory=. %fpcmakeppumove% FPCDIR=fpcsrc INSTALL_PREFIX=.          %compile32bit% USESVN2REVISIONINC=0     %compOpts% registration lazutils lcl basecomponents

title Compiling starter
make          FPC=%NEWFPC% --directory=. %fpcmakeppumove% FPCDIR=fpcsrc INSTALL_PREFIX=.          %compile32bit% USESVN2REVISIONINC=0     %compOpts% starter

rem compile Lazarus
title Compiling Lazarus
lazbuild.exe --compiler=%NEWFPC% --quiet --cpu=i386 --os=win32 --add-package components\sqldb\sqldblaz.lpk
lazbuild.exe --compiler=%NEWFPC% --quiet --cpu=i386 --os=win32 "--build-ide=-dKeepInstalledPackages -g- -Xs -O3 -CX -XX -OoREGVAR"

REM COMPILATION SECTION END

echo Extracting GDB...
..\UnRAR.exe x -y -idq ..\mingw.rar

pause
pause
