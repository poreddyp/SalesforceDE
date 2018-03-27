/**
 * Created by Prab Poreddy on 1/17/2018.
 */
public class PrabTestController {

    static List<String> Result = new List<String>();

    public List<String> getResult(){
        return Result;
    }

    public void setResult(){
        //none
    }

    // This is the only public function from this class
    public static PageReference deriveString(){
        System.debug('result is:'+ Result);
        deriveStringInner1();
        System.debug('result after calling innner classes is:'+ Result + 'and the list size is '+ result.size());
        for (Integer i=0; i<Result.size(); i++){
            System.debug('The list element index is '+ i +' and the value is '+Result[i]);
        }
        return null;
    }
    // Inner private function that accesses class variable and updates it
    private static void deriveStringInner1(){
        Result.add('+one');
        System.debug('result from deriveStringInner1 is:'+ Result);
        deriveStringInner2();
    }

    // Inner private function that is called from another private function to update a class variable
    private static void deriveStringInner2(){
        Result.add('+two');
        System.debug('result from deriveStringInner2 is:'+ Result);
        deriveStringInner3();
    }

    // Inner private function that is called from another private function to update a class variable
    private static void deriveStringInner3(){
        Result.add('+three');
        System.debug('result from deriveStringInner3 is:'+ Result);
    }



}