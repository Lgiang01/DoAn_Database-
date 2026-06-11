DEFINE TABLE note SCHEMAFULL;

DEFINE FIELD title ON note TYPE string;
DEFINE FIELD content ON note TYPE string;

DEFINE FIELD note_type ON note TYPE string;

DEFINE FIELD notebook_id ON note TYPE record<notebook>;

DEFINE FIELD source_ids ON note TYPE array<record<source>>;

DEFINE FIELD created_at ON note TYPE datetime DEFAULT time::now();
DEFINE FIELD updated_at ON note TYPE datetime VALUE time::now();