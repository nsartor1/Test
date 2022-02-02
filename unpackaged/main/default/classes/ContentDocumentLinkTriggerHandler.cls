public with sharing class ContentDocumentLinkTriggerHandler {

    public void handleAfterInsert( contentdocumentlink cdl) {
			//system.debug('here linked '+cdl.LinkedEntityId);
        	string id = cdl.LinkedEntityId;
        	list<contentdocumentlink> nl = new list<contentdocumentlink>();
        	list<WorkOrder> wo; 
        try{
        	 wo = [select id from workorder where opportunity__c =: id];
        }catch(Exception ex){
            wo = null;   
        }
        if(wo.size()>0){
            for(Workorder x:wo){
                system.debug('here is xId '+ x);
            	contentdocumentlink newLink = new contentdocumentlink();
            	newLink.LinkedEntityId = x.id;
            	newLink.ContentDocumentId = cdl.ContentDocumentId;
            	newLink.ShareType = cdl.ShareType;
            	newLink.Visibility = cdl.Visibility;
            	nl.add(newLink); 
        	}
        }
        if(nl.size()>0){
            insert nl; 
        }
        
    }
}