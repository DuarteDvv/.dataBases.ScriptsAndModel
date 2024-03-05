-- SQLite doesn't support some of the MySQL-specific syntax, so adjustments are made.

-- Create urgency table
CREATE TABLE IF NOT EXISTS urgency (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    urgency TEXT NOT NULL
);

-- Create task table
CREATE TABLE IF NOT EXISTS task (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    description TEXT NOT NULL,
    urgency_id INTEGER NOT NULL,
    start_date DATE NOT NULL,
    status TEXT GENERATED ALWAYS AS (NULL) VIRTUAL,
    tag_id INTEGER NOT NULL,
    FOREIGN KEY (urgency_id) REFERENCES urgency (id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- Create assignee table
CREATE TABLE IF NOT EXISTS assignee (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT NOT NULL,
    email TEXT NOT NULL
);

-- Create project table
CREATE TABLE IF NOT EXISTS project (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    assignee_id INTEGER NOT NULL,
    name TEXT NOT NULL,
    begin_date DATE NOT NULL,
    FOREIGN KEY (assignee_id) REFERENCES assignee (id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- Create project_has_task table
CREATE TABLE IF NOT EXISTS project_has_task (
    project_id INTEGER NOT NULL,
    task_id INTEGER NOT NULL,
    FOREIGN KEY (task_id) REFERENCES task (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (project_id) REFERENCES project (id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- Create tag table
CREATE TABLE IF NOT EXISTS tag (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    color TEXT NOT NULL
);

-- Create task_has_tag table
CREATE TABLE IF NOT EXISTS task_has_tag (
    task_id INTEGER NOT NULL,
    tag_id INTEGER NOT NULL,
    FOREIGN KEY (task_id) REFERENCES task (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (tag_id) REFERENCES tag (id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

