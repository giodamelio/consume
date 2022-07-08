@_list:
  just --list

db:
  usql pg://postgres:postgres@localhost/consume_dev?sslmode=disable
