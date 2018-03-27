trigger CheckSecretInformation on Case (after insert, before update) {

	String childCaseSubject = 'Warning: Parent case may contain secret info';
//	Create a Set of secret keywords
	List<String> secretKeywords = new List<String>();
	secretKeywords.add('Credit Card');
	secretKeywords.add('Social Security');
	secretKeywords.add('SSN');
	secretKeywords.add('Passport');
	secretKeywords.add('Bodyweight');

	List<Case> casesWithSecretInfo = new List<Case>();
	for (Case myCase : Trigger.new) {
		/* Initiate a null Set and capture matched secret keywords by using
			.contains string method and index this list*/
		if (myCase.Subject != 'Warning: Parent case may contain secret info') {
			//Map<String,List<String>>
			List<String> matchedKeywords = new List<String>();
			for (String keyword : secretKeywords) {
				if (myCase.Description.containsIgnoreCase(keyword)) {
					matchedKeywords.add(keyword);
				}
				if (myCase.Description.containsIgnoreCase(keyword)) {
					casesWithSecretInfo.add(myCase);
					break;
				}
			}
			System.debug('Matched keywords: ' + matchedKeywords);
		}
	}


	List<Case> casesToCreate = new List<Case>();
	System.debug('casesToCreate started with list items:' + casesToCreate);
	for (Case caseWithSecretInfo: casesWithSecretInfo) {
		Case childCase = new Case();
		childCase.Subject = childCaseSubject;
		childCase.ParentId = caseWithSecretInfo.Id;
		childCase.Description = 'The parent case description one the following secret keywords: ' + secretKeywords;
		childCase.Priority = 'High';
		childCase.IsEscalated = true;
		casesToCreate.add(childCase);
		System.debug('casesToCreate now has childCase ' + casesToCreate);
	}
	insert casesToCreate;
}