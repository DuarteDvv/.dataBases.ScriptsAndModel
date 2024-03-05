-- Consultas Simples

-- 1. Selecionar todas as tarefas com sua descrição e urgência
SELECT 
  t.description, 
  u.urgency
FROM 
  task AS t
JOIN 
  urgency AS u ON t.urgency_id = u.id;

-- 2. Contar o número de tarefas em cada projeto
SELECT 
  p.name, 
  COUNT(pt.task_id) AS task_count
FROM 
  project AS p
LEFT JOIN 
  project_has_task AS pt ON p.id = pt.project_id
GROUP BY 
  p.name;

-- Consultas Complexas

-- 3. Selecionar todas as tarefas com suas tags e ordenar por urgência
SELECT  
  t.description, 
  u.urgency, 
  GROUP_CONCAT(tag.name) AS tags
FROM 
  task AS t
JOIN 
  urgency AS u ON t.urgency_id = u.id
LEFT JOIN 
  task_has_tag AS tt ON t.id = tt.task_id
LEFT JOIN 
  tag ON tt.tag_id = tag.id
GROUP BY 
  t.id
ORDER BY 
  u.urgency;

-- 4. Calcular a média de urgência das tarefas em cada projeto
SELECT 
  p.name, 
  AVG(u.urgency) AS average_urgency
FROM 
  project AS p
LEFT JOIN 
  project_has_task AS pt ON p.id = pt.project_id
LEFT JOIN 
  task AS t ON pt.task_id = t.id
LEFT JOIN u
  rgency AS u ON t.urgency_id = u.id
GROUP BY 
  p.name;

-- 5. Selecionar os projetos com mais tarefas concluídas
SELECT 
  p.name, 
  COUNT(pt.task_id) AS completed_tasks
FROM 
  project AS p
LEFT JOIN 
  project_has_task AS pt ON p.id = pt.project_id
LEFT JOIN 
  task AS t ON pt.task_id = t.id
WHERE 
  t.status = 'Concluída'
GROUP BY 
  p.name
ORDER BY 
  completed_tasks DESC
LIMIT 5;
