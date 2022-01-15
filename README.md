# Question/answer app

## Plan:

- [x] set up bootstrap
- [x] add simple user model (using clearance for auth, for simplicity)
- [x] add basic question scaffold
  - handle auth
  - belongs_to user
  - title:string
  - body:text
- [ ] add basic answers scaffold
  - belongs_to user
  - belongs_to question
  - body:text
- [ ] set up view for users to view their questions and answers (users#show)

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

- [ ] authorization and access (feature spec)
- [ ] answering questions
- [ ] protecting the user/question/user/answer relationships
- [ ] if implemented, the user -< answered questions relationship

