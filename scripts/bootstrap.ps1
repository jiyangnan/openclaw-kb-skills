Param(
  [Parameter(Mandatory=$true)][string]$Vault,
  [switch]$Force
)

# OpenClaw KB Skills bootstrap (PowerShell)
# Creates folder structure INSIDE your Obsidian Vault and optionally copies rules/templates.

if (-not (Test-Path -LiteralPath $Vault)) {
  throw "Vault path does not exist: $Vault"
}

$target = Join-Path $Vault "KB"
$folders = @(
  (Join-Path $target "inputs"),
  (Join-Path $target "notes"),
  (Join-Path $target "queue"),
  (Join-Path $target "rules"),
  (Join-Path $target "reviews"),
  (Join-Path $target "_templates_openclaw")
)

foreach ($f in $folders) {
  New-Item -ItemType Directory -Force -Path $f | Out-Null
}

Write-Host "[bootstrap] Created/verified folders under: $target"

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")

function Copy-Dir($src, $dst) {
  if (-not (Test-Path $src)) { return }
  if ($Force) {
    Copy-Item -Recurse -Force -Path (Join-Path $src '*') -Destination $dst
  } else {
    # Ignore existing: copy only new files
    Get-ChildItem -Recurse -File $src | ForEach-Object {
      $rel = $_.FullName.Substring($src.Path.Length).TrimStart('\','/')
      $out = Join-Path $dst $rel
      $outDir = Split-Path -Parent $out
      New-Item -ItemType Directory -Force -Path $outDir | Out-Null
      if (-not (Test-Path $out)) {
        Copy-Item -Force -Path $_.FullName -Destination $out
      }
    }
  }
}

Copy-Dir (Join-Path $repoRoot "KB\rules") (Join-Path $target "rules")
Copy-Dir (Join-Path $repoRoot "KB\templates") (Join-Path $target "_templates_openclaw")

Write-Host "[bootstrap] Copied rules to: $target\rules"
Write-Host "[bootstrap] Copied templates to: $target\_templates_openclaw"

Write-Host "\nNext steps:"
Write-Host "1) Copy skills/* to ~/.openclaw/workspace/skills/"
Write-Host "2) Copy KB/* to ~/.openclaw/workspace/KB/"
Write-Host "3) Run a test: feed a URL to kb-orchestrator (or kb-inbox-digest).\n"
