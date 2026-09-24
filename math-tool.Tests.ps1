[CmdletBinding()]
param()

$scriptPath = Join-Path $PSScriptRoot 'math-tool.ps1'

Describe 'Get-Fibonacci' {
    BeforeAll {
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
}

Describe 'math-tool CLI' {
    BeforeAll {
        $pwsh = (Get-Command pwsh -CommandType Application).Source
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
}
