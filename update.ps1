param([string]$num)
$src="C:\Users\aidor\Downloads\puzzle_$num.html"
$dst="C:\Users\aidor\Documents\madori-github\puzzle.html"
Copy-Item $src $dst -Force
git add puzzle.html
git commit -m "update"
git push origin main --force
