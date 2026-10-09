# Examples

The `ballerinax/apideck.lead` connector provides practical examples illustrating usage in various scenarios.

1. [lead_capture_workflow](./lead_capture_workflow/lead_capture_workflow.md) - Capture a lead, read it back and mark it as contacted.
2. [stale_lead_cleanup](./stale_lead_cleanup/stale_lead_cleanup.md) - List leads and delete those in a stale status, with a dry run by default.

## Prerequisites

- An Apideck account with a Unify application, a secret API key and a consumer that has an activated CRM integration.
- Ballerina Swan Lake 2201.12.0 or later.
- A `Config.toml` in each example directory containing `apiKey`, `appId` and `consumerId`, as described in the example's own guide.

## Running an example

Execute the following commands to build an example from the source:

* To build an example:

    ```bash
    bal build
    ```

* To run an example:

    ```bash
    bal run
    ```

## Building the examples with the local module

**Warning**: Due to the absence of support for reading local repositories for single Ballerina files, the Bala of the module is manually written to the central repository as a workaround. Consequently, the bash script may modify your local Ballerina repositories.

Execute the following commands to build all the examples against the changes you have made to the module locally:

* To build all the examples:

    ```bash
    ./build.sh build
    ```

* To run all the examples:

    ```bash
    ./build.sh run
    ```
