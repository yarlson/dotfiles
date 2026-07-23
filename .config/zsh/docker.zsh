# --- Colima and Testcontainers ---
export DOCKER_HOST="unix://${HOME}/.colima/default/docker.sock"
export TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE="/var/run/docker.sock"
export TESTCONTAINERS_RYUK_DISABLED="false"

alias sandbox='docker run -it --rm --name "claude-sandbox-$(pwd -P | shasum | cut -c1-8)" -v "$(pwd -P)":"$(pwd -P)" -w "$(pwd -P)" -v claude-sandbox-mise:/mise -v claude-sandbox-home:/root/.claude claude-sandbox claude --dangerously-skip-permissions --append-system-prompt-file /etc/claude-sandbox/instructions.md'
