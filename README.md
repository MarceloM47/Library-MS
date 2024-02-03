
# Library Management System (LMS) <br>
## Installation

### Requirements

- Ruby 3.2.2
- Rails 7

### Install Library-MS

1. **Install dependencies:**

  ```bash
  bundle install
  ```

2. **Load initial data:**

  ```bash
  rails db:seed
  ```

3. **Apply migrations:**

  ```bash
  rails db:migrate
  ```
4. **Start the server:**

  ```bash
  rails s
  ```
<br>

## Seeds.rb
The "Profesor" specialty is created and the default administrator user is created.

```
Speciality.create!(name: "Profesor")

User.create!(
  email: "example@example.com",
  password: "123456",
  name: "root",
  lastname: "root",
  dni: "0000000",
  phone_number: "9999999999",
  admin: true,
  active: true,
  speciality_id: Speciality.first.id
)
```

## License

[MIT](https://choosealicense.com/licenses/mit/)
