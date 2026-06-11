DEFINE TABLE source_chunk SCHEMAFULL;

DEFINE FIELD source_id ON source_chunk TYPE record<source>;
DEFINE FIELD content ON source_chunk TYPE string;
DEFINE FIELD chunk_index ON source_chunk TYPE int;

DEFINE FIELD created_at ON source_chunk TYPE datetime DEFAULT time::now();