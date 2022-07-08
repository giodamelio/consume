@_list:
  just --list

go:
  mix phx.server

db:
  usql pg://postgres:postgres@localhost/consume_dev?sslmode=disable
