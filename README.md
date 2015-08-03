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

## Running
```bash
$ bundle exec unicorn -p 3000 -c config/unicorn.rb
# See the Dockerfile for more details
```

- Running with docker

```bash
$ docker run --restart=always --name=shiva -p 3000:3000 -v /home/mdouchement/opus:/data/storage -v /home/mdouchement/shiva/db:/data/db -d mdouchement/shiva

# Or if you want to namespace the app like http://localhost:3000/shiva
$ docker run --restart=always --name=shiva -e SHIVA_NAMESPACE='/shiva' -p 3000:3000 -v /home/mdouchement/opus:/data/storage -v /home/mdouchement/shiva/db:/data/db -d mdouchement/shiva
# You can also define RAILS_SERVE_STATIC_FILES environment variable if you want that Rails serve the assets

# Launch a Rails console for adding an admin user
$ docker exec -it shiva bundle exec rails c

# Reindexing
$ docker exec -it shiva bundle exec rake indexer /data/storage
```

## License

MIT. See the [LICENSE](https://github.com/mdouchement/shiva/blob/development/LICENSE) for more details.

## Contributing

1. Fork it
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Ensure specs and Rubocop pass
5. Push to the branch (git push origin my-new-feature)
6. Create new Pull Request
