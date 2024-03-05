-- Inserir dados na tabela urgency
INSERT INTO urgency (urgency) VALUES
    ('High'),
    ('Medium'),
    ('Low');

-- Inserir dados na tabela assignee
INSERT INTO assignee (username, email) VALUES
    ('user1', 'user1@example.com'),
    ('user2', 'user2@example.com');

-- Inserir dados na tabela project
INSERT INTO project (assignee_id, name, begin_date) VALUES
    (1, 'Project A', '2024-02-14'),
    (2, 'Project B', '2024-02-15');

-- Inserir dados na tabela tag
INSERT INTO tag (name, color) VALUES
    ('Tag1', 'Red'),
    ('Tag2', 'Blue');

-- Inserir dados na tabela task
INSERT INTO task (description, urgency_id, start_date, tag_id) VALUES
    ('Task 1', 1, '2024-02-14', 1),
    ('Task 2', 2, '2024-02-15', 2);

-- Inserir dados na tabela project_has_task
INSERT INTO project_has_task (project_id, task_id) VALUES
    (1, 1),
    (2, 2);

-- Inserir dados na tabela task_has_tag
INSERT INTO task_has_tag (task_id, tag_id) VALUES
    (1, 1),
    (2, 2);
