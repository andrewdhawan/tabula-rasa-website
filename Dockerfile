# Use the official Ruby image as the base image
FROM ruby:3.1.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Set the working directory
WORKDIR /srv/jekyll

# Copy the Gemfile and Gemfile.lock into the working directory
COPY Gemfile Gemfile.lock ./

# Install Bundler and RubyGems
RUN gem update --system
RUN gem install bundler -v 2.4.7

# Install the Ruby gems
RUN bundle install

# Copy the rest of the application code into the working directory
COPY . ./

# Set permissions for the working directory
RUN chown -R root:root /srv/jekyll
RUN chmod -R 777 /srv/jekyll

# Expose port 4000 to the Docker host
EXPOSE 4000

# Define the default command to run when starting the container
CMD ["jekyll", "serve", "--watch", "--force_polling", "--host", "0.0.0.0"]
