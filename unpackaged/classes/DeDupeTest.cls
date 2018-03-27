/**
 * Created by Prab Poreddy on 10/26/2017.
 */
@IsTest
private class DeDupeTest {
	//Function to insert a record in Account object, which automatically invokes 'before insert' condition in DeDupe trigger
	@IsTest static void insertAccount(){
		Account acc = new Account();
		acc.Name = 'Trigger Test';
		insert acc;
	}
}