DEFINE TABLE chat_session SCHEMAFULL;

DEFINE FIELD notebook_id ON chat_session TYPE record<notebook>;

DEFINE FIELD created_at ON chat_session TYPE datetime DEFAULT time::now();