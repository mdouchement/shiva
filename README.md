# Shiva

Audio media server. Only support Opus files.

## Requirements
 - MRI 2.2.0

## Create admin user
```rb
$ bundle exec rails c
[1] shiva »  User.create!(email: 'mdouchement@testouille.lan', username: 'mdouchement', password: 'trololoyolo')
```

## Indexing songs
```bash
$ bundle exec rake indexer /home/mdouchement/opus
```
