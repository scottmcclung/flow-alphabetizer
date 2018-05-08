@IsTest
private class AlphabetizerTest
{
  @isTest
  static void test_equals()
  {
    assertIsTrue('aaa', 'aaa', 'Equals');
    assertIsFalse('aaa', 'aba', 'Equals');
    assertIsFalse('aba', 'aaa', 'Equals');
  
    assertIsTrue('aaa', 'aaa', '=');
    assertIsFalse('aaa', 'aba', '=');
    assertIsFalse('aba', 'aaa', '=');
  
    assertIsTrue('aaa', 'aaa', '==');
    assertIsFalse('aaa', 'aba', '==');
    assertIsFalse('aba', 'aaa', '==');
  }
  
  
  
  @isTest
  static void test_lessThan()
  {
    assertIsTrue('aaa', 'aba', 'Less Than');
    assertIsFalse('aaa', 'aaa', 'Less Than');
    assertIsFalse('aba', 'aaa', 'Less Than');
  
    assertIsTrue('aaa', 'aba', '<');
    assertIsFalse('aaa', 'aaa', '<');
    assertIsFalse('aba', 'aaa', '<');
  }
  
  
  
  @isTest
  static void test_greaterThan()
  {
    assertIsTrue('aab', 'aaa', 'Greater Than');
    assertIsFalse('aaa', 'aaa', 'Greater Than');
    assertIsFalse('aaa', 'aab', 'Greater Than');
  
    assertIsTrue('aab', 'aaa', '>');
    assertIsFalse('aaa', 'aaa', '>');
    assertIsFalse('aaa', 'aab', '>');
  }
  
  
  
  @isTest
  static void test_lessThanEquals()
  {
    assertIsTrue('aaa', 'aba', 'Less Than Or Equals');
    assertIsTrue('aaa', 'aaa', 'Less Than Or Equals');
    assertIsFalse('aba', 'aaa', 'Less Than Or Equals');
  
    assertIsTrue('aaa', 'aba', '<=');
    assertIsTrue('aaa', 'aaa', '<=');
    assertIsFalse('aba', 'aaa', '<=');
  }
  
  
  
  @isTest
  static void test_greaterThanEquals()
  {
    assertIsTrue('aab', 'aaa', 'Greater Than Or Equals');
    assertIsTrue('aaa', 'aaa', 'Greater Than Or Equals');
    assertIsFalse('aaa', 'aab', 'Greater Than Or Equals');
  
    assertIsTrue('aab', 'aaa', '>=');
    assertIsTrue('aaa', 'aaa', '>=');
    assertIsFalse('aaa', 'aab', '>=');
  }
  
  
  @isTest
  static void test_between()
  {
    assertIsTrue('aab', 'aaa', 'aba', 'Between');
    assertIsTrue('aaa', 'aaa', 'bbb', 'Between');
    assertIsTrue('bbb', 'aaa', 'bbb', 'Between');
    assertIsFalse('aaa', 'bbb', 'ccc', 'Between');
    assertIsFalse('ccc', 'aaa', 'bbb', 'Between');
  
    assertIsTrue('aab', 'aaa', 'aba', '><');
    assertIsTrue('aaa', 'aaa', 'bbb', '><');
    assertIsTrue('bbb', 'aaa', 'bbb', '><');
    assertIsFalse('aaa', 'bbb', 'ccc', '><');
    assertIsFalse('ccc', 'aaa', 'bbb', '><');
  }
  
  
  @isTest
  static void test_incorrectComparator()
  {
    List<Alphabetizer.Result> results = buildTest('aaa', 'bbb', '', 'wrong-comparator');
    system.assertEquals(1, results.size());
  
    system.assertEquals(false, results[0].success);
    system.assertEquals(false, results[0].answer);
    system.assertEquals('The comparator is invalid.', results[0].errorMessage);
  }
  
  
  @isTest
  static void test_emptyComparator()
  {
    List<Alphabetizer.Result> results = buildTest('aaa', 'bbb', '', '');
    system.assertEquals(1, results.size());
    
    system.assertEquals(false, results[0].success);
    system.assertEquals(false, results[0].answer);
    system.assertEquals('The comparator is invalid.', results[0].errorMessage);
  }
  
  
  
  private static void assertIsTrue(String strValue1, String strValue2, String strComparator)
  {
    assertIsTrue(strValue1, strValue2, '', strComparator);
  }
  
  
  
  private static void assertIsTrue(String strValue1, String strValue2, String strValue3, String strComparator)
  {
    List<Alphabetizer.Result> results = buildTest(strValue1, strValue2, strValue3, strComparator);
    system.assertEquals(1, results.size());
    assertResultIsTrue(results[0]);
  }


  
  private static void assertIsFalse(String strValue1, String strValue2, String strComparator)
  {
    assertIsFalse(strValue1, strValue2, '', strComparator);
  }
  
  
  
  private static void assertIsFalse(String strValue1, String strValue2, String strValue3, String strComparator)
  {
    List<Alphabetizer.Result> results = buildTest(strValue1, strValue2, strValue3, strComparator);
    system.assertEquals(1, results.size());
    assertResultIsFalse(results[0]);
  }
  
  
  private static List<Alphabetizer.Result> buildTest(String strValue1, String strValue2, String strValue3, String strComparator)
  {
    Alphabetizer.Request request = requestFactory(strValue1, strValue2, strValue3, strComparator);
    List<Alphabetizer.Request> requests = new List<Alphabetizer.Request>{ request };
    return Alphabetizer.sort(requests);
  }
  
  
  private static Alphabetizer.Request requestFactory(String strValue1, String strValue2, String strValue3, String strComparator)
  {
    Alphabetizer.Request request = new Alphabetizer.Request();
    request.strValue1 = strValue1;
    request.strValue2 = strValue2;
    request.strValue3 = strValue3;
    request.strComparator = strComparator;
    return request;
  }
  
  
  private static void assertResultIsTrue(Alphabetizer.Result result)
  {
    system.assert(result.success);
    system.assertEquals(true, result.answer);
    system.assertEquals(null, result.errorMessage);
  }
  
  
  private static void assertResultIsFalse(Alphabetizer.Result result)
  {
    system.assert(result.success);
    system.assertEquals(false, result.answer);
    system.assertEquals(null, result.errorMessage);
  }
}