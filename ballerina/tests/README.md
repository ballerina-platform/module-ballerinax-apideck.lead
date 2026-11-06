# Tests

The test suite exercises all five lead operations (`listLeads`, `createLead`, `getLead`, `updateLead` and `deleteLead`) against a mock Apideck service defined in `tests/mock_service.bal`. It also checks that a request for a missing lead returns an error.

## Running Tests

```bash
bal test
```

By default the tests run against the mock server and need no credentials. To run them against the real API, set these environment variables:

```bash
export IS_LIVE_SERVER=true
export APIDECK_API_KEY=<API key>
export APIDECK_APP_ID=<Application ID>
export APIDECK_CONSUMER_ID=<Consumer ID>
bal test --groups live_tests
```
