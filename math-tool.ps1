[CmdletBinding()]
param(
    [ValidateSet('fibonacci', 'factorial')]
    [string]$Operation = 'fibonacci',

    [ValidateRange('NonNegative')]
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

function Get-Factorial {
    [CmdletBinding()]
    param(
        [ValidateRange(0, 20)]
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
            if ($N -gt 92) {
                throw 'N must be between 0 and 92 for fibonacci.'
            }

            $value = Get-Fibonacci -N $N
            Write-Output "Fibonacci($N) = $value"
        }
        'factorial' {
            if ($N -gt 20) {
                throw 'N must be between 0 and 20 for factorial.'
            }

            $value = Get-Factorial -N $N
            Write-Output "Factorial($N) = $value"
        }
    }
}
