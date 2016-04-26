#!/usr/bin/env sh

dropdb westeros
createdb westeros
psql westeros < westeros.sql
