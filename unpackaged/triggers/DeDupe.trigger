trigger DeDupe on Account (after insert) {
	for (Account acc : Trigger.new){
		Case c = new Case();
		//c.OwnerId  = '0051I000000qTeG';
		c.Subject  = 'DeDupe this account';
		c.AccountId = acc.Id;
		insert c;
    }

}