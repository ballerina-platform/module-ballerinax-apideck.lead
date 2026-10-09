# Ballerina Apideck Lead connector

[![Build](https://github.com/ballerina-platform/module-ballerinax-apideck.lead/actions/workflows/ci.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-apideck.lead/actions/workflows/ci.yml)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/ballerina-platform/module-ballerinax-apideck.lead.svg)](https://github.com/ballerina-platform/module-ballerinax-apideck.lead/commits/main)
[![GitHub Issues](https://img.shields.io/github/issues/ballerina-platform/ballerina-library/module/apideck.lead.svg?label=Open%20Issues)](https://github.com/ballerina-platform/ballerina-library/labels/module%2Fapideck.lead)

## Overview

[Apideck](https://www.apideck.com/) is a unified API platform that lets applications integrate with many third-party business systems through one consistent data model. Its Lead API exposes sales leads from the connected CRM systems of your customers, so the same calls work whichever CRM they use.

The Apideck Lead connector gives Ballerina programs typed access to version 10.63.0 of the Apideck Lead API, so you can create, read, update, delete and list leads across the CRM integrations that Apideck Unify supports.

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

- [lead_capture_workflow](examples/lead_capture_workflow/lead_capture_workflow.md) - Capture a new lead, read it back and move it to the Contacted status.
- [stale_lead_cleanup](examples/stale_lead_cleanup/stale_lead_cleanup.md) - List leads and remove those in a stale status, with a dry-run by default.

## Build from the source

### Setting up the prerequisites

1. Download and install Java SE Development Kit (JDK) version 21. You can download it from either of the following sources:

    * [Oracle JDK](https://www.oracle.com/java/technologies/downloads/)
    * [OpenJDK](https://adoptium.net/)

   > **Note:** After installation, remember to set the `JAVA_HOME` environment variable to the directory where JDK was installed.

2. Download and install [Ballerina Swan Lake](https://ballerina.io/).

3. Download and install [Docker](https://www.docker.com/get-started).

   > **Note**: Ensure that the Docker daemon is running before executing any tests.

4. Export Github Personal access token with read package permissions as follows,

    ```bash
    export packageUser=<Username>
    export packagePAT=<Personal access token>
    ```

### Build options

Execute the commands below to build from the source.

1. To build the package:

   ```bash
   ./gradlew clean build
   ```

2. To run the tests:

   ```bash
   ./gradlew clean test
   ```

3. To build the without the tests:

   ```bash
   ./gradlew clean build -x test
   ```

4. To run tests against different environments:

   ```bash
   ./gradlew clean test -Pgroups=<Comma separated groups/test cases>
   ```

5. To debug the package with a remote debugger:

   ```bash
   ./gradlew clean build -Pdebug=<port>
   ```

6. To debug with the Ballerina language:

   ```bash
   ./gradlew clean build -PbalJavaDebug=<port>
   ```

7. Publish the generated artifacts to the local Ballerina Central repository:

    ```bash
    ./gradlew clean build -PpublishToLocalCentral=true
    ```

8. Publish the generated artifacts to the Ballerina Central repository:

   ```bash
   ./gradlew clean build -PpublishToCentral=true
   ```

## Contribute to Ballerina

As an open-source project, Ballerina welcomes contributions from the community.

For more information, go to the [contribution guidelines](https://github.com/ballerina-platform/ballerina-lang/blob/master/CONTRIBUTING.md).

## Code of conduct

All the contributors are encouraged to read the [Ballerina Code of Conduct](https://ballerina.io/code-of-conduct).

## Useful links

* For more information go to the [`apideck.lead` package](https://central.ballerina.io/ballerinax/apideck.lead/latest).
* For example demonstrations of the usage, go to [Ballerina By Examples](https://ballerina.io/learn/by-example/).
* Chat live with us via our [Discord server](https://discord.gg/ballerinalang).
* Post all technical questions on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.
