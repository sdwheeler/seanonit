#--------------------------------------------------------------------------------
# Copyright (c) Sean Wheeler.
# Licensed under the MIT License.
#
# Demo script for Parameter Binding presentation
#--------------------------------------------------------------------------------
#region Initialize demo environment
#--------------------------------------------------------------------------------
$inputObject = [pscustomobject]@{
    NumProcs     = 8
    ComputerName = $env:COMPUTERNAME
}

function Show-Binding1 {
    param(
        [Parameter(ValueFromPipeline)]
        [int]$Number,

        [Parameter(ValueFromPipelineByPropertyName)]
        [string[]]$ComputerName,

        [Parameter(Position = 0, ValueFromRemainingArguments)]
        [object[]]$OtherArgs
    )
    process {
        [pscustomobject]@{
            Number         = $Number
            ComputerName   = $ComputerName
            OtherArgsCount = $OtherArgs.Count
            OtherArgs      = $OtherArgs
            OtherArgTypes  = $OtherArgs | ForEach-Object { $_.GetType().Name }
        }
    }
}

function Show-Binding2 {
    param(
        [Parameter(ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [Alias('NumProcs')]
        [int]$Number,

        [Parameter(ValueFromPipelineByPropertyName)]
        [string[]]$ComputerName,

        [Parameter(Position = 0, ValueFromRemainingArguments)]
        [object[]]$OtherArgs
    )
    process {
        [pscustomobject]@{
            Number         = $Number
            ComputerName   = $ComputerName
            OtherArgsCount = $OtherArgs.Count
            OtherArgs      = $OtherArgs
            OtherArgTypes  = $OtherArgs | ForEach-Object { $_.GetType().Name }
        }
    }
}

return
#--------------------------------------------------------------------------------
#endregion Initialize demo environment
#--------------------------------------------------------------------------------
#region Simple command-line binding example
#--------------------------------------------------------------------------------

# Show binding when all values are on command line
Trace-Command -Name ParameterBinding -Expression {
    Show-Binding1 -Number 4 -ComputerName $env:COMPUTERNAME 'a', 'b' 'c' 2
} -PSHost -Option ExecutionFlow

#--------------------------------------------------------------------------------
#endregion Simple command-line binding example
#--------------------------------------------------------------------------------
#region Pipeline binding example 1 - ValueFromPipeline vs. ValueFromPipelineByPropertyName
#--------------------------------------------------------------------------------

# Examine the input object
$inputObject | Get-Member

# Show binding when some values come from the pipeline
Trace-Command -Name ParameterBinding -Expression {
    4 | Show-Binding1 'a', 'b' 'c' 2
} -PSHost -Option ExecutionFlow

Trace-Command -Name ParameterBinding -Expression {
    $inputObject | Show-Binding1 'a', 'b' 'c' 2
} -PSHost -Option ExecutionFlow
#--------------------------------------------------------------------------------
#endregion Pipeline binding example 1 - ValueFromPipeline vs. ValueFromPipelineByPropertyName
#--------------------------------------------------------------------------------
#--------------------------------------------------------------------------------
#region Pipeline binding example 2 - add ValueFromPipeline & ValueFromPipelineByPropertyName
#--------------------------------------------------------------------------------

# Now look at the bind when using ValueFromPipeline and ValueFromPipelineByPropertyName together
Trace-Command -Name ParameterBinding -Expression {
    $inputObject | Show-Binding2 'a', 'b' 'c' 2
} -PSHost -Option ExecutionFlow
#--------------------------------------------------------------------------------
#endregion Pipeline binding example 2 - add ValueFromPipeline & ValueFromPipelineByPropertyName
#--------------------------------------------------------------------------------
#--------------------------------------------------------------------------------
#region Pipeline binding example 3 - native commands
#--------------------------------------------------------------------------------

# Show parameter binding for native commands
Trace-Command -Name ParameterBinding -Expression {
    echoargs -param this is 'a test' --verbose
} -PSHost -Option ExecutionFlow

#--------------------------------------------------------------------------------
#endregion Pipeline binding example 3 - native commands
#--------------------------------------------------------------------------------
