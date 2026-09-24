[CmdletBinding()]
param()

Describe 'Get-Fibonacci' {
    BeforeAll {
        $scriptPath = Join-Path $PSScriptRoot 'math-tool.ps1'
        . $scriptPath
    }

    It 'returns only zero for N=0' {
        $result = @(Get-Fibonacci -N 0)

        $result | Should -HaveCount 1
        $result[0] | Should -BeOfType 'System.Int64'
        $result[0] | Should -Be 0
    }

    It 'returns one for N=1' {
        Get-Fibonacci -N 1 | Should -Be 1
    }

    It 'returns five for N=5' {
        Get-Fibonacci -N 5 | Should -Be 5
    }

    It 'returns the largest Fibonacci value that fits in Int64' {
        $result = Get-Fibonacci -N 92

        $result | Should -BeOfType 'System.Int64'
        $result | Should -Be 7540113804746346429
    }

    It 'rejects values whose Fibonacci result exceeds Int64' {
        { Get-Fibonacci -N 93 } | Should -Throw
    }
}

Describe 'Get-Factorial' {
    BeforeAll {
        $scriptPath = Join-Path $PSScriptRoot 'math-tool.ps1'
        . $scriptPath
    }

    It 'returns only one for N=0' {
        $result = @(Get-Factorial -N 0)

        $result | Should -HaveCount 1
        $result[0] | Should -BeOfType 'System.Int64'
        $result[0] | Should -Be 1
    }

    It 'returns one for N=1' {
        Get-Factorial -N 1 | Should -Be 1
    }

    It 'returns one hundred twenty for N=5' {
        Get-Factorial -N 5 | Should -Be 120
    }
}

Describe 'math-tool CLI' {
    BeforeAll {
        $scriptPath = Join-Path $PSScriptRoot 'math-tool.ps1'
        $pwsh = (Get-Command pwsh -CommandType Application | Select-Object -First 1).Source
    }

    It 'writes exactly one result line for N=0' {
        $output = @(& $pwsh -NoLogo -NoProfile -File $scriptPath -N 0)

        $LASTEXITCODE | Should -Be 0
        $output | Should -HaveCount 1
        $output[0] | Should -Be 'Fibonacci(0) = 0'
    }

    It 'writes exactly one result line for N=1' {
        $output = @(& $pwsh -NoLogo -NoProfile -File $scriptPath -N 1)

        $LASTEXITCODE | Should -Be 0
        $output | Should -HaveCount 1
        $output[0] | Should -Be 'Fibonacci(1) = 1'
    }

    It 'writes exactly one result line for N=5' {
        $output = @(& $pwsh -NoLogo -NoProfile -File $scriptPath -N 5)

        $LASTEXITCODE | Should -Be 0
        $output | Should -HaveCount 1
        $output[0] | Should -Be 'Fibonacci(5) = 5'
    }

    It 'dispatches explicitly to fibonacci' {
        $output = @(& $pwsh -NoLogo -NoProfile -File $scriptPath -Operation fibonacci -N 5)

        $LASTEXITCODE | Should -Be 0
        $output | Should -HaveCount 1
        $output[0] | Should -Be 'Fibonacci(5) = 5'
    }

    It 'dispatches to factorial for N=0' {
        $output = @(& $pwsh -NoLogo -NoProfile -File $scriptPath -Operation factorial -N 0)

        $LASTEXITCODE | Should -Be 0
        $output | Should -HaveCount 1
        $output[0] | Should -Be 'Factorial(0) = 1'
    }

    It 'dispatches to factorial for N=1' {
        $output = @(& $pwsh -NoLogo -NoProfile -File $scriptPath -Operation factorial -N 1)

        $LASTEXITCODE | Should -Be 0
        $output | Should -HaveCount 1
        $output[0] | Should -Be 'Factorial(1) = 1'
    }

    It 'dispatches to factorial for N=5' {
        $output = @(& $pwsh -NoLogo -NoProfile -File $scriptPath -Operation factorial -N 5)

        $LASTEXITCODE | Should -Be 0
        $output | Should -HaveCount 1
        $output[0] | Should -Be 'Factorial(5) = 120'
    }
}
