_Author_:  @DimuthuMadushan \
_Created_: 2026/10/09 \
_Updated_: 2026/10/09 \
_Edition_: Swan Lake

# Sanitation for OpenAPI specification

This document records the sanitation done on top of the official OpenAPI specification from Apideck Lead. 
The OpenAPI specification is obtained from [wso2/api-specs](https://github.com/wso2/api-specs/blob/main/openapi/apideck/lead/10.63.0/openapi.yaml).
These changes are done in order to improve the overall usability, and as workarounds for some known language limitations.

1. Change the `url` property of the servers object
- **Original**: `https://unify.apideck.com`
- **Updated**: `https://unify.apideck.com/lead`
- **Reason**: Common prefix added to base URL to simplify endpoint paths.
<!-- auto-generated -->

2. Update the API Paths
- **Original**: Paths included common prefix `/lead` in each endpoint.
- **Updated**: Common prefix removed from endpoints as it is now in the base URL.
- **Reason**: Simplifies API paths and avoids duplication.
<!-- auto-generated -->

3. Change `MetaCursors next` to nullable
- **Original**: The `next` field in `MetaCursors` was `not nullable`.
- **Updated**: The `next` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

4. Change `MetaCursors current` to nullable
- **Original**: The `current` field in `MetaCursors` was `not nullable`.
- **Updated**: The `current` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

5. Change `MetaCursors previous` to nullable
- **Original**: The `previous` field in `MetaCursors` was `not nullable`.
- **Updated**: The `previous` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

6. Change `MetaWarnings status_code` to nullable
- **Original**: The `status_code` field in `MetaWarnings` was `not nullable`.
- **Updated**: The `status_code` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

7. Change `MetaWarnings error` to nullable
- **Original**: The `error` field in `MetaWarnings` was `not nullable`.
- **Updated**: The `error` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

8. Change `MetaWarnings message` to nullable
- **Original**: The `message` field in `MetaWarnings` was `not nullable`.
- **Updated**: The `message` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

9. Change `MetaWarnings operation` to nullable
- **Original**: The `operation` field in `MetaWarnings` was `not nullable`.
- **Updated**: The `operation` field has been updated to be `nullable`.
- **Reason**: The API can return a null value for this field.
<!-- auto-generated -->

10. **Simplified `info.description`**: The original description was a long Markdown developer guide covering headers, pagination, error types, API design and static IPs. It also held garbled characters, including raw C1 control characters (U+008F, U+009D) that YAML parsers reject. It was replaced with a one-sentence summary of the API, because this text becomes the generated client's documentation.

11. **Replaced the API-key security schemes with an explicit `Authorization` header parameter**: The spec declared three `apiKey` security schemes (`apiKey` as `Authorization`, `applicationId` as `x-apideck-app-id`, `consumerId` as `x-apideck-consumer-id`). The generator then built each request with `map<anydata> headerValues = {...headers}` and the API key added on top. That spread drops the `@http:Header` names, so the app-id and consumer-id headers went out as `xApideckAppId` and `xApideckConsumerId` and the API rejected them. The two ID headers were also already required header parameters on every operation. All three schemes, the top-level `security` and the per-operation `security: [apiKey]` entries were removed, and a required `Authorization` header parameter (`#/components/parameters/authorization`) was added to the five operations. The client now has no API-key configuration, and the caller passes `authorization`, `xApideckAppId` and `xApideckConsumerId` in each operation's headers record, which `http:getHeaderMap` sends under the right names. Applied to the original spec `docs/spec/openapi.yaml`.

## OpenAPI cli command

The following command was used to generate the Ballerina client from the OpenAPI specification. The command should be executed from the repository root directory.

```bash
bal openapi -i docs/spec/aligned_ballerina_openapi.json -o ballerina --mode client --client-methods remote --license docs/license.txt
```

Note: The license year is hardcoded to 2026, change if necessary.
