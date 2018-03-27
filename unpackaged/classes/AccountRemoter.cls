global with sharing class AccountRemoter {

    public String accountName { get; set; }
    public static List<Account> account { get; set; }
    public AccountRemoter() { } // empty constructor
    
    @RemoteAction
    global static List<Account> getAccount() {
        account = [SELECT Id, Name, Phone, Type, NumberOfEmployees 
                   FROM Account];// WHERE Name = 'Prab Test'];
        return account;
    }
}