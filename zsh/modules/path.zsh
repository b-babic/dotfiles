SBIN=/user/local/sbin
BIN=$HOME/.bin
GEMS=$HOME/.gem/ruby/2.6.0/bin
BREW=/opt/homebrew
FLUTTER_GLOBAL=$HOME/.pub-cache/bin
DOTNET_TOOLS=$HOME/.dotnet/tools

# Add dotnet SDK paths
DOTNET_VERSION=$(mise current dotnet-core | awk '{print $1}')
DOTNET_SDKS_DIR=$HOME/.local/share/mise/installs/dotnet-core/$DOTNET_VERSION/sdk/$DOTNET_VERSION/Sdks
DOTNET_CLI_DIR=$HOME/.local/share/mise/installs/dotnet-core/$DOTNET_VERSION

export PATH=$PATH:$BIN:$GEMS:$BREW:$FLUTTER_GLOBAL:$DOTNET_TOOLS:$DOTNET_SDKS_DIR:$DOTNET_CLI_DIR:$DOTNET_SDKS_DIR:$DOTNET_CLI_DIR:$SBIN
