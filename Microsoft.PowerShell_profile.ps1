# This file goes into the /Users/$username/Documents/WindowsPowerShell directory.

# Use UTF8 character encoding
$OutputEncoding = New-Object -typename System.Text.UTF8Encoding
[Console]::OutputEncoding = New-Object -typename System.Text.UTF8Encoding
$env:LC_ALL='en_US.UTF-8'
$env:LANG='en_US.UTF-8'

# Remove some insane PowerShell aliases that interfere with real programs.
if (test-path alias:\curl) {Remove-Item alias:\curl}
if (test-path alias:\wget) {Remove-Item alias:\wget}
if (test-path alias:\r) {Remove-Item alias:\r}

# Aliases for git
function git_status {git.exe status}
Set-Alias gst git_status

function git_commit {git.exe commit}
Set-Alias gct git_commit

function git_add {git.exe add}
Set-Alias ga git_add

function git_diff {git.exe diff}
Set-Alias gd git_diff

# Alias for Visual Studio
# Set-Alias cmake "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin\cmake.exe"

# Aliases to easily reach frequently used folders.
function go_cta {Set-Location D:\code\cta}
Set-Alias cta go_cta

function go_nyb {Set-Location D:\teach\203-nyb-electricite-magnetisme}
Set-Alias nyb go_nyb

# Set the prompt to something useful
function prompt {
    $cdarkred = [ConsoleColor]::Green

    Write-Host "$($executionContext.SessionState.Path.CurrentLocation)" -f $cdarkred
    Write-Output "$('>' * ($nestedPromptLevel + 1)) "
}
