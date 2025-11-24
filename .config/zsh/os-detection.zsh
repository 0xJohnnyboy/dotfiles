# =============================================================================
# OS Detection
# =============================================================================
# Detects the operating system and exports flags for conditional logic

case "$(uname -s)" in
    Darwin*)
        export IS_MAC=true
        export IS_WSL=false
        export IS_LINUX=false
        ;;
    Linux*)
        if grep -qEi "(Microsoft|WSL)" /proc/version &> /dev/null 2>&1; then
            export IS_WSL=true
            export IS_MAC=false
            export IS_LINUX=false
        else
            export IS_LINUX=true
            export IS_MAC=false
            export IS_WSL=false
        fi
        ;;
esac
