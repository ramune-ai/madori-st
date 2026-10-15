use utf8; use strict;
# test.html から「テスト版だけの開発用ツール」を取り除いて、本番の puzzle.html を作る。
# 使い方（madori-st フォルダで）：perl tools/make_puzzle.pl
# 開発用ツールは「▼ テスト版だけの開発用ツール」の目印つき3か所（CSS・JS・HTML）。
use FindBin;
binmode STDOUT,':encoding(UTF-8)'; binmode STDERR,':encoding(UTF-8)';
my $dir="$FindBin::Bin/..";
my $src="$dir/test.html";
my $dst="$dir/puzzle.html";
open my $in,'<:encoding(UTF-8)',$src or die "test.html が開けません"; local $/; my $s=<$in>; close $in;
# CSS
$s=~s{/\* ═+\n   ▼ テスト版だけの開発用ツール（本番 puzzle\.html には入れない）\n   ═+ \*/\n.*?\.dev-note\{[^\n]*\n}{}s or die "css の目印が見つかりません";
# JS
$s=~s{// ═+\n// ▼ テスト版だけの開発用ツール（本番 puzzle\.html にはコピーしない）\n.*?\n(tryResumeGame\(\);\n)}{$1}s or die "js の目印が見つかりません";
# HTML
$s=~s{<!-- ▼ テスト版だけの開発用ツール（本番 puzzle\.html には入れない） -->\n<button id="dev-fab".*?\n</div>\n}{}s or die "html の目印が見つかりません";
# 取り残しがないか確かめる
for my $w (qw(dev-fab dev-panel dev-btn devToggle devPickPart devReroll devBuildParts devSetDay devPickLand devResetWash devResetFirst devBuildLands dev-lands テスト版だけ)){
  die "開発用ツールが残っています: $w\n" if $s=~/\Q$w\E/;
}
open my $o,'>:encoding(UTF-8)',$dst or die; print $o $s; close $o; print "ok: puzzle.html を作りました\n";
