# check if reboot is required
alias rr='if [ -f /var/run/reboot-required ]; then echo "reboot required"; else echo "No reboot needed"; fi'

# improve shell highlighting
alias ls='ls --color'
LS_COLORS='di=36:ex=92'
export LS_COLORS
