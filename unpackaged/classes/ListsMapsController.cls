/**
 * Created by Prab Poreddy on 1/19/2018.
 */
public class ListsMapsController {
	public Map<String, String> inputFields { get; set; }


	public ListsMapsController() {
		inputFields = new Map<String, String> {
		'firstName' => 'Jonny', 'lastName' => 'Appleseed', 'age' => '42', 'testField' => '','result' => '' };
	}

	public PageReference submitFieldData() {
		doSomethingInterestingWithInput();
		return null;
	}

	public void doSomethingInterestingWithInput() {
		inputFields.put('age', (Integer.valueOf(inputFields.get('age')) + 10).format());
		inputFields.put('result', inputFields.get('testField'));
	}

}