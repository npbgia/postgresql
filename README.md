# postgresql
PostgreSQL

# Start/Stop PostgreSQL on MacOS:
## Reason why using sudo -u postgres: "run pg_ctl as the user postgres exclusively. Use sudo -u postgres if sudo has to be used for that."
sudo -u postgres /Library/PostgreSQL/12/bin/pg_ctl -D /Library/PostgreSQL/12/data start <br>
sudo -u postgres /Library/PostgreSQL/12/bin/pg_ctl -D /Library/PostgreSQL/12/data stop


# WINDOWS OS:
## Path chứa psql: C:\Program Files\PostgreSQL\12\bin <br>
SET PATH=%PATH%;"C:\Program Files\PostgreSQL\12\bin"

## Lỗi không dùng lệnh cmd psql "'more' is not recognized as an internal or external command, operable program or batch file." <br>
--> Khắc phục: epxort path này trước khi dùng psql để đăng nhập PosgreSQL <br>
PATH %PATH%;"C:\Windows\System32"
