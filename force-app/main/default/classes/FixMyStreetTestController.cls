@isTest
public class FixMyStreetTestController {
    
  static testMethod void getResults(){    

      FixMyStreetController.PagedResult res = FixMyStreetController.getResults('Open');
      system.debug(res);
      
      FixMyStreetController.PagedResult res1 = FixMyStreetController.getFilteredResults('Open','All');
      system.debug(res1);
      
      FixMyStreetController.PagedResult res1a = FixMyStreetController.getFilteredResults('Open','a096E000007q6HtQAI');
      system.debug(res1a);
      
       FixMyStreetController.PagedResult res1b = FixMyStreetController.getFilteredResults('All','All');
      system.debug(res1b);
      
      FixMyStreetController.PagedResult res1c = FixMyStreetController.getFilteredResults('All','a096E000007q6HtQAI');
      system.debug(res1c);
      
      FixMyStreetCategories__c[] res2 = FixMyStreetController.getCategories();
      
      List<String> res3 = FixMyStreetController.getStatus();
  }
      
}