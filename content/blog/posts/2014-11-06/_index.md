---
title: Throwback Thursday – Windows Command Shell (Batch) scripting
date: 2014-11-06T05:30:00
draft: false
---
This Thursday I am returning to my scripting roots (if you don't count [VAX DCL][01]) to talk about
Windows Command Shell scripts. With nice powerful scripting options like PowerShell why does anyone
bother with "DOS Batch" scripts anymore?

First off, let me set the record straight. Windows Command Shell scripting is much more powerful
than "DOS Batch" files. Yes, they share a common heritage and syntax. But the Windows Command shell
can do so much more. Not to mention, there are lots of older systems still deployed that don't have
PowerShell installed. The Windows Command shell is guaranteed to be installed.

Some things you can do in Windows command shell scripts that you may not have known:

- Arithmetic (using the SET /A command)
- Complex FOR loops (parsing, counting, collection enumeration)
- Subroutines within a single script file (using "CALL :label")
- Text parsing (using the FOR command)
- Additional built-in environment variables (e.g. %CD%, %RANDOM%, and others)
- Variable Substring extraction and replacement (see the help for the SET command)
- Variable value transformation (e.g. get the size of the file named by the variable using `%\~z1`)

I will illustrate a view of these enhancements while I discuss different ways of handling command
line arguments.

The Windows Command shell provide variable for the first nine arguments passed on the command line
when executing a script. These variables are numbered %1 through %9. But what if you want (or need)
to pass more parameters than that? Take the following script:

```cmd
@echo off
echo Arg[1] = %1
echo Arg[2] = %2
echo Arg[3] = %3
echo Arg[4] = %4
echo Arg[5] = %5
echo Arg[6] = %6
echo Arg[7] = %7
echo Arg[8] = %8
echo Arg[9] = %9
echo Arg[10] = %10
echo Arg[11] = %11
echo Arg[12] = %12
echo Arg[13] = %13
echo Arg[14] = %14
echo Arg[15] = %15
```

Let's see what happens when you try to access the 10<sup>th</sup> argument:

```
C:\temp> test15args.cmd a b c d e f g h i j k l m n o
Arg[1] = a
Arg[2] = b
Arg[3] = c
Arg[4] = d
Arg[5] = e
Arg[6] = f
Arg[7] = g
Arg[8] = h
Arg[9] = i
Arg[10] = a0
Arg[11] = a1
Arg[12] = a2
Arg[13] = a3
Arg[14] = a4
Arg[15] = a5
```

Notice that starting with the 10 argument the script is just outputting the value of the
1<sup>st</sup> argument followed by a number. Also, using the numbered variables implies that you
expect command line arguments to be passed in a specific order. What if you want to pass arguments
in any order or handle more than nine values? This is where the SHIFT command comes in. SHIFT is not
new. It existed in DOS prior to the Windows Command shell, but when combined with other new features
of the Command shell it is more powerful. Take this next example:

```cmd
@echo off
setlocal
set /a c=1
:top
echo Arg[%c%] = "%1"
set /a c+=1
shift
if "%1" NEQ "" goto :top
goto :eof
echo You should never reach this line of the script.
```

SHIFT allows us to access each argument by SHIFT-ing it through the %1 variable. Bonus: notice the
use of "set /a". This is how you do arithmetic. Here is the output:

```
C:\temp> testAllargs.cmd a b c d e f g h i j k l m n o
Arg[1] = "a"
Arg[2] = "b"
Arg[3] = "c"
Arg[4] = "d"
Arg[5] = "e"
Arg[6] = "f"
Arg[7] = "g"
Arg[8] = "h"
Arg[9] = "i"
Arg[10] = "j"
Arg[11] = "k"
Arg[12] = "l"
Arg[13] = "m"
Arg[14] = "n"
Arg[15] = "o"
```

So now we have a method of looking at each command line argument and handling it independent of its
position on the command line. Let's look at a more complex script.

I would like to check all the command line arguments and determine if they are valid for the script
before ever trying to execute the main logic of the script. It would also be nice to separate blocks
of code in the script into "subroutines" so that the complex logic of a specific task can be
isolated from the main logic flow of the script. Here is a high-level outline of such a script.

```
  ForEach arg in args[]
  {
    if valid(arg) then add arg to collection
    if not valid(arg) then display error message
  }
  ForEach arg in collection
  {
    call subroutine to handle arg
  }
```

Take a look at the script. The script is divided into four sections:

- Initialization - where we validate the arguments
- Main block - where we control the order of execution
- Subroutines - where the actual work gets done
- Helper functions - specialized tasks that are not part of the main logic

```cmd
@echo off
setlocal EnableDelayedExpansion
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:GetOpts - Check Command line options
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
if "%1" EQU "" (
   goto :FinInit
)
if /i "%1" EQU "ACTION01" goto :AddOpt
if /i "%1" EQU "ACTION02" goto :AddOpt
if /i "%1" EQU "ACTION03" goto :AddOpt
if /i "%1" EQU "ACTION04" goto :AddOpt
if /i "%1" EQU "ACTION05" goto :AddOpt
if /i "%1" EQU "ACTION06" goto :AddOpt
if /i "%1" EQU "ACTION07" goto :AddOpt
if /i "%1" EQU "ACTION08" goto :AddOpt
if /i "%1" EQU "ACTION09" goto :AddOpt
if /i "%1" EQU "ACTION10" goto :AddOpt
if /i "%1" EQU "ACTION11" goto :AddOpt
if /i "%1" EQU "ACTION12" goto :AddOpt
if /i "%1" EQU "ACTION13" goto :AddOpt
if /i "%1" EQU "ACTION14" goto :AddOpt
if /i "%1" EQU "ACTION15" goto :AddOpt
:::::::::::::::::::::::::
:   Fall through to error if no match
:::::::::::::::::::::::::
goto :CMDError %1

:::::::::::::::::::::::::
:AddOpt
:::::::::::::::::::::::::
set MY_OPT_LIST=!MY_OPT_LIST! %1
:::::::::::::::::::::::::
:NextOpt
:::::::::::::::::::::::::
shift
goto :GetOpts

::::::::::::::::::::::::::::::::::::::::::
:FinInit  Finish initializing script environment
::::::::::::::::::::::::::::::::::::::::::
echo Finish initializing script environment.
echo Add commands here to create temp files or other tasks required by the script.
::::::::::::::::::::::::::::::::::::::::::
:         Count the number of options
::::::::::::::::::::::::::::::::::::::::::
set MY_OPT_LIST
set /a optcnt = 0
for %%a in (%MY_OPT_LIST%) do (
   set /a optcnt = !optcnt! + 1
)
echo Total options selected = %optcnt%
::::::::::::::::::::::::::::::::::::::::::
:        End of Init section
::::::::::::::::::::::::::::::::::::::::::
:Main    Main Section - Process selected options
::::::::::::::::::::::::::::::::::::::::::
if %optcnt% EQU 0 goto :eof
for %%a in (%MY_OPT_LIST%) do (
   call :%%a
)
goto :eof
::::::::::::::::::::::::::::::::::::::::::
:         End of Main section
::::::::::::::::::::::::::::::::::::::::::
:         Begin Action subroutines
::::::::::::::::::::::::::::::::::::::::::
:ACTION01
echo Add your Action01 commands here.
goto :eof
:ACTION02
echo Add your Action02 commands here.
goto :eof
:ACTION03
echo Add your Action03 commands here.
goto :eof
:ACTION04
echo Add your Action04 commands here.
goto :eof
:ACTION05
echo Add your Action05 commands here.
goto :eof
:ACTION06
echo Add your Action06 commands here.
goto :eof
:ACTION07
echo Add your Action07 commands here.
goto :eof
:ACTION08
echo Add your Action08 commands here.
goto :eof
:ACTION09
echo Add your Action09 commands here.
goto :eof
:ACTION10
echo Add your Action10 commands here.
goto :eof
:ACTION11
echo Add your Action11 commands here.
goto :eof
:ACTION12
echo Add your Action12 commands here.
goto :eof
:ACTION13
echo Add your Action13 commands here.
goto :eof
:ACTION14
echo Add your Action14 commands here.
goto :eof
:ACTION15
echo Add your Action15 commands here.
goto :eof
::::::::::::::::::::::::::::::::::::::::::
:         End Action subroutines section
::::::::::::::::::::::::::::::::::::::::::
:         Begin Helper functions
::::::::::::::::::::::::::::::::::::::::::
:CMDError - report error in command line options
::::::::::::::::::::::::::::::::::::::::::
echo Error: '%1' is not a valid option
echo.
echo Valid options are:
echo    ACTION01, ACTION02, ACTION03, ACTION04, ACTION05,
echo    ACTION06, ACTION07, ACTION08, ACTION09, ACTION10,
echo    ACTION11, ACTION12, ACTION13, ACTION14, ACTION15
echo.
goto :EOF
::::::::::::::::::::::::::::::::::::::::::
:        End of Script
::::::::::::::::::::::::::::::::::::::::::
```

Here is the example output:

```
C:\temp> cmdparams.cmd action01 action05 action12 action03
Finish initializing script environment.
Add commands here to create temp files or other tasks required by the script.
MY_OPT_LIST= action01 action05 action12 action03
Total options selected = 4
Add your Action01 commands here.
Add your Action05 commands here.
Add your Action12 commands here.
Add your Action03 commands here.

C:\temp> cmdparams.cmd action1
Error: 'action1' is not a valid option

Valid options are:
   ACTION01, ACTION02, ACTION03, ACTION04, ACTION05,
   ACTION06, ACTION07, ACTION08, ACTION09, ACTION10,
   ACTION11, ACTION12, ACTION13, ACTION14, ACTION15

```

OK, what makes a subroutine in Windows Command shell? In DOS Batch you had to put subroutines in a
separate Batch file so you could CALL that batch script from your main script. The Windows Command
shell added functionality to the CALL command that allows you to CALL to a label located in the
current script file instead of using GOTO. The Command shell also added the special label ":EOF" to
indicate that you were done executing and you want to return back to the caller. This allows you to
separate the "business logic" of your scripts into subroutines and it them separate from the "flow
logic" of the main portion of the script.

PS: this is a shout out to [DonR][02] who got me started in a lot of scripting languages way back in
1987.

<!-- link references -->
[01]: http://en.wikipedia.org/wiki/DIGITAL_Command_Language
[02]: http://www.cse.unt.edu/~donr
