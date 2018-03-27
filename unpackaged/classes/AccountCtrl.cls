/**
 * Created by Prab Poreddy on 11/13/2017.
 */
public class AccountCtrl{

        

        public List<Account> getMyAccounts() {
        
        final List<Account> myAccounts = [Select Id, Name from Account LIMIT 10];
        
        return myAccounts;
        
        }

}