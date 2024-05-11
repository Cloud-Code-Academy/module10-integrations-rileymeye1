/**
 * @description       : 
 * @author            : Riley Meyer
 * @group             : 
 * @last modified on  : 05-11-2024
 * @last modified by  : Riley Meyer
**/
public with sharing class ContactTriggerHandler extends TriggerHandler {
    private Map<Id, Contact> newConMap;
    private Map<Id, Contact> oldConMap;
    private List<Contact> newCons;
    private List<Contact> oldCons;

    public ContactTriggerHandler() {
        System.debug('ContactTrigger:::' + Trigger.operationType);
        this.newConMap = (Map<Id, Contact>) Trigger.newMap;
        this.oldConMap = (Map<Id, Contact>) Trigger.oldMap;
        this.newCons = (List<Contact>) Trigger.new;
        this.oldCons = (List<Contact>) Trigger.old;
    }

    public override void beforeInsert() {
        ContactHelper.beforeInsert(newCons);
    }

    public override void beforeUpdate() {
        ContactHelper.postCreateDummyJSONUser(newCons);
    }
}