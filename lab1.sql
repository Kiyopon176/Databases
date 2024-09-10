CREATE DATABASE lab1;

CREATE TABLE users (
    id SERIAL,
    firstname VARCHAR(50),
    lastname VARCHAR(50)
);

ALTER TABLE users ADD COLUMN isadmin INTEGER;

ALTER TABLE users ALTER COLUMN isadmin TYPE BOOLEAN USING (isadmin::boolean);

ALTER TABLE users ALTER COLUMN isadmin SET DEFAULT false;

ALTER TABLE users ADD PRIMARY KEY (id);

CREATE TABLE tasks (
    id SERIAL,
    name VARCHAR(50),
    user_id INTEGER
);
