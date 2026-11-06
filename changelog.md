# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed

- Regenerated the connector from the Apideck Lead OpenAPI specification (version 10.63.0), exposing `listLeads`, `createLead`, `getLead`, `updateLead` and `deleteLead` as remote methods.
- The `Authorization`, `x-apideck-app-id` and `x-apideck-consumer-id` headers are now passed in each operation's headers record instead of through an API key configuration on the client.
