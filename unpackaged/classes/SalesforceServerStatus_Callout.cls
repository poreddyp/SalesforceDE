/*
 * Created by Prab Poreddy.
 */
// Helper for scheduling SalesforceStatus class using cronExpressions in execute anonymous
global class SalesforceServerStatus_Callout implements Schedulable{
	global  void execute(SchedulableContext SC){
		SalesforceServerStatus.checkStatus();
	}
}