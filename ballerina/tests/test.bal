// Copyright (c) 2026, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;
import ballerina/os;
import ballerina/test;

final boolean isLiveServer = os:getEnv("IS_LIVE_SERVER") == "true";
final string serviceUrl = isLiveServer ? "https://unify.apideck.com/lead" : "http://localhost:9090/lead";
final string apiKey = isLiveServer ? "Bearer " + os:getEnv("APIDECK_API_KEY") : "Bearer test_api_key";
final string appId = isLiveServer ? os:getEnv("APIDECK_APP_ID") : "test_app_id";
final string consumerId = isLiveServer ? os:getEnv("APIDECK_CONSUMER_ID") : "test_consumer_id";

final Client apideck = check new ({httpVersion: http:HTTP_1_1}, serviceUrl);

@test:Config {groups: ["live_tests", "mock_tests"]}
function testListLeads() returns error? {
    GetLeadsResponse response = check apideck->listLeads({authorization: apiKey, xApideckConsumerId: consumerId, xApideckAppId: appId});
    test:assertEquals(response.statusCode, 200);
    test:assertTrue(response.data.length() > 0);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testGetLead() returns error? {
    string id = "lead_001";
    if isLiveServer {
        CreateLeadResponse created = check apideck->createLead({authorization: apiKey, xApideckConsumerId: consumerId, xApideckAppId: appId}, {name: "Get Target"});
        id = created.data.id;
    }
    GetLeadResponse response = check apideck->getLead(id, {authorization: apiKey, xApideckConsumerId: consumerId, xApideckAppId: appId});
    test:assertEquals(response.statusCode, 200);
    test:assertEquals(response.data.id, id);
    if isLiveServer {
        _ = check apideck->deleteLead(id, {authorization: apiKey, xApideckConsumerId: consumerId, xApideckAppId: appId});
    }
}

@test:Config {groups: ["mock_tests"]}
function testGetLeadNotFound() returns error? {
    GetLeadResponse|error response = apideck->getLead("missing", {authorization: apiKey, xApideckConsumerId: consumerId, xApideckAppId: appId});
    test:assertTrue(response is error);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testCreateLead() returns error? {
    CreateLeadResponse response = check apideck->createLead({authorization: apiKey, xApideckConsumerId: consumerId, xApideckAppId: appId}, {
        name: "Ada Lovelace",
        firstName: "Ada",
        lastName: "Lovelace",
        companyName: "Analytical Engines",
        emails: [{email: "ada@example.com", 'type: "work"}]
    });
    test:assertTrue(response.data.id != "");
    if isLiveServer {
        _ = check apideck->deleteLead(response.data.id, {authorization: apiKey, xApideckConsumerId: consumerId, xApideckAppId: appId});
    }
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testUpdateLead() returns error? {
    string id = "lead_001";
    if isLiveServer {
        CreateLeadResponse created = check apideck->createLead({authorization: apiKey, xApideckConsumerId: consumerId, xApideckAppId: appId}, {name: "Update Target"});
        id = created.data.id;
    }
    UpdateLeadResponse response = check apideck->updateLead(id, {authorization: apiKey, xApideckConsumerId: consumerId, xApideckAppId: appId}, {name: "Updated Name", title: "Director"});
    test:assertEquals(response.data.id, id);
    if isLiveServer {
        _ = check apideck->deleteLead(id, {authorization: apiKey, xApideckConsumerId: consumerId, xApideckAppId: appId});
    }
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testDeleteLead() returns error? {
    string id = "lead_002";
    if isLiveServer {
        CreateLeadResponse created = check apideck->createLead({authorization: apiKey, xApideckConsumerId: consumerId, xApideckAppId: appId}, {name: "Delete Target"});
        id = created.data.id;
    }
    DeleteLeadResponse response = check apideck->deleteLead(id, {authorization: apiKey, xApideckConsumerId: consumerId, xApideckAppId: appId});
    test:assertEquals(response.data.id, id);
}
