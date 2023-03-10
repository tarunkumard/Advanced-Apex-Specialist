
@isTest
private class OrderTests {
    
	@testSetup
    static void SetupTestData() {
        TestDataFactory.InsertTestData(20);
        

        
        
    }
    
    @isTest
    static void OrderUpdate_UnitTest() {
    	Order selectedOrder = [Select name,Status, Id from Order limit 1];
        Product2 oldProd = [Select Quantity_Ordered__c, Name, Id from Product2 limit 1];
        
        selectedOrder.Status = Constants.ACTIVATED_ORDER_STATUS;
        update selectedOrder;
        
        Product2 updatedProd = [Select Quantity_Ordered__c, Name, Id from Product2 limit 1];
        
        TestDataFactory.VerifyQuantityOrdered(oldProd,updatedProd,Constants.DEFAULT_ROWS);
    }
    
    @isTest
    static void OrderExtension_UnitTest() {
        PageReference reference = Page.OrderEdit;
        Test.setCurrentPage(reference);
        Order CurOrder = [Select Id,Status from Order limit 1];
        ApexPages.StandardController controller = new Apexpages.StandardController(CurOrder);
        OrderExtension extension = new OrderExtension(controller);
        System.assertEquals(5, extension.orderItemList.size());
        extension.selectedFamily = 'Dessert';
        extension.SelectFamily();
        extension.OnFieldChange();
        extension.First();
        extension.Next();
        extension.Previous();
        extension.Last();
        extension.GetHasNext();
        extension.GetPageNumber();
        extension.GetHasPrevious();
        extension.GetTotalPages();
        extension.GetFamilyOptions();
        extension.Save();
        ChartHelper.GetInventory();
        Order selectedOrder = [Select name,Status, Id from Order limit 1];
Product2 oldProd = [Select Quantity_Ordered__c, Standard_Price__c, Name, Id from Product2 limit 1];
        
selectedOrder.Status = Constants.ACTIVATED_ORDER_STATUS;
update selectedOrder;
        
Product2 updatedProd = [Select Quantity_Ordered__c, Standard_Price__c, Name, Id from Product2 limit 1];

Decimal expectedTotalPrice = oldProd.Quantity_Ordered__c * oldProd.Standard_Price__c;
Decimal actualTotalPrice = updatedProd.Quantity_Ordered__c * updatedProd.Standard_Price__c;

System.assertEquals(expectedTotalPrice, actualTotalPrice);

    } 

}