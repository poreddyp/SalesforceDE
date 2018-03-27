/**
 * Created by Prab Poreddy on 10/26/2017.
 */
@IsTest
private class AppleWatchTest {
	//Function to insert a record in Opportunity, which invokes 'after insert' condition
	@IsTest static void insertOpportunity(){
		Opportunity opp = new Opportunity();
		opp.Name 		= 'Trigger Test';
		opp.CloseDate 	= Date.today();
		opp.StageName 	= 'Prospecting';
		insert opp;
	}
}