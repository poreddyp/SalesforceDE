/*
 * Created by Prab Poreddy.
 */

public class SalesforceServerStatus{
	public static List<SalesforceServerLog__c> newLog {get;set;} //Salesforce server statuses from current run that will be saved to sObject
	public static Map<String, String> reconciledLog {get;set;} // Map that captures server names when their previous and current statuses do not match.
	public static Map<String, String> createEmailBody {get;set;} // Map that will hold email body content specific to each recipient email ID

	//  Only public method in this class
	@Future (callout = true)
	public static void checkStatus() {
		Map<String, String> oldMap = new Map<String, String>(); // Using Map makes it easy to compare against snapshot of similar data
		Map<String, String> newMap = new Map<String, String>();
		newLog = new List<SalesforceServerLog__c>();
		reconciledLog = new Map<String, String>();
		Datetime logTime = System.now(); // to append timestamp to log when saving to sObject

		// Alternative to specifying the URL here is to use 'Named Credential' feature, especially when there is secure authentication involved
		HttpRequest req = new HttpRequest();
		req.setEndpoint('https://api.status.salesforce.com/v1/instances');
		req.setMethod('GET');

		Http http = new Http();
		HTTPResponse res = http.send(req);
		if(res.getStatusCode() == 200){
			String response = res.getBody();
			// Use JSON2Apex class to cast JSON response into Apex object so specific values can be accessed.
			List<JSON2Apex> jResponse = (List<JSON2Apex>)JSON.deserialize(response, List<JSON2Apex>.class);

			//If the response from API is blank, register this to debug log and stop further processing
			if (jResponse.size() > 0) {
				//Salesforce server statuses persisted in sObject from previous run
				List<SalesforceServerLog__c> previousLog = [SELECT ServerName__c, ServerStatus__c, LogTime__c FROM SalesforceServerLog__c];
				for (Integer i = 0; i < previousLog.size(); i++) {
					oldMap.put(previousLog[i].ServerName__c, previousLog[i].ServerStatus__c);
				}
				for (Integer i = 0; i < jResponse.size(); i++) {
					SalesforceServerLog__c newLogEntry = new SalesforceServerLog__c();
					newMap.put(jResponse[i].key, jResponse[i].status);
					newLogEntry.ServerName__c = jResponse[i].key;
					newLogEntry.ServerStatus__c = jResponse[i].status;
					newLogEntry.LogTime__c = logTime;
					addnewLog(newLogEntry); // calling a separate method so the list elements do not get duplicated
				}

				System.debug('oldMap is: ' + oldMap);
				System.debug('newMap is: ' + newMap);

				// Comparing the status of each server between old and new logs and capturing differences
				for (String fieldName: newMap.keySet()){
					if(oldMap.get(fieldName) != newMap.get(fieldName)){
						reconciledLog.put(fieldName, oldMap.get(fieldName) + ' to ' + newMap.get(fieldName));
					}
				}
				System.debug('reconciledLog is: '+ reconciledLog);
				delete previousLog;
				insert newLog;
				checkAgainstProfiles();
			} else{
				System.debug('HTTP request to Salesforce API came back with empty response due to:' + res.getStatus() + 'in SalesforceServerStatus class');
			}

		}else{
			System.debug('HTTP request to Salesforce API failed due to: ' + res.getStatus() + ' HTTP status in SalesforceServerStatus class');
		}

	}

	private static void addnewLog(SalesforceServerLog__c l){
		newLog.add(l);
	}

	private static void checkAgainstProfiles() {
		createEmailBody = new Map<String, String>();
		// List of users, emails and salesforce servers they are subscribed to
		List<SalesforceServerStatus__c> subscriptions = [SELECT Id, Name, User__r.Name, Email__c, Servers__c FROM SalesforceServerStatus__c];
		for (SalesforceServerStatus__c user : subscriptions) {
			String toEmail = user.Email__c;
			String emailBody = '';
			for (String server : user.Servers__c.split(';')) {
				if(reconciledLog.keySet().contains(server)){
				emailBody+=  server + ' server status changed from ' + reconciledLog.get(server)+'<P>';
				}
			}
			createEmailBody.put(toEmail,emailBody);
		}
		System.debug('createEmailBody is:'+ createEmailBody);
		sendEmails();
	}

	private static void sendEmails(){
		List<Messaging.Email> emailsToSend = new List<Messaging.Email>();
		for(String email: createEmailBody.keySet()){
			// To prevent blank emails from going out, check for valid emailBody content from the Map
			if (createEmailBody.get(email) != ''){
				System.debug('email is sent to:'+ email + ' with email body: '+ createEmailBody.get(email));
				Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
				mail.setReplyTo('support@prab.com');
				mail.setSenderDisplayName('Prab from Salesforce Sandbox');
				mail.setSubject('Salesforce Servers Status Notification');
				mail.setBccSender(false);
				mail.setUseSignature(false);
				String[] toAddresses = new String[] {email};
				mail.setToAddresses(toAddresses);
				String textBody = createEmailBody.get(email);
				mail.setHtmlBody(textBody);
				emailsToSend.add(mail);
			}
		}

		if (emailsToSend.size()>0){
			System.debug(emailsToSend+ ' emails will be sent out');
			Messaging.sendEmail(emailsToSend);
		}
		else {
			System.debug('No emails to sent because server statuses did not change.');
		}

	}

}