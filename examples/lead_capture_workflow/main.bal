import ballerina/io;
import ballerinax/apideck.lead;

configurable string apiKey = ?;
configurable string appId = ?;
configurable string consumerId = ?;
configurable string leadName = ?;
configurable string leadEmail = ?;
configurable string leadCompany = ?;

// Captures a new lead, reads it back and moves it to the "Contacted" status.
public function main() returns error? {
    lead:Client apideck = check new ();
    string authorization = "Bearer " + apiKey;

    lead:CreateLeadResponse created = check apideck->createLead(
        {authorization, xApideckAppId: appId, xApideckConsumerId: consumerId},
        {name: leadName, companyName: leadCompany, status: "New", emails: [{email: leadEmail, 'type: "work"}]}
    );
    string leadId = created.data.id;
    io:println("Created lead: ", leadId);

    lead:GetLeadResponse fetched = check apideck->getLead(
        leadId, {authorization, xApideckAppId: appId, xApideckConsumerId: consumerId});
    io:println("Lead status: ", fetched.data?.status ?: "unknown");

    lead:UpdateLeadResponse updated = check apideck->updateLead(
        leadId, {authorization, xApideckAppId: appId, xApideckConsumerId: consumerId},
        {name: leadName, status: "Contacted"});
    io:println("Updated lead: ", updated.data.id);
}
