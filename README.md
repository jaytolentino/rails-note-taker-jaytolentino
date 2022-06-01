# rails-note-taker

For this mini-project, you will implement an API and create system documentation for a fictional note-taking application.

Please spend no more than 2 hours on this project. When you are done, please open a pull request with your work.

# The Project

1. Draw associations between users and notes. You should use the rspec tests to validate your work for this and the next step.

1. Implement the note-taking CRUD API endpoints.

1. Create technical design documentation about the reminder system. The reminder system should be fully documented in a way that allows other engineers and stakeholders know how the system should be implemented. The documentation should be complete enough to be able to give an accurate estimated level of effort to complete and represent a production level system. The documentation should be distributed in a way that makes it easy for everyone to view, for example a Google doc linked in the pull request.

## The Requirements
The notepad application allows a user to create notes and set an optional reminder for each note. The user can modify and delete notes as well as search for notes viewing only notes containing the search text. A reminder can be set on a note that will email the user on the specified date with the note text as the body of the email.

The UI Application is expecting a note structure to have the following fields:

|Field|Type|Description|
|---|---|---|
|id|string|This is the ID of the note as generated on the server.|
|title|string|This is the body of the note can can be a string of up to 200 characters in length.|
|scheduled_at|string|This is the schedule of the reminder and can be an ISO-8601 date string including time.|

The reminder date and time will be used to send an email message to the user when that date and time passes. The body of the email will contain the title of the note.

### The User Interface
[This video](https://www.loom.com/share/0030e97a8ade4a02805a27484d3fd127) shows how the user interface should behave.
### The Notepad API Definition
The Notepad API should contain full CRUD operations. The following table describes the endpoints expected by the UI:

|HTTP Method|Path|Description|
|-----------|----|-----------|
|GET|/notes|This will retrieve notes from the server. A `query` query string variable can be set to filter the notes.|
|GET|/notes/:id|This will retrieve a note with the given ID.|
|POST|/notes|This will create a new note from the JSON value in the payload.|
|PUT|/notes/:id|This will update the note with the given ID using the JSON value in the payload.|
|DELETE|/notes/:id|This will delete the note with the given ID.|

The title can be between 1 and 200 characters long. Updates can be sparse and only include the data you wish to update. Omitting data will keep the existing data intact.

### Application Setup

```shell
  # install dependencies
  bundle
  npm install -g yarn # if you don't already have it
  yarn install

  # setup the db
  bundle exec rake db:setup
  bundle exec rake db:migrate

  # misc setup
  git config core.hooksPath .githooks # run linters on commit (optional)

  # run the tests
  bundle exec rspec spec
```
### Running The UI (Optional)

Your server should run on port 3000. When you have a working server you can run the UI Application and it will
communicate with your server on port 3000. Start your server first and then run the UI Application by executing the
following commands in the project directory.

```shell
bundle exec rails s
./bin/webpack-dev-server
```
