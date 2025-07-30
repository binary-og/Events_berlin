# Use official Ruby image based on your specified version
FROM ruby:3.2.2

# Install required system dependencies
RUN apt-get update -qq && \
    apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    npm \
    postgresql-client \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Install Yarn (needed for Rails asset pipeline)
RUN npm install -g yarn

# Create and set the working directory
WORKDIR /app

# Copy Gemfile and Gemfile.lock first to cache gems
COPY Gemfile Gemfile.lock /app/

# Install gems
RUN bundle install

# Copy the rest of the application code
COPY . /app/

# Add a script to be executed every time the container starts
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Expose the port the app runs on
EXPOSE 3000

# Start the main process
CMD ["rails", "server", "-b", "0.0.0.0"]