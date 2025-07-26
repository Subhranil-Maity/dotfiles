#Enable-TransientPrompt

Import-Module syntax-highlighting
Import-Module posh-git
Import-Module -Name Terminal-Icons

Set-PSReadLineOption -HistorySaveStyle SaveIncrementally
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }

Invoke-Expression (& { (zoxide init powershell | Out-String) })
$PSStyle.FileInfo.Directory = ""



$env:FZF_DEFAULT_OPTS="--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 --color=selected-bg:#45475a --multi"
$env:FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
$env:FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
$env:FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
$env:FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"





# Set-Alias cd "z" -Scope Global
# Aliase

# $ezaPath = (Get-Command eza).Source

# Set-Alias "ls" "eza" -Scope Global
function ls { eza @Args }
function l { eza --icons }
function ll { eza --icons -l @Args }
function la { eza --icons -a @Args }

Invoke-Expression (&starship init powershell)
