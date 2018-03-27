trigger WarrantySummary on Case (before insert) {
	// Using a trigger scope variable to practice variable scope inside the trigger 'for' loop
	/*String finalGreeting 			= 'Have a nice day!';

	for (Case myCase : Trigger.new){
		// defining variables so we can use them to populate warranty summary field
		String purchaseDate 		= myCase.Product_Purchase_Date__c.format();
		String caseCreatedDate 		= Datetime.now().format();
		Decimal warrantyTotalDays 	= myCase.Product_Total_Warranty__c;
		Decimal warrantyPercentage 	= (100 *(myCase.Product_Purchase_Date__c.daysBetween(Date.today())
										/ warrantyTotalDays).setScale(2));
		Boolean extendedWarranty	= myCase.Product_Has_Extended_Warranty__c;

		myCase.Warranty_Summary__c = 'Product purchased on ' + purchaseDate +
				' and case created on ' + caseCreatedDate + '.\n' +
				'Warranty is for ' + warrantyTotalDays +
				' days and is ' + warrantyPercentage + '% through its warranty period.\n' +
				'Extended warranty: ' + extendedWarranty + '\n' +
				finalGreeting + '.';

	}
/* Product purchased on <<Purchase Date>> and case created on <<Case Created Date>>.
Warranty is for <<Warranty Total Days>> days and is <<Warranty Percentage>>% through its warranty period.
Extended warranty: <<Has Extended Warranty>>
Have a nice day!

Product purchased on 4/4/2016 and case created 4/6/2016 3:15 AM.
Warranty is for 3 days and is 66.57% through its warranty period.
Extended warranty: false
Have a nice day!


*/
}