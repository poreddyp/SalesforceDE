/**
 * Created by Prab Poreddy on 10/31/2017.
 */
@IsTest
private class WarrantySummaryTest {
	@IsTest static void generateWarrantySummary (){
		Case myCase = new Case();
		myCase.Product_Purchase_Date__c = Date.today();
		myCase.Product_Total_Warranty__c = 3;
		myCase.Product_Has_Extended_Warranty__c = false;
		insert myCase;
	}
}