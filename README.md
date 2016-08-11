# postgres-mangling
place to compile, debug, and mangle postgres

# build and run

Mangler is built and deployed using Docker

1. Build Mangler

    `docker build -t postgres_debug .`

2. Run Mangler

    `docker run -it --rm postgres_debug bash`

# Setup debugging

1. Create a new postgres database cluster

    `initdb -D /usr/local/pgsql/data`

2. Start the database server

    `pg_ctl -D /usr/local/pgsql/data -l logfile start`

3. Create a test database

    `createdb my_test_db`

4. Connect to the new database

    `psql my_test_db`

5. Create a new table

    ```
    create table author(
        id serial primary key,
        name varchar(200)
    );
    ```

6. Create some test data

    ```
    insert into author (name) values ('Daniel Silva');
    insert into author (name) values ('Tom Clancy');
    ```

7. Quit the postgres connection

    `\q`

8. Go to another terminal tab, exec to the existing container, and start a postgres connection

    `psql my_test_db`

9. Get the process id for this connection

    `select pg_backend_pid();`

10. Go back to the original window and start a debugging session and attach this process id (example using process id 100)

    `gdb attach -p 100`

11. Set a breakpoint at the beginning of executing a sql statement

    `exec_simple_query`
    
    Shows output:
    
    `Breakpoint 1 at 0x6e1db9: file postgres.c, line 885.`

12. Go back to the second terminal and issue a select statement - it shouldn't return because it should hit the breakpoint

    `select name from author where id = 1;`

13. Go back to the original terminal and enjoy debugging!

