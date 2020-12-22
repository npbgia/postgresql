# postgresql
PostgreSQL

# Start/Stop PostgreSQL on MacOS:
## Reason why using sudo -u postgres: "run pg_ctl as the user postgres exclusively. Use sudo -u postgres if sudo has to be used for that."
sudo -u postgres /Library/PostgreSQL/12/bin/pg_ctl -D /Library/PostgreSQL/12/data start <br>
sudo -u postgres /Library/PostgreSQL/12/bin/pg_ctl -D /Library/PostgreSQL/12/data stop
