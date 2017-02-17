#
# zshrc
#

# 色出力
autoload -Uz colors; colors

# 日本語ファイル名を表示可能とする
setopt print_eight_bit

# beepを無効にする
setopt no_beep

# フローコントロールを無効にする
setopt no_flow_control

# '#'以降をコメントとして扱う
setopt interactive_comments

# コマンド訂正
setopt correct

# プロンプト定義内で変数置換やコマンド置換を扱う
setopt prompt_subst

# バックグラウンドジョブの状態変化を即時報告する
setopt notify

# =commandを'which command'と同じ処理にする
setopt equals

##################################################
# 補完機能
autoload -U compinit; compinit

# 補完候補を詰めて表示する
setopt list_packed

# 補完候補にファイルの種類も表示する
setopt list_types

# 補完候補表示時にビープ音を鳴らさない
setopt nolistbeep

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ../の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudoの後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# psコマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

# =以降も補完する(--prefix=/usrなど)
setopt magic_equal_subst

# 補完候補を一覧で表示する
setopt auto_list

# 補完キー連打で補完候補を順に表示する
setopt auto_menu

# Shift-tabで補完候補を逆順する("\e[z"でも動作する)
bindkey "^[[z" reverse-menu-complete

##################################################
# viライクキーバインド
bindkey -v

# ^Rで履歴検索するときに*でワイルドカードを使用できるようにする
bindkey '^R' history-incremental-pattern-search-backward

# backspace,deleteキーを使えるようにする
stty erase ^H
bindkey "^[[3~" delete-char

# Ctrl-s,Ctrl-qを無効にする
setopt no_flow_control

##################################################
# コマンド履歴
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
command history list

# コマンド履歴検索
autoload history-search-end
zle -N history-beginning-search-backward-end
history-search-end
zle -N history-beginning-search-forward-end
history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# ディレクトリ名を入力するだけで移動する
setopt auto_cd

# 移動したディレクトリを記録しておく。"cd -[tab]"で移動履歴を一覧
setopt auto_pushd

# 重複したディレクトリを履歴に残さない
setopt pushd_ignore_dups

# 同じコマンドを履歴に残さない
setopt hist_ignore_all_dups

# 同時に起動したzsh間で履歴を共有する
setopt share_history

# スペースから始まるコマンド行は履歴に残さない
setopt hist_ignore_space

# 履歴に保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# 高機能なワイルドカード展開を使用する
setopt extended_glob

##################################################
# エイリアス
case "${OSTYPE}" in
	darwin*)
		export CLICOLOR=1
		alias ls='ls -G'
		;;
	linux*)
		alias ls='ls --color=auto'
		;;
esac
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -AlF'
alias lr='ls -lR'
alias lh='ls -lh'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'

# プロンプト
case "${UID}" in
	0)
		PROMPT="%B%U%{${fg[red]}%}%n%# %{${reset_color}%}%u%b"
		PROMPT2="%B%U%{${fg[red]}%}%_# %{${reset_color}%}%u%b"
		RPROMPT="%B%U%{${fg[red]}%}[%~] %{${reset_color}%}%u%b"
		SPROMPT="%B%U%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%u%b"
		#PROMPT="%{[31m%}%n%%%{[m%} "
		#RPROMPT="[%~]"
		#PROMPT2="%B%{[31m%}%_#%{[m%}%b "
		#SPROMPT="%B%{31m%}%r is correct? [n,y,a,e]:%{[m%}%b "
		#[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
		;;
	*)
		PROMPT="%{${fg[green]}%}%n%# %{${reset_color}%}"
		PROMPT2="%{${fg[green]}%}%_# %{${reset_color}%}"
		RPROMPT="%{${fg[green]}%}[%~] %{${reset_color}%}"
		SPROMPT="%{${fg[green]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}"
		#PROMPT="%{[31m%}%n%%%{[m%} "
		#RPROMPT="[%~]"
		#PROMPT2="%{[31m%}%_%%%{[m%} "
		#SPROMPT="%{[31m%}%r is correct? [n,y,a,e]:%{[m%} "
		#[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
	;;
esac
