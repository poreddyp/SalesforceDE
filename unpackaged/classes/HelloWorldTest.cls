@IsTest
private class HelloWorldTest {
	@IsTest static void updateLead(){
		Lead l = new Lead();
		l.FirstName = 'Hello';
		l.LastName = 'World';
		l.Company = 'Google';
		insert l;
		l.Company = 'Salesforce';
		update l;
	}
}