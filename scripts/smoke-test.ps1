
param(
    [string]$BaseUrl = "http://localhost:8081"
)

$ErrorActionPreference = "Stop"

Write-Host "Checking application health..."

$health = Invoke-RestMethod -Uri "$BaseUrl/health" -TimeoutSec 10

if ($health.status -ne "healthy") {
    throw "Health check failed. Expected status 'healthy'."
}

Write-Host "Health check passed."

Write-Host "Checking application response..."

$app = Invoke-RestMethod -Uri "$BaseUrl/" -TimeoutSec 10

if ($app.application -ne "GitOps Kubernetes Platform") {
    throw "Application identity check failed."
}

if (-not $app.version) {
    throw "Application version is missing."
}

Write-Host "Application smoke tests passed."
Write-Host "Version: $($app.version)"
