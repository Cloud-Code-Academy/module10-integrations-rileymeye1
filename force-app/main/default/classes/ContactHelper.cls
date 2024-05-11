/**
 * @description       : 
 * @author            : Riley Meyer
 * @group             : 
 * @last modified on  : 05-11-2024
 * @last modified by  : Riley Meyer
**/
public with sharing class ContactHelper {

    public static void beforeInsert(List<Contact> contactList) {
        // if DummyJSON_Id__c is null, generate a random number between 0 and 100 and set this as the contact's DummyJSON_Id__c value
		for (Contact c : contactList) {
            if (c.DummyJSON_Id__c == null) {
                c.DummyJSON_Id__c = String.valueOf(Math.round(Math.random() * 100));
            }
            if (Integer.valueOf(c.DummyJSON_Id__c) <= 100) {
                callGetDummyJSONUserFromId(c.DummyJSON_Id__c);
            }
        }
    }

    @future (callout = true)
    private static void callGetDummyJSONUserFromId(String contactId) {
        DummyJSONCallout.getDummyJSONUserFromId(contactId);
    }

    public static void postCreateDummyJSONUser(List<Contact> contactList) {
        // if DummyJSON_Id__c is greater than 100, call the postCreateDummyJSONUser API
        for (Contact c : contactList) {
            if (Integer.valueOf(c.DummyJSON_Id__c) > 100) {
                callPostCreateDummyJSONUser(String.valueOf(c.Id));
            }
        }
    }

    @future (callout = true)
    private static void callPostCreateDummyJSONUser(String contactId) {
        DummyJSONCallout.postCreateDummyJSONUser(contactId);
    }
}