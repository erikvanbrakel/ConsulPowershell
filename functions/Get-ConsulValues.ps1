function Get-ConsulValues {
    param ($Prefix, $Address = "http://localhost:8500")
    $obj = @{}
    (Invoke-RestMethod -Uri $Address/v1/kv/$Prefix/?recurse | Sort-Object Key) | % {
        $value = $_.Value
        $path = $_.Key.substring($prefix.Length + 1) -split "/"
        if($path.Length -ne 0) {
            $ptr = $obj
            for($i=0;$i -lt $path.Length-1;$i++) {
                if($ptr[$path[$i]] -eq $null) {
                    $ptr[$path[$i]] = @{}
                }
                $ptr = $ptr[$path[$i]]
            }
            $ptr[$path[$path.Length-1]] = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($value))
        }
    }

    return $obj
}
