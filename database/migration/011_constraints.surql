DEFINE FIELD role ON message TYPE string ASSERT $value IN ["user", "assistant"];

DEFINE FIELD status ON source TYPE string ASSERT $value IN [
  "unprocessed",
  "processed",
  "archived"
];