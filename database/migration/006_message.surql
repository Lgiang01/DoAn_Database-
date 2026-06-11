DEFINE TABLE message SCHEMAFULL;

DEFINE FIELD chat_session_id ON message TYPE record<chat_session>;

DEFINE FIELD role ON message TYPE string ASSERT $value IN ["user", "assistant"];

DEFINE FIELD content ON message TYPE string;

DEFINE FIELD created_at ON message TYPE datetime DEFAULT time::now();