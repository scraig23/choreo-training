import ballerina/http;

# A service representing a network-accessible API
# bound to port `9090`.
service / on new http:Listener(9090) {

    # A resource for generating greetings
    # + name - name as a string or nil
    # + return - string name with hello message or error
    resource function get greeting(string? name) returns string|error {
        // Send a response back to the caller.
        if name is () {
            return error("name should not be empty!");
        }
        return string `Hello, ${name}`;
    }
    # A resource for transforming a contact record in salesforce
    # + salesforceContact - the input contacts
    # + return - transformed contacts or error
    resource function post contact(@http:Payload SalesforceContact
    salesforceContact) returns Contact|error? {
    Contact contact = transform(salesforceContact);
    return contacts;
    }
}

type SalesforceContact record {
    record {
        string 'type;
        string url;
    } attributes;
    string Id;
    string FirstName;
    string LastName;
    string Email;
    string Phone;
};

type Contact record {
    string fullName;
    string phoneNumber;
    string email;
    string id;
};

function transform(SalesforceContact salesforceContact) returns Contact => {
    email: salesforceContact.Email,
    phoneNumber: salesforceContact.Phone,
    fullName: salesforceContact.FirstName + salesforceContact.LastName,
    id: salesforceContact.Id
};
