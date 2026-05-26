# shellcheck shell=bash disable=SC2034

flexoki_black="#100f0f"
flexoki_base_950="#1c1b1a"
flexoki_base_500="#878580"
flexoki_base_200="#cecdc3"
flexoki_status_fg="$flexoki_base_200"
flexoki_status_muted="$flexoki_base_500"
flexoki_blue_2="#4385be"

TMUX_POWERLINE_SEPARATOR_THIN="|"

TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR=${TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR:-$flexoki_base_950}
TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR=${TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR:-$flexoki_base_200}

TMUX_POWERLINE_LEFT_STATUS_SEGMENTS=()
TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS=(
	"slack $flexoki_base_950 $flexoki_status_muted default_separator no_sep_bg_color no_sep_fg_color left_disable separator_disable"
	"date $flexoki_base_950 $flexoki_status_fg default_separator no_sep_bg_color no_sep_fg_color left_disable separator_disable"
	"time $flexoki_base_950 $flexoki_status_fg default_separator no_sep_bg_color no_sep_fg_color both_disable separator_disable"
)

TMUX_POWERLINE_WINDOW_STATUS_CURRENT=(
	"#[fg=$flexoki_black,bg=$flexoki_blue_2,bold]"
	" #I "
	"$TMUX_POWERLINE_SEPARATOR_THIN"
	" #W "
	"#[fg=$flexoki_base_950,bg=$flexoki_base_950,nobold]"
	" "
)

TMUX_POWERLINE_WINDOW_STATUS_FORMAT=(
	"#[fg=$flexoki_base_500,bg=$flexoki_base_950,nobold]"
	" #I "
	"$TMUX_POWERLINE_SEPARATOR_THIN"
	" #W "
	" "
)
