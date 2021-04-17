# Default editor
set -gx EDITOR nvim

# Chrome executable (use chromium if found)
set -gx CHROME_EXECUTABLE /opt/homebrew/bin/chromium

# Homebrew analytics and security
set -gx HOMEBREW_NO_ANALYTICS 1 # Opt out of homebrew analytics *(using google analytics).
set -gx HOMEBREW_NO_INSECURE_REDIRECT 1 # Permit redirects from https -> http
set -gx HOMEBREW_CASK_OPTS --require-sha # Check if cask uses sha256 :no_check and abort if it does during the install.
set -gx HOMEBREW_UPGRADE_CLEANUP 1 # Assume --cleanup is called when doing brew upgrade.

# M1 Mac node ssl flag override
# set -gx NODE_OPTIONS "--openssl-legacy-provider"
