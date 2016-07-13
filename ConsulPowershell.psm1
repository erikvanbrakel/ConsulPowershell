$basePath = (Split-Path -parent $MyInvocation.MyCommand.Definition);

$functionPaths = Resolve-Path $basePath\functions\*.ps1

$functionPaths |
    Where-Object { -not ($_.ProviderPath.Contains(".Tests.")) } |
    ForEach-Object { . $_.ProviderPath }
    
$functions = (Get-ChildItem $functionPaths).BaseName

Export-ModuleMember -Function $functions
