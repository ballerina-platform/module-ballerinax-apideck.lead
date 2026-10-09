# Lead capture workflow

This example captures a new lead in the connected CRM, reads it back to confirm what was stored, and then moves it to the "Contacted" status. It uses `createLead`, `getLead` and `updateLead`.

## Prerequisites

- Ballerina Swan Lake 2201.12.0 or later
- An Apideck Unify application, an API key and a consumer with an activated CRM integration
- Create a `Config.toml` in this directory:
  ```toml
  apiKey = "<API key>"
  appId = "<Application ID>"
  consumerId = "<Consumer ID>"
  leadName = "<Lead name>"
  leadEmail = "<Lead email>"
  leadCompany = "<Lead company>"
  ```

## Run the example

```bash
bal run
```
