if command -v rails >/dev/null; then
    # Rails aliases
    alias r='rails'
    alias rc='rails console'
    alias rs='rails server'
    alias rdb='rails dbconsole'
    alias rg='rails generate'
    alias rgm='rails generate migration'
    alias rr='rails routes'

    # Rails environment aliases
    alias RAILS_ENV='RAILS_ENV=development'
    alias RAILS_ENV_TEST='RAILS_ENV=test'
    alias RAILS_ENV_PROD='RAILS_ENV=production'

    # Database aliases
    alias rdm='rails db:migrate'
    alias rdr='rails db:rollback'
    alias rds='rails db:seed'

    # Testing aliases
    alias rt='rails test'
    alias rspec='bundle exec rspec'
fi
