# Prerequisites

You should have `ruby`, `rails` and `postgres` installed. If you don't, install ruby and rails from [here](https://gorails.com/setup/ubuntu/20.04) and postgres from [here](https://www.postgresql.org/download/).

## Installing

1. Download the zipped file and unzip it or Clone it
   ```sh
   $ git clone https://github.com/ahmedhamid13/Educatly-Airline.git
   ```
2. Run this command to install the packages needed
   ```sh
   $ bundle install
   ```
3. Run this command to create the database and migrate tables
   ```sh
   $ rake db:create db:migrate
   ```
4. Run this command to seed the database with data
   ```sh
   $ rake db:seed
   ```
5. Run this command to open the server
   ```sh
   $ rails s
   ```

- > you can login with super admin user by (email: super_admin@college.com, password: admin123).
- > you can login with admin user by (email: ahmed_admin@mail.com, password: 123456), or create new admin from admin dashboard.
- > you can login with premium user by (email: ahmed_premium@mail.com, password: 123456), or create new premium from registration.
- > you can login with normal user by (email: ahmed_normal@mail.com, password: 123456), or create new normal from registration.

## Technologies

- **Ruby on Rails** => Full Stack Application.
- **PostgreSQL** => SQL Database.
- **GraphQL** => Query Language.
- **Heroku** => PaaS.
- **Sass** => Stylesheet - Structure.
- **Ruby Gems** => Ruby's packages as: (devise, cancancan, ahoy, friendly_id, sentry, i18n, blazer, rails_performance and rails_admin).

# GraphQL Examples

## Queries

### All

```graphql
{
  fetchComments {
    id
    body
    user {
      name
      email
    }
    post {
      title
      body
    }
  }
}
```

### Find

```graphql
{
  fetchComment(id: 1) {
    id
    body
    user {
      name
      email
    }
    post {
      title
      body
    }
  }
}
```

## Mutation

### Create

```graphql
mutation {
  createComment(input: { params: { body: "body", postId: 1, userId: 1 } }) {
    comment {
      id
      body
    }
  }
}
```

### Update

```graphql
mutation {
  updateComment(
    input: { id: 1, params: { body: "body22", postId: 1, userId: 1 } }
  ) {
    comment {
      id
      body
    }
  }
}
```

### Destroy

```graphql
mutation {
  destroyComment(input: { id: 1 }) {
    comment {
      id
      body
    }
  }
}
```

# QR-Code To Deployment web

<img src="https://github.com/ahmedhamid13/college-get-together/blob/main/qrcode.png" alt="college together qr code" width="200">

### License

MIT License

Copyright (c) 2021 [Ahmed Abdelhamid](https://github.com/ahmedhamid13)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
