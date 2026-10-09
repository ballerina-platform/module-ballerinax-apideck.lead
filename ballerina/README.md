## Overview

[Apideck](https://www.apideck.com/) is a unified API platform that lets applications integrate with many third-party business systems through one consistent data model. Its Lead API exposes sales leads from the connected CRM systems of your customers, so the same calls work whichever CRM they use.

The Apideck Lead connector gives Ballerina programs typed access to version 10.63.0 of the Apideck Lead API, so you can create, read, update, delete and list leads across the CRM integrations that Apideck Unify supports.

### Key features

- Create, update and delete leads in the CRM your customers use
- Read a single lead or list leads with filtering, sorting and cursor-based pagination
- Work across many CRM integrations through one unified lead data model
- Authenticate every request with an API key plus your Unify application and consumer IDs

## Setup guide

To use the connector you need an Apideck account, a Unify application and a consumer that has activated a CRM integration.

1. Sign up or log in at the [Apideck dashboard](https://app.apideck.com/).

2. Create a Unify application, or open an existing one.

3. Open the application's API keys page at [app.apideck.com/unify/api-keys](https://app.apideck.com/unify/api-keys) and copy your secret API key and your application ID.

4. Choose a consumer ID for the user or account whose CRM data you want to reach, and activate a CRM integration for that consumer in Apideck Vault.

> **Note:** Keep the secret API key out of client-side code and version control.

## Quickstart

To use the `apideck.lead` connector in your Ballerina application, update the `.bal` file as follows:

### Step 1: Import the module

```ballerina
import ballerinax/apideck.lead;
```

### Step 2: Instantiate a new connector

Create a `Config.toml` file with your credentials:

```toml
apiKey = "<API key>"
appId = "<Application ID>"
consumerId = "<Consumer ID>"
```

Then create the client in your `.bal` file:

```ballerina
configurable string apiKey = ?;
configurable string appId = ?;
configurable string consumerId = ?;

lead:Client apideck = check new ();
```

### Step 3: Invoke the connector operation

```ballerina
public function main() returns error? {
    lead:GetLeadsResponse _ = check apideck->listLeads({
        authorization: "Bearer " + apiKey,
        xApideckAppId: appId,
        xApideckConsumerId: consumerId
    });
}
```

### Step 4: Run the Ballerina application

```bash
bal run
```


## Examples

The `Apideck Lead` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-apideck.lead/tree/main/examples/), covering the following use cases:

- [lead_capture_workflow](../examples/lead_capture_workflow/lead_capture_workflow.md) - Capture a new lead, read it back and move it to the Contacted status.
- [stale_lead_cleanup](../examples/stale_lead_cleanup/stale_lead_cleanup.md) - List leads and remove those in a stale status, with a dry-run by default.
