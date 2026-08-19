CREATE USER resource_api WITH PASSWORD 'resource_api';
CREATE DATABASE resource_api_dev OWNER resource_api;

\connect resource_api_dev

CREATE EXTENSION IF NOT EXISTS pgcrypto;
