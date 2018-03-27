/**
 * Created by Prab Poreddy on 10/26/2017.
 */
@IsTest
private class HelloWordTest {
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