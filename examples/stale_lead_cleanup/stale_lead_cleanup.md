# Stale lead cleanup

This example lists leads from the connected CRM and picks out the ones in a stale status. By default it only prints the leads it would delete; set `deleteLeads = true` to delete them with `deleteLead`. It uses `listLeads` and `deleteLead`.

## Prerequisites

- Ballerina Swan Lake 2201.12.0 or later
- An Apideck Unify application, an API key and a consumer with an activated CRM integration
- Create a `Config.toml` in this directory:
  ```toml
  apiKey = "<API key>"
  appId = "<Application ID>"
  consumerId = "<Consumer ID>"
  staleStatus = "Lost"
  deleteLeads = false
  ```

## Run the example

```bash
bal run
```
