import { useEffect, useMemo, useState } from 'react';

function formatDate(value) {
  return new Intl.DateTimeFormat('en', {
    dateStyle: 'medium',
    timeStyle: 'short',
  }).format(new Date(value));
}

export default function App() {
  const [todos, setTodos] = useState([]);
  const [title, setTitle] = useState('');
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [message, setMessage] = useState('');

  async function loadTodos() {
    setLoading(true);
    setMessage('');

    try {
      const response = await fetch('/api/todos');

      if (!response.ok) {
        throw new Error('Could not load tasks');
      }

      const data = await response.json();
      setTodos(data);
    } catch (error) {
      setMessage(error instanceof Error ? error.message : 'Could not load tasks');
    } finally {
      setLoading(false);
    }
  }

  useEffect(() => {
    loadTodos();
  }, []);

  const todoCount = useMemo(() => todos.length, [todos]);

  async function handleSubmit(event) {
    event.preventDefault();

    const nextTitle = title.trim();
    if (!nextTitle) {
      return;
    }

    setSaving(true);
    setMessage('');

    try {
      const response = await fetch('/api/todos', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ title: nextTitle }),
      });

      if (!response.ok) {
        throw new Error('Could not add task');
      }

      const createdTodo = await response.json();
      setTodos((currentTodos) => [createdTodo, ...currentTodos]);
      setTitle('');
    } catch (error) {
      setMessage(error instanceof Error ? error.message : 'Could not add task');
    } finally {
      setSaving(false);
    }
  }

  async function handleDelete(id) {
    setMessage('');

    try {
      const response = await fetch(`/api/todos/${id}`, {
        method: 'DELETE',
      });

      if (!response.ok) {
        throw new Error('Could not delete task');
      }

      setTodos((currentTodos) => currentTodos.filter((todo) => todo.id !== id));
    } catch (error) {
      setMessage(error instanceof Error ? error.message : 'Could not delete task');
    }
  }

  return (
    <main className="app-shell">
      <section className="hero-card">
        <div>
          <p className="eyebrow">Simple full-stack app</p>
          <h1>Task board with React, Express, and Postgres</h1>
          <p className="hero-copy">
            Add tasks in the browser, store them in the database, and manage everything inside Docker.
          </p>
        </div>

        <div className="stats-row">
          <div className="stat">
            <span className="stat-label">Tasks</span>
            <strong>{todoCount}</strong>
          </div>
          <div className="stat">
            <span className="stat-label">Status</span>
            <strong>Live</strong>
          </div>
        </div>
      </section>

      <section className="workspace">
        <form className="composer" onSubmit={handleSubmit}>
          <label htmlFor="todoTitle">New task</label>
          <div className="composer-row">
            <input
              id="todoTitle"
              type="text"
              value={title}
              onChange={(event) => setTitle(event.target.value)}
              placeholder="Write the next small task"
            />
            <button type="submit" disabled={saving}>
              {saving ? 'Adding...' : 'Add task'}
            </button>
          </div>
        </form>

        {message ? <div className="banner">{message}</div> : null}

        <div className="task-panel">
          <div className="panel-header">
            <h2>Tasks</h2>
            <button type="button" className="ghost-button" onClick={loadTodos} disabled={loading}>
              Refresh
            </button>
          </div>

          {loading ? (
            <p className="empty-state">Loading tasks...</p>
          ) : todos.length === 0 ? (
            <p className="empty-state">No tasks yet. Add the first one.</p>
          ) : (
            <ul className="task-list">
              {todos.map((todo) => (
                <li key={todo.id} className="task-item">
                  <div>
                    <h3>{todo.title}</h3>
                    <p>{formatDate(todo.created_at)}</p>
                  </div>
                  <button type="button" onClick={() => handleDelete(todo.id)}>
                    Delete
                  </button>
                </li>
              ))}
            </ul>
          )}
        </div>
      </section>
    </main>
  );
}
