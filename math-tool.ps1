[CmdletBinding()]
param(
    [ValidateRange(0, 92)]
    [long]$N = 0
)

Set-StrictMode -Version Latest

function Get-Fibonacci {
    [CmdletBinding()]
    param(
        [ValidateRange(0, 92)]
        [long]$N
    )

    $previous = 0L
    $current = 1L

    for ($index = 0L; $index -lt $N; $index++) {
        $next = $previous + $current
        $previous = $current
        $current = $next
    }

    return $previous
}

if ($MyInvocation.InvocationName -ne '.') {
    $value = Get-Fibonacci -N $N
    Write-Output "Fibonacci($N) = $value"
}
