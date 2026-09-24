[CmdletBinding()]
param(
    [ValidateSet('fibonacci', 'factorial')]
    [string]$Operation = 'fibonacci',

    [long]$N = 0
)

Set-StrictMode -Version Latest

function Assert-MathToolInput {
    [CmdletBinding()]
    param(
        [ValidateSet('fibonacci', 'factorial')]
        [string]$Operation,

        [long]$N
    )

    # Maximum inputs whose operation results fit in Int64.
    $maximum = switch ($Operation) {
        'fibonacci' { 92L }
        'factorial' { 20L }
        default { throw "Unsupported operation '$Operation'." }
    }

    if ($N -lt 0 -or $N -gt $maximum) {
        throw "N must be between 0 and $maximum for $Operation."
    }
}

function Get-Fibonacci {
    [CmdletBinding()]
    param(
        [long]$N
    )

    Assert-MathToolInput -Operation fibonacci -N $N

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
        [long]$N
    )

    Assert-MathToolInput -Operation factorial -N $N

    $value = 1L

    for ($index = 2L; $index -le $N; $index++) {
        $value *= $index
    }

    return $value
}

if ($MyInvocation.InvocationName -ne '.') {
    switch ($Operation) {
        'fibonacci' {
            $value = Get-Fibonacci -N $N
            Write-Output "Fibonacci($N) = $value"
        }
        'factorial' {
            $value = Get-Factorial -N $N
            Write-Output "Factorial($N) = $value"
        }
    }
}
