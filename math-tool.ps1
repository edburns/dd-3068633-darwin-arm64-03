[CmdletBinding()]
param(
    [ValidateSet('fibonacci', 'factorial')]
    [string]$Operation = 'fibonacci',

    [ValidateRange('NonNegative')]
    [long]$N = 0
)

Set-StrictMode -Version Latest

$script:MaxFibonacciN = 92L
$script:MaxFactorialN = 20L

function Get-Fibonacci {
    [CmdletBinding()]
    param(
        [ValidateScript({
            if ($_ -lt 0 -or $_ -gt $script:MaxFibonacciN) {
                throw "N must be between 0 and $script:MaxFibonacciN for fibonacci."
            }

            return $true
        })]
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

<#
.SYNOPSIS
Returns N factorial for Int64-safe inputs.

.PARAMETER N
A non-negative integer from 0 through 20.
#>
function Get-Factorial {
    [CmdletBinding()]
    param(
        [ValidateScript({
            if ($_ -lt 0 -or $_ -gt $script:MaxFactorialN) {
                throw "N must be between 0 and $script:MaxFactorialN for factorial."
            }

            return $true
        })]
        [long]$N
    )

    $value = 1L

    for ($index = 2L; $index -le $N; $index++) {
        $value *= $index
    }

    return $value
}

if ($MyInvocation.InvocationName -ne '.') {
    switch ($Operation) {
        'fibonacci' {
            if ($N -gt $script:MaxFibonacciN) {
                throw "N must be between 0 and $script:MaxFibonacciN for fibonacci."
            }

            $value = Get-Fibonacci -N $N
            Write-Output "Fibonacci($N) = $value"
        }
        'factorial' {
            if ($N -gt $script:MaxFactorialN) {
                throw "N must be between 0 and $script:MaxFactorialN for factorial."
            }

            $value = Get-Factorial -N $N
            Write-Output "Factorial($N) = $value"
        }
    }
}
