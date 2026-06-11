DEFINE INDEX source_notebook_idx ON source FIELDS notebook_id;
DEFINE INDEX chunk_source_idx ON source_chunk FIELDS source_id;
DEFINE INDEX note_notebook_idx ON note FIELDS notebook_id;
DEFINE INDEX message_session_idx ON message FIELDS chat_session_id;