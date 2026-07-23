# shellcheck shell=bash disable=SC1090
# --- Aliases ---
alias n='nvim'
alias gol='golangci-lint run ./... --fix'
alias gou='go get -u ./... && go mod tidy'
alias cc='claude --dangerously-skip-permissions --permission-mode acceptEdits'
alias ccr='claude --dangerously-skip-permissions --permission-mode acceptEdits --resume'
alias no='curl -fsSL "https://raw.githubusercontent.com/hotheadhacker/no-as-a-service/refs/heads/main/reasons.json" | jq -r ".[]" | awk "BEGIN{srand()} {a[NR]=\$0} END{print a[1+int(rand()*NR)]}"'

goland() {
	command goland "$@" >/dev/null 2>&1 &!
}
