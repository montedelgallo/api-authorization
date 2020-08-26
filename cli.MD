## CLI Commands
To learn more on how to use the `api_authorization` gem checkout the README.MD Usage section.
Below are some useful commands for creating users with different roles(more comming soon...)

| Command  | arguments | Description |
| -------- | ------- | ----------- |
| `rails api_auth:install` | `tenant`,`single_role`| Create the initial tables |
| `rails api_auth:create_admin`  | `email`,`password`  | Create an admin user |
| `rails api_auth:create_user`  | `tenant`,`email`,`password`  | Create a custom user |
| `rails api_auth:promote_superadmin` | `tenant`,`email` | Make a user superadmin |
| `rails api_auth:re_populate_permissions` | `tenant` | Populate permissions table with the routes of your application |
| `rails api_auth:reset_password` | `tenant`,`email`,`new_password` | Change the password of a user |