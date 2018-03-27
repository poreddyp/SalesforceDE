/**
 * Created by Prab Poreddy on 10/31/2017.
 */
@IsTest
private class CheckSecretInformationTest {
	@IsTest static void	createCase(){
		Case myCase = new Case();
		myCase.Product_Purchase_Date__c = Date.today();
		myCase.Product_Total_Warranty__c = 3;
		myCase.Product_Has_Extended_Warranty__c = false;

		myCase.Subject 		= 'HELP!!!';
		myCase.Description 	= 'This description has Credit Card, Social Security and Passport.';
		insert myCase;
		System.debug('Case ' + myCase.Id + ' created with description ' + myCase.Description);
	}

}