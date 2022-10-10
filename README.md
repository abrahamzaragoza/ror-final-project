# TeamTask
TeamTask is a task management app that helps with planning, grouping and prioritizing tasks. You can use it as a part of your project management process or as standalone tool for creating, assigning, monitoring and tracking of tasks in any scale business.

This project was developed using the framework Ruby on Rails and trying to apply the rubocop guidelines.

One of the main ideas behind this project was to manage access levels through all the project. We simplified access management by providing single sign (Devise) on feature and multiple users on each project. The user can have different roles. To achieve this
we choose to user Authorized Persona, external add-on that handles authorization access.

## Gems used
- Devise
- Devise Intivations
- Authorized Persona
- Money Rails
- Stripe
- Sidekiq
- Image Processing
- Bootstrap
- Faker
- Letter Opener
- Rubocop Rails
- Rubocop RSpec
- Factory Bot

## Pending features
- API - using X-API-Token
- User two-way signin (SMS)
