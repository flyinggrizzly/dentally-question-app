# Question/answer app

So, this is not a complete solution, but it is moving in that direction. The
very basics of the app are working, but there are still some unsolved problems
around answering questions at the moment.

The reason this is happening is that I have put the answer form on the question
show view, which means that error reporting for invalid input isn't yet working
(and there are redirect or local variable issues).

There are still a lot of rough edges, but the commit history, approach to
testing (primarily focused on core behavior/business logic, not so much on Rails
basics), and code style (again, aside from some code that came in with the
scaffold that I would possibly remove).

The only thing that's unusual is that I would likely have broken this up into
multiple PRs--one for users, one for questions, one for answers, and then
further PRs for the behavioral refinements.

I began the work by mapping out the object relationships, and sketching out the
approach (all below in the readme). Then I started working through the
checklist.

## Setup

1. Install: `% bundle`
2. Install JS packages: `% yarn`
3. Create db (sqlite3): `% bin/rails db:create db:migrate`
4. Start the application: `% bin/dev # bin/dev runs the CSS bundling in addition to the server`
5. Run tests `% bundle exec rspec`

## Plan:

- [x] set up bootstrap
- [x] add simple user model (using clearance for auth, for simplicity)
- [x] add basic question scaffold
  - handle auth
  - belongs_to user
  - title:string
  - body:text
- [x] add basic answers scaffold
  - belongs_to user
  - belongs_to question
  - body:text
- [ ] set up view for users to view their questions and answers (users#show)
- [ ] protect questions and answers from editing by non-owners
- [x] feature spec to verify auth
- [x] feature spec to verify asking questions
- [ ] feature spec to verify answering questions

### Future development

- [ ] set up "chosen answer" behavior/functionality
- [ ] do we need to give users a relationship to questions  they have submitted
    answers for (e.g. `has_many :answered_questions, class: 'Question', through:
    :answers`) (not sure if that has many with a class arg is valid, but that
    can be looked up)
- [ ] consider multiple chosen answers?

## Approach

The plan is to use Stack Overflow as a model for this (also Quora etc).

The basic data model is

```
User -< Question
Question -< Answer
User -< Answer
User -< AnsweredQuestion, through: :answer
```

The last one may be a "future requirement", pending time.

### Uniqueness constraints

I've set a uniqueness constraint on the question title, knowing that it is
probably a bad idea in a production situation.

The reason for this is that I also know that in the long run we'd want to have
some kind of deduplication logic in place on questions, and this is a fast and
dirty way to point at the issue and the general... family of solutions we'd
need. (Bonus: it also demonstrates I use database-level constraints to back
critical logic).

### User modelling and auth

For the sake of getting this complete in a short amount of time, I'm using
Clearance for user modelling and auth. It's clean, simple, and fast. If this
were a real production application, I'd be doing more research/working with
stakeholders to identify more concrete needs than the current requirement of
"shouldn't take more than a couple hours".

### Using basic Rails rendered views instead of an SPA

Currently there's no need for any kind of highly interactive functionality, so
heavy JS isn't required. UJS is plenty.

### Testing

This is pretty light on tests, intentionally--most of the code is very basic
Rails, and so tests would be testing the framework as much as the application.

Things that will need testing are usually business logic/requirements:

- [x] authorization and access (feature spec)
- [ ] answering questions
- [ ] protecting the user/question/user/answer relationships
- [ ] if implemented, the user -< answered questions relationship

