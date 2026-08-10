"$schema" = 'https://starship.rs/config-schema.json'

format = """
[░▒▓]({{ lighter_background }})\
$os\
[](bg:{{ accent }} fg:{{ lighter_background }})\
$directory\
[](fg:{{ accent }} bg:{{ background }})\
$git_branch\
$git_status\
[](fg:{{ background }} bg:{{ dark_background }})\
$nodejs\
$bun\
$rust\
$golang\
$php\
[](fg:{{ dark_background }} bg:{{ darker_background }})\
$time\
[ ](fg:{{ darker_background }})\
\n$character"""

[directory]
style = "fg:{{ background }} bg:{{ accent }}"
format = "[ $path ]($style)"
truncation_length = 3
truncation_symbol = "…/"

[directory.substitutions]
"Documents" = "󰈙 "
"Downloads" = " "
"Music" = " "
"Pictures" = " "

[git_branch]
symbol = ""
style = "bg:{{ background }}"
format = '[[ $symbol $branch ](fg:{{ accent }} bg:{{ background }})]($style)'

[git_status]
style = "bg:{{ background }}"
format = '[[($all_status$ahead_behind )](fg:{{ accent }} bg:{{ background }})]($style)'

[nodejs]
symbol = ""
style = "bg:{{ dark_background }}"
format = '[[ $symbol ($version) ](fg:{{ accent }} bg:{{ dark_background }})]($style)'

[bun]
symbol = ""
style = "bg:{{ dark_background }}"
format = '[[ $symbol ($version) ](fg:{{ accent }} bg:{{ dark_background }})]($style)'

[rust]
symbol = ""
style = "bg:{{ dark_background }}"
format = '[[ $symbol ($version) ](fg:{{ accent }} bg:{{ dark_background }})]($style)'

[golang]
symbol = ""
style = "bg:{{ dark_background }}"
format = '[[ $symbol ($version) ](fg:{{ accent }} bg:{{ dark_background }})]($style)'

[php]
symbol = ""
style = "bg:{{ dark_background }}"
format = '[[ $symbol ($version) ](fg:{{ accent }} bg:{{ dark_background }})]($style)'

[time]
disabled = false
time_format = "%R" # Hour:Minute Format
style = "bg:{{ darker_background }}"
format = '[[  $time ](fg:{{ dark_foreground }} bg:{{ darker_background }})]($style)'

[os]
style = "bg:{{ lighter_background }} fg:{{ background }}"
format = "[ $symbol ]($style)"
disabled = false

[os.symbols]
Windows = "󰍲"
Ubuntu = "󰕈"
SUSE = ""
Raspbian = "󰐿"
Mint = "󰣭"
Macos = "󰀵"
Manjaro = ""
Linux = "󰌽"
Gentoo = "󰣨"
Fedora = "󰣛"
Alpine = ""
Amazon = ""
Android = ""
AOSC = ""
Arch = "󰣇"
Artix = "󰣇"
EndeavourOS = ""
CentOS = ""
Debian = "󰣚"
Redhat = "󱄛"
RedHatEnterprise = "󱄛"
Pop = ""
