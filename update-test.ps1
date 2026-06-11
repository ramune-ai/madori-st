param([string]$num)

if (-not $num) {
  Write-Host "番号を付けて実行してください 例: .\update-test.ps1 227" -ForegroundColor Yellow
  return
}

$src  = "$env:USERPROFILE\Downloads\puzzle_$num.html"
$repo = "$env:USERPROFILE\Documents\madori-github"
$dst  = "$repo\test.html"

if (-not (Test-Path $src)) {
  Write-Host "元ファイルが見つかりません: $src" -ForegroundColor Red
  return
}

Copy-Item $src $dst -Force
Set-Location $repo
git add -A
git commit -m "test: $num"
git push

Write-Host "完了 → https://ramune-ai-cpu.github.io/madori-st/test.html?v=$num" -ForegroundColor Green