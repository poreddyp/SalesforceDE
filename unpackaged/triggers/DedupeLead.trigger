trigger DedupeLead on Lead (before insert) {

	List<Group> dataQualityQueue = [SELECT Id
									  FROM Group
								     WHERE DeveloperName = 'Data_Quality'
								     LIMIT 1];
    for (Lead myLead : Trigger.new){

		System.debug('The original Owner of the lead is ' + myLead.Name);
		System.debug('The original description of the lead is ' + myLead.Description);
		//Search for matching contact to determine dupes
		if (myLead.Email !=null) {
			System.debug('The email of the Lead is: '+ myLead.Email);
			List<Contact> matchingContacts = [SELECT Id,
													 FirstName,
													 LastName
												FROM Contact
												WHERE Email = :myLead.Email];
			System.debug('There are ' + matchingContacts.size() + ' duplicate contacts found and they are: ' +
					matchingContacts);

			//If matches are found...
			if (!matchingContacts.isEmpty()) {
				If(!dataQualityQueue.isEmpty()){
					myLead.OwnerId = dataQualityQueue.get(0).Id;
				}
				String dupeDescription = 'Other leads with the same contact are: ';
				for (Contact dupeContacts : matchingContacts) {
					dupeDescription = dupeDescription +
							          dupeContacts.FirstName + ' ' +
							          dupeContacts.LastName + ' ' +
							          dupeContacts.Id + ' \n';

				}
				if(myLead.Description != null){
					dupeDescription = dupeDescription + '\n' + myLead.Description;
				}
				myLead.Description = dupeDescription;



				System.debug('The new Owner of the lead is ' + myLead.Name);
				System.debug('The new description of the lead is ' + myLead.Description);
			}
		}

    }

}