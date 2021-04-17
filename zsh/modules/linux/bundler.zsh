if command -v bundle >/dev/null; then
    # Bundler aliases
    alias b='bundle'
    alias be='bundle exec'
    alias bi='bundle install'
    alias bu='bundle update'
    alias bx='bundle exec'

    # Gemfile aliases
    alias bopen='bundle open'
    alias boutdated='bundle outdated'
    alias bcheck='bundle check'

    # Bundle with specific groups
    alias bdev='bundle install --without production'
    alias bprod='bundle install --without development test'

    # Bundle cache management
    alias bclean='bundle clean --force'
    alias bstale='bundle clean --dry-run'
fi
