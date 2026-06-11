DEFINE TABLE source SCHEMAFULL;

DEFINE FIELD title ON source TYPE string;
DEFINE FIELD content ON source TYPE string;

DEFINE FIELD source_type ON source TYPE string;

DEFINE FIELD status ON source TYPE string ASSERT $value IN [
  "unprocessed",
  "processed",
  "archived"
];

DEFINE FIELD notebook_id ON source TYPE record<notebook>;

DEFINE FIELD hash ON source TYPE string;

DEFINE FIELD created_at ON source TYPE datetime DEFAULT time::now();
DEFINE FIELD updated_at ON source TYPE datetime VALUE time::now();