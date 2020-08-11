## CLI Commands
To get started using the authorization gem checkout the README.MD Usage section

rails api_auth:create_admin[email,password] # Create an admin

| Command  | arguments | Description |
| -------- | ------- | ----------- |
| `rails api_auth:install` | `tenant`,`single_role`| Create the initial tables |
| `api_auth:create_admin`  | `email`,`password`  | Create an admin user |
| `rails api_auth:create_user`  | `tenant`,`email`,`password`  | Create a custom user |
| `rails api_auth:promote_superadmin` | `tenant`,`email` | Make a user superadmin |
| `rails api_auth:re_populate_permissions` | `tenant` | This command will generate based on the routes of the application and instert them on the permissions table |
| `rails api_auth:reset_password` | `tenant`,`email`,`new_password` | Change the password of a user |