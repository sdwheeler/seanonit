function Test-ParameterInfo {
    [CmdletBinding(DefaultParameterSetName='Path')]
    param(
        [Parameter(
            Mandatory,
            ValueFromPipeline,
            ParameterSetName='Path',
            Position=0
        )]
        [SupportsWildcards()]
        [string[]]$Path,

        [Parameter(
            Mandatory,
            ValueFromPipelineByPropertyName,
            ParameterSetName='LiteralPath',
            Position=[int]::MinValue
        )]
        [Alias('PSPath', 'LP')]
        [string]$LiteralPath
    )

    begin {
        $platyps = Get-Module Microsoft.PowerShell.PlatyPS
        if ($null -eq $platyps) {
            Import-Module Microsoft.PowerShell.PlatyPS
        }
        if ($PSBoundParameters.ContainsKey('Path')) {
            $PathsToProcess = dir $Path | Measure-PlatyPSMarkdown |
                Where-Object Filetype -match 'CommandHelp' |
                Select-Object -ExpandProperty FilePath
        } else {
            $PathsToProcess = dir $LiteralPath | Measure-PlatyPSMarkdown |
                Where-Object Filetype -match 'CommandHelp' |
                Select-Object -ExpandProperty FilePath
        }
        $CommonParameters = [System.Management.Automation.PSCmdlet]::CommonParameters
    }

    process {
        foreach ($p in $PathsToProcess) {
            $results = @{}
            $mdInfo = Import-MarkdownCommandHelp -Path $p
            $cmdInfo = Get-Command -Name $mdInfo.Title
            $cmdParameters = $cmdInfo.Parameters.Keys | Where-Object {$_ -notin $CommonParameters}
            foreach ($cp in $cmdParameters) {
                $results.Add($cp, [pscustomobject]@{
                    Command      = $mdInfo.Title
                    Name         = $cp
                    IsDefined    = $true
                    IsDocumented = $false
                })
            }
            foreach ($mdp in $mdInfo.Parameters.Name) {
                if ($mdp -in $results.Keys) {
                    $results[$mdp].IsDocumented = $true
                } else {
                    $results.Add($mdp, [pscustomobject]@{
                        Command      = $mdInfo.Title
                        Name         = $mdp
                        IsDefined    = $false
                        IsDocumented = $true
                    })
                }
            }
            $results.Values | Sort-Object Command, Name
        }
    }
}
