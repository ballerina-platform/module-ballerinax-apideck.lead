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

listener http:Listener ep0 = new (9090);

final readonly & Lead[] seedLeads = [
    {
        id: "lead_001",
        name: "Elon Musk",
        firstName: "Elon",
        lastName: "Musk",
        companyName: "Spacex",
        title: "CEO",
        description: "Interested in a long-term enterprise contract.",
        leadSource: "Cold Call",
        status: "New",
        monetaryAmount: 75000.0d,
        currency: "USD",
        ownerId: "54321",
        ownerName: "Jane Doe",
        emails: [{id: "em_1", email: "elon@spacex.com", 'type: "primary"}],
        phoneNumbers: [{id: "ph_1", number: "111-111-1111", 'type: "mobile"}],
        websites: [{id: "web_1", url: "https://www.spacex.com", 'type: "work"}],
        addresses: [{id: "addr_1", 'type: "office", line1: "1 Rocket Road", city: "Hawthorne", state: "CA", postalCode: "90250", country: "US"}],
        createdAt: "2024-03-01T10:15:30.000Z",
        updatedAt: "2024-03-05T08:00:00.000Z"
    },
    {
        id: "lead_002",
        name: "Grace Hopper",
        firstName: "Grace",
        lastName: "Hopper",
        companyName: "Navy Labs",
        title: "Rear Admiral",
        leadSource: "Web",
        status: "Open",
        monetaryAmount: 12000.5d,
        currency: "USD",
        emails: [{id: "em_2", email: "grace@navylabs.example", 'type: "work"}],
        createdAt: "2024-04-11T09:00:00.000Z",
        updatedAt: "2024-04-12T14:30:00.000Z"
    }
];

service /lead on ep0 {

    # List leads
    #
    # + authorization - Bearer API key sent in the Authorization header
    # + xApideckConsumerId - ID of the consumer which you want to get or push data from
    # + xApideckAppId - The ID of your Unify application
    # + xApideckServiceId - Provide the service id you want to call (e.g., pipedrive). Only needed when a consumer has activated multiple integrations for a Unified API
    # + cursor - Cursor to start from
    # + filter - Apply filters
    # + sort - Apply sorting
    # + fields - Comma-separated list of fields to include in the response
    # + raw - Include raw response. Mostly used for debugging purposes
    # + 'limit - Number of results to return. Minimum 1, Maximum 200, Default 20
    # + return - The list of leads, or an error response
    resource function get leads(@http:Header {name: "Authorization"} string authorization, @http:Header {name: "x-apideck-consumer-id"} string xApideckConsumerId, @http:Header {name: "x-apideck-app-id"} string xApideckAppId, @http:Header {name: "x-apideck-service-id"} string? xApideckServiceId, string? cursor, LeadsFilter? filter, LeadsSort? sort, string? fields, boolean raw = false, int 'limit = 20) returns GetLeadsResponse|http:Unauthorized {
        if xApideckAppId == "" {
            return <http:Unauthorized>{body: {statusCode: 401, 'error: "Unauthorized", message: "Missing application id"}};
        }
        return {
            statusCode: 200,
            status: "OK",
            'service: "salesforce",
            'resource: "Leads",
            operation: "all",
            data: seedLeads.clone(),
            meta: {itemsOnPage: 2, cursors: {current: "em9oby1jdXJzb3I=", next: (), previous: ()}}
        };
    }

    # Create lead
    #
    # + authorization - Bearer API key sent in the Authorization header
    # + xApideckConsumerId - ID of the consumer which you want to get or push data from
    # + xApideckAppId - The ID of your Unify application
    # + xApideckServiceId - Provide the service id you want to call (e.g., pipedrive). Only needed when a consumer has activated multiple integrations for a Unified API
    # + payload - Details of the lead to create
    # + raw - Include raw response. Mostly used for debugging purposes
    # + return - The created lead reference, or an error response
    resource function post leads(@http:Header {name: "Authorization"} string authorization, @http:Header {name: "x-apideck-consumer-id"} string xApideckConsumerId, @http:Header {name: "x-apideck-app-id"} string xApideckAppId, @http:Header {name: "x-apideck-service-id"} string? xApideckServiceId, @http:Payload Lead payload, boolean raw = false) returns CreateLeadResponse|http:Unauthorized {
        if xApideckAppId == "" {
            return <http:Unauthorized>{body: {statusCode: 401, 'error: "Unauthorized", message: "Missing application id"}};
        }
        return {
            statusCode: 201,
            status: "Created",
            'service: "salesforce",
            'resource: "Leads",
            operation: "add",
            data: {id: "lead_003"}
        };
    }

    # Get lead
    #
    # + id - ID of the record you are acting upon
    # + authorization - Bearer API key sent in the Authorization header
    # + xApideckConsumerId - ID of the consumer which you want to get or push data from
    # + xApideckAppId - The ID of your Unify application
    # + xApideckServiceId - Provide the service id you want to call (e.g., pipedrive). Only needed when a consumer has activated multiple integrations for a Unified API
    # + fields - Comma-separated list of fields to include in the response
    # + raw - Include raw response. Mostly used for debugging purposes
    # + return - The requested lead, or an error response
    resource function get leads/[string id](@http:Header {name: "Authorization"} string authorization, @http:Header {name: "x-apideck-consumer-id"} string xApideckConsumerId, @http:Header {name: "x-apideck-app-id"} string xApideckAppId, @http:Header {name: "x-apideck-service-id"} string? xApideckServiceId, string? fields, boolean raw = false) returns GetLeadResponse|http:NotFound {
        foreach Lead lead in seedLeads {
            if lead.id == id {
                return {
                    statusCode: 200,
                    status: "OK",
                    'service: "salesforce",
                    'resource: "Leads",
                    operation: "one",
                    data: lead.clone()
                };
            }
        }
        return <http:NotFound>{body: {statusCode: 404, 'error: "Not Found", message: "The specified resource was not found", detail: "Lead " + id + " does not exist"}};
    }

    # Update lead
    #
    # + id - ID of the record you are acting upon
    # + authorization - Bearer API key sent in the Authorization header
    # + xApideckConsumerId - ID of the consumer which you want to get or push data from
    # + xApideckAppId - The ID of your Unify application
    # + xApideckServiceId - Provide the service id you want to call (e.g., pipedrive). Only needed when a consumer has activated multiple integrations for a Unified API
    # + payload - Lead fields to update
    # + raw - Include raw response. Mostly used for debugging purposes
    # + return - The updated lead reference, or an error response
    resource function patch leads/[string id](@http:Header {name: "Authorization"} string authorization, @http:Header {name: "x-apideck-consumer-id"} string xApideckConsumerId, @http:Header {name: "x-apideck-app-id"} string xApideckAppId, @http:Header {name: "x-apideck-service-id"} string? xApideckServiceId, @http:Payload Lead payload, boolean raw = false) returns UpdateLeadResponse|http:NotFound {
        foreach Lead lead in seedLeads {
            if lead.id == id {
                return {
                    statusCode: 200,
                    status: "OK",
                    'service: "salesforce",
                    'resource: "Leads",
                    operation: "update",
                    data: {id: id}
                };
            }
        }
        return <http:NotFound>{body: {statusCode: 404, 'error: "Not Found", message: "The specified resource was not found", detail: "Lead " + id + " does not exist"}};
    }

    # Delete lead
    #
    # + id - ID of the record you are acting upon
    # + authorization - Bearer API key sent in the Authorization header
    # + xApideckConsumerId - ID of the consumer which you want to get or push data from
    # + xApideckAppId - The ID of your Unify application
    # + xApideckServiceId - Provide the service id you want to call (e.g., pipedrive). Only needed when a consumer has activated multiple integrations for a Unified API
    # + raw - Include raw response. Mostly used for debugging purposes
    # + return - The deleted lead reference, or an error response
    resource function delete leads/[string id](@http:Header {name: "Authorization"} string authorization, @http:Header {name: "x-apideck-consumer-id"} string xApideckConsumerId, @http:Header {name: "x-apideck-app-id"} string xApideckAppId, @http:Header {name: "x-apideck-service-id"} string? xApideckServiceId, boolean raw = false) returns DeleteLeadResponse|http:NotFound {
        if id == "missing" {
            return <http:NotFound>{body: {statusCode: 404, 'error: "Not Found", message: "The specified resource was not found", detail: "Lead " + id + " does not exist"}};
        }
        return {
            statusCode: 200,
            status: "OK",
            'service: "salesforce",
            'resource: "Leads",
            operation: "delete",
            data: {id: id}
        };
    }
}
