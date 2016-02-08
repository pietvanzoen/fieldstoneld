# Fieldstone Landscape Development

## Installation

First, install [Bundler](http://bundler.io) if you haven't done so already:

    gem install bundler

Next clone the repo and install the dependencies:

    git clone git@github.com:pietvanzoen/fieldstoneld.git
    cd fieldstoneld
    bundle install

## Development

Use middleman's server command to run a local server that will watch for updates and live reload your browser:
  
    bundle exec middleman server

To generate a new portfolio item:

    bundle exec rake portfolio['portfolio item title']

## Deployment

To deploy to github pages, commit all changes to the master branch then:

    bundle exec middleman deploy
