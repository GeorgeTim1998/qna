## Project name qna
Project is responsible for:
- Creating two types of users: admins, who manage tests, and basic users who pass tests
- Creating, managing and passing tests by users
- Authentification of users and resources
- Authorization of users
- Subscribing users for test's questions updates (question digests)

## Requirements
- ruby 2.7.0
- rails 6
- postgresql
- redis

## Services, rvm, bundle
Postgres:
```
brew update
brew install postgres
```
Redis:
```
sudo apt-get install redis-server
redis-server
```
To use rvm:
```
# Install gpg and rvm
brew install gnupg
gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable

# Add rvm to the bash profile then reload
echo '[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"' >> ~/.bash_profile
source ~/.bash_profile

# Install Ruby
rvm install 2.7.0
rvm use 2.7.0 --default
```
Bundle:
```
gem install bundle
bundle install
```

## Create database and migrate schema
- `rails db:create`
- `rails db:migrate`
- `rails db:seed`

## Lauch web app
`rails c`

## Tests
To run rspec tests do:
- `rspec spec/`
