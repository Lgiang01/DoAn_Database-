DEFINE TABLE notebook SCHEMAFULL;

DEFINE FIELD title ON notebook TYPE string;
DEFINE FIELD description ON notebook TYPE string;
DEFINE FIELD user_id ON notebook TYPE string;

DEFINE FIELD created_at ON notebook TYPE datetime DEFAULT time::now();
DEFINE FIELD updated_at ON notebook TYPE datetime VALUE time::now();