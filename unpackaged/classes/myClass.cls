global class myClass{ 
   @RemoteAction
   webservice static String getContextUserName() {
        return UserInfo.getFirstName();
   }
}