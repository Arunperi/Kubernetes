const express = require('express');
const { Pool } = require('pg');

const app = express();
const port = Number(process.env.PORT || 4000);
const databaseUrl = process.env.DATABASE_URL;

if (!databaseUrl) {
  throw new Error('DATABASE_URL is required');
}

const pool = new Pool({
  connectionString: databaseUrl,
});

app.use(express.json());

const schemaSql = `
  CREATE TABLE IF NOT EXISTS todos (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
  );
`;

function delay(milliseconds) {
  return new Promise((resolve) => setTimeout(resolve, milliseconds));
}

async function waitForDatabase() {
  const maxAttempts = 30;

  for (let attempt = 1; attempt <= maxAttempts; attempt += 1) {
    try {
      const client = await pool.connect();
      client.release();
      return;
    } catch (error) {
      if (attempt === maxAttempts) {
        throw error;
      }

      await delay(2000);
    }
  }
}

async function ensureSchema() {
  await pool.query(schemaSql);
}

app.get('/api/health', (request, response) => {
  response.json({ ok: true });
});

app.get('/api/todos', async (request, response) => {
  try {
    const result = await pool.query('SELECT id, title, created_at FROM todos ORDER BY created_at DESC, id DESC');
    response.json(result.rows);
  } catch (error) {
    console.error('Failed to load todos', error);
    response.status(500).json({ error: 'Failed to load todos' });
  }
});

app.post('/api/todos', async (request, response) => {
  const title = String(request.body?.title || '').trim();

  if (!title) {
    response.status(400).json({ error: 'Title is required' });
    return;
  }

  try {
    const result = await pool.query(
      'INSERT INTO todos (title) VALUES ($1) RETURNING id, title, created_at',
      [title]
    );

    response.status(201).json(result.rows[0]);
  } catch (error) {
    console.error('Failed to create todo', error);
    response.status(500).json({ error: 'Failed to create todo' });
  }
});

app.delete('/api/todos/:id', async (request, response) => {
  const id = Number.parseInt(request.params.id, 10);

  if (!Number.isInteger(id)) {
    response.status(400).json({ error: 'Invalid todo id' });
    return;
  }

  try {
    const result = await pool.query('DELETE FROM todos WHERE id = $1 RETURNING id', [id]);

    if (result.rowCount === 0) {
      response.status(404).json({ error: 'Todo not found' });
      return;
    }

    response.status(204).send();
  } catch (error) {
    console.error('Failed to delete todo', error);
    response.status(500).json({ error: 'Failed to delete todo' });
  }
});

async function start() {
  await waitForDatabase();
  await ensureSchema();

  app.listen(port, () => {
    console.log(`Backend listening on port ${port}`);
  });
}

start().catch((error) => {
  console.error('Unable to start backend', error);
  process.exit(1);
});
