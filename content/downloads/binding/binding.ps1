#--------------------------------------------------------------------------------
# Copyright (c) Sean Wheeler.
# Licensed under the MIT License.
#
# Demo script for Parameter Binding presentation
#--------------------------------------------------------------------------------
#region Initialize demo environment
#--------------------------------------------------------------------------------
# Hit F5 to run the initialization code
$inputObject = [pscustomobject]@{
    NumProcs     = 8
    ComputerName = $env:COMPUTERNAME
}

#--------------------------------------------------------------------------------
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
            OtherArgTypes  = $OtherArgs.ForEach({ $_.GetType().Name })
        }
    }
    end {
        "`$PSBoundParameters:"
        $PSBoundParameters.GetEnumerator().ForEach({"`t$($_.Key) = $($_.Value)"})
    }
}

#--------------------------------------------------------------------------------

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
            OtherArgTypes  = $OtherArgs.ForEach({ $_.GetType().Name })
        }
    }
    end {
        "`$PSBoundParameters:"
        $PSBoundParameters.GetEnumerator().ForEach({"`t$($_.Key) = $($_.Value)"})
    }
}

return
# The F5 run exits here.  The rest of the script is for demonstration purposes.
#--------------------------------------------------------------------------------
#endregion Initialize demo environment
#--------------------------------------------------------------------------------
#region Examples
#--------------------------------------------------------------------------------

# Show simple binding example - all values are on command line
Trace-Command -Name ParameterBinding -Expression {
    Show-Binding1 -Number 4 -ComputerName $env:COMPUTERNAME 'a', 'b' 'c' 2
} -PSHost -Option ExecutionFlow, WriteLine

# Show binding when some values come from the pipeline
Trace-Command -Name ParameterBinding -Expression {
    4 | Show-Binding1 'a', 'b' 'c' 2
} -PSHost -Option ExecutionFlow, WriteLine

# Examine the input object
$inputObject | Get-Member -MemberType Properties

# Show binding a complex object from the pipeline
Trace-Command -Name ParameterBinding -Expression {
    $inputObject | Show-Binding1 'a', 'b' 'c' 2
} -PSHost -Option ExecutionFlow, WriteLine

#--------------------------------------------------------------------------------

# Now look at the bind when using ValueFromPipeline and ValueFromPipelineByPropertyName together
Trace-Command -Name ParameterBinding -Expression {
    $inputObject | Show-Binding2 'a', 'b' 'c' 2
} -PSHost -Option ExecutionFlow, WriteLine

#--------------------------------------------------------------------------------

# Show parameter binding for native commands
Trace-Command -Name ParameterBinding -Expression {
    echoargs this -p1 is -p2 'a test' --verbose
} -PSHost -Option ExecutionFlow, WriteLine

#--------------------------------------------------------------------------------
#endregion Examples
#--------------------------------------------------------------------------------
