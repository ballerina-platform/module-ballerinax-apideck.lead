import ballerina/io;
import ballerinax/apideck.lead;

configurable string apiKey = ?;
configurable string appId = ?;
configurable string consumerId = ?;
configurable string staleStatus = "Lost";
configurable boolean deleteLeads = false;

// Lists every page of leads, finds those in the stale status and optionally deletes them.
public function main() returns error? {
    lead:Client apideck = check new ();
    string authorization = "Bearer " + apiKey;

    string? cursor = ();
    while true {
        lead:GetLeadsResponse page = check apideck->listLeads(
            {authorization, xApideckAppId: appId, xApideckConsumerId: consumerId}, 'limit = 50, cursor = cursor);
        io:println("Leads fetched: ", page.data.length());

        foreach lead:Lead item in page.data {
            if item?.status != staleStatus {
                continue;
            }
            string id = item?.id ?: "";
            if id == "" {
                continue;
            }
            if !deleteLeads {
                io:println("Would delete lead: ", id);
                continue;
            }
            lead:DeleteLeadResponse deleted = check apideck->deleteLead(
                id, {authorization, xApideckAppId: appId, xApideckConsumerId: consumerId});
            io:println("Deleted lead: ", deleted.data.id);
        }

        string? next = page.meta?.cursors?.next;
        if next is () || next == "" {
            break;
        }
        cursor = next;
    }
    io:println("Done: all pages processed.");
}
