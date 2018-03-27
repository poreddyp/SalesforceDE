/*
 * Created by Prab Poreddy.
 */
public class SalesforceServerStatus_Controller {

	// Lazy loading for getSubscriptions
	public List<SalesforceServerStatus__c> subscriptions {
		get{
			if(subscriptions == null ){
				subscriptions = [SELECT Id, Name, User__r.Name, Email__c, Servers__c FROM SalesforceServerStatus__c];
			}
			return subscriptions;
		}
		set;
	}
	public SalesforceServerStatus__c newSubscription {get;set;} //instance variable for capturing new subscription input

	//	Constructor
	public SalesforceServerStatus_Controller(){
		newSubscription = new SalesforceServerStatus__c();
	}

	// Check for duplicate email subcriptions and then add a new one
	public PageReference addSubscription(){
		Map<String,String> existingEmails = new Map<String, String>();
		for(SalesforceServerStatus__c subscription: subscriptions){
			existingEmails.put(subscription.Email__c, subscription.Name);
		}
		newSubscription.Name = this.newSubscription.Name;
		newSubscription.Email__c = this.newSubscription.Email__c;
		newSubscription.Servers__c = this.newSubscription.Servers__c;
		if(existingEmails.keySet().contains(newSubscription.Email__c)){
			ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.WARNING, newSubscription.Email__c+ ' is already subscribed for notifications. Please edit the existing subscription');
			ApexPages.addMessage(msg);
			return null;
		} else{
			try{
				Database.insert(newSubscription);
				ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.CONFIRM, 'New subscription has been added');
				ApexPages.addMessage(msg);

			} catch (System.Exception e){
				System.debug('Unable to add new subscription because:' + e);
				ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.WARNING, 'Unable to add new subscription because:' + e);
				ApexPages.addMessage(msg);
				return null;
			}
			PageReference nextPage = new PageReference ('/apex/SalesforceServerStatus_VF');
			nextPage.setRedirect(true);
			return nextPage;
		}

	}

	// Time permitting, use this for Visualforce Remoting
	@RemoteAction
	public static List<SalesforceServerStatus__c> getSubscriptions(){
		return getSubscriptions();
	}

	// Time permitting, use this for Visualforce Remoting
	@RemoteAction
	public static boolean addSubscription(String name, String email, String servers){
		Boolean result;
		if (name != null&& email != null && servers != null){
			SalesforceServerStatus__c newSubscription = new SalesforceServerStatus__c();
			newSubscription.Name = name;
			newSubscription.Email__c = email;
			newSubscription.Servers__c = servers;
			try{
				Database.insert(newSubscription);
				ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.CONFIRM, 'New subscription has been added');
				ApexPages.addMessage(msg);
				result = true;

			} catch (System.Exception e){
				System.debug('Unable to add new subscription because:' + e);
				ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.WARNING, 'Unable to add new subscription because:' + e);
				ApexPages.addMessage(msg);
				result = false;
			}
			return result;
		}
		else{
			System.debug('Unable to add new subscription because of invalid input');
			ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.WARNING, 'Unable to add new subscription because of invalid input');
			ApexPages.addMessage(msg);
			return result;
		}
	}

}