trigger LeadingCompetitor on Opportunity (before insert, before update) {

//Each time an Opp record is inserted or updated, create two lists with matching index.
	for (Opportunity myOpp : Trigger.new){

//First list <<competitorPrices>> must contain competitor prices starting with competitor 1 through 3.
		List<Decimal> competitorPrices = new List<Decimal>();
		competitorPrices.add(myOpp.Competitor_1_Price__c);
		competitorPrices.add(myOpp.Competitor_2_Price__c);
		competitorPrices.add(myOpp.Competitor_3_Price__c);

//Second list <<competitors>> must contain competitor names with the same index as <<competitorPrices>>
		List<String> competitors = new List<String>();
		competitors.add(myOpp.Competitor_1__c);
		competitors.add(myOpp.Competitor_2__c);
		competitors.add(myOpp.Competitor_3__c);

//Loop through <<competitorPrices>> list and find the lowest price. Use that index to find the matching
//list item in <<competitors>>

		Decimal lowestCompetitorPrice = null;
		String lowestCompetitor = null;

		for (Integer i = 0; i < competitorPrices.size(); i++){
			Decimal currentPrice = competitorPrices.get(i);
			if (lowestCompetitorPrice == null || currentPrice < lowestCompetitorPrice ){
				lowestCompetitorPrice = currentPrice;
				lowestCompetitor = competitors.get(i);
			}

		}

		myOpp.Leading_Competitor__c = lowestCompetitor;
		myOpp.Leading_Competitor_Price__c = lowestCompetitorPrice;


	}

}