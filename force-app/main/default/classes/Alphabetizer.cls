global class Alphabetizer
{
  @InvocableMethod(label='Alphabetizer' description='Compares two string values based on a comparator.')
  public static List<Result> sort(List<Request> lstRequests)
  {
    List<Result> results = new List<Result>();
    for(Request request : lstRequests) {
      results.add( request.getResult() );
    }
    return results;
  }
  
  global enum Comparator {EQUALS, LESS_THAN, GREATER_THAN, LESS_THAN_EQUALS, GREATER_THAN_EQUALS, BETWEEN}
  
  global class Request
  {
    @InvocableVariable(label='Text Value 1' description='Text to be tested.' required=true)
    global String strValue1;
    
    @InvocableVariable(label='Text Value 2' description='Text value to be tested against.' required=true)
    global String strValue2;
  
    @InvocableVariable(label='Text Value 3' description='Second text value to be tested against if using the *Between* comparator.')
    global String strValue3;
    
    @InvocableVariable(label='Comparator' required=true)
    global String strComparator;
    
    private Alphabetizer.Comparator comparator;
    
    Map<String,Alphabetizer.Comparator> mapComparators = new Map<String,Alphabetizer.Comparator>{
      '=' => Alphabetizer.Comparator.EQUALS,
      '==' => Alphabetizer.Comparator.EQUALS,
      '><' => Alphabetizer.Comparator.BETWEEN,
      '<' => Alphabetizer.Comparator.LESS_THAN,
      '>' => Alphabetizer.Comparator.GREATER_THAN,
      '<=' => Alphabetizer.Comparator.LESS_THAN_EQUALS,
      '>=' => Alphabetizer.Comparator.GREATER_THAN_EQUALS,
      'equals' => Alphabetizer.Comparator.EQUALS,
      'between' => Alphabetizer.Comparator.BETWEEN,
      'less than' => Alphabetizer.Comparator.LESS_THAN,
      'greater than' => Alphabetizer.Comparator.GREATER_THAN,
      'less than or equals' => Alphabetizer.Comparator.LESS_THAN_EQUALS,
      'greater than or equals' => Alphabetizer.Comparator.GREATER_THAN_EQUALS
    };
    
    
    public Result getResult()
    {
      if( comparatorIsInvalid() ) {
        return error('The comparator is invalid.');
      }

      return success( compare() );
    }
    
    
    private Boolean compare()
    {
      if(comparator == Alphabetizer.Comparator.EQUALS && strValue1 == strValue2) return true;
      if(comparator == Alphabetizer.Comparator.LESS_THAN && strValue1 < strValue2) return true;
      if(comparator == Alphabetizer.Comparator.GREATER_THAN && strValue1 > strValue2) return true;
      if(comparator == Alphabetizer.Comparator.LESS_THAN_EQUALS && strValue1 <= strValue2) return true;
      if(comparator == Alphabetizer.Comparator.GREATER_THAN_EQUALS && strValue1 >= strValue2) return true;
      if(comparator == Alphabetizer.Comparator.BETWEEN && strValue1 >= strValue2 && strValue1 <= strValue3) return true;
      return false;
    }
    
    
    
    private Result success(Boolean sortResult)
    {
      return new Alphabetizer.Result(sortResult);
    }
    
    
    private Result error(String strErrorMessage)
    {
      return new Alphabetizer.Result(false, strErrorMessage);
    }
    
    
    private Boolean comparatorIsInvalid()
    {
      if( ! mapComparators.containsKey(strComparator.toLowerCase()) ) return true;
      
      comparator = mapComparators.get(strComparator.toLowerCase());
      return false;
    }
  }
  
  
  global class Result
  {
    @InvocableVariable(label='Result' description='The results of the comparison.')
    global Boolean answer;
    
    @InvocableVariable(label='Success' description='Was the test completed successful?')
    global Boolean success;
    
    @InvocableVariable(label='Error Message' description='The error message.')
    global String errorMessage;
    
    public Result(Boolean answer)
    {
      this(answer, true, null);
    }
    
    public Result(Boolean success, String errorMessage)
    {
      this(false, success, errorMessage);
    }
    
    public Result(Boolean answer, Boolean success, String errorMessage)
    {
      this.answer = answer;
      this.success = success;
      this.errorMessage = errorMessage;
    }
  }
}

