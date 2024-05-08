## Notes
Automatically create and delete users (only for Debian and similar distros).

## How to use

Grant execution permission.

```sh
chmod +x add-new-users.sh
chmod +x remove-users.sh
```

Run add-new-users.sh

```sh
sudo ./add-new-users.sh -f usernames.list
```

Run remove-users.sh

```sh
sudo ./remove-users.sh -f usernames.list
```
