public class clearAccountSubTypeHandler
{
	public void setSubType(List <Account> AccountNew,List <Account> AccountOld)
    {
      for(Account a :AccountNew)
      {
          for(Account b:AccountOld)
          {
     		if (AccountNew!=AccountOld && b.Industry!=null)
     		{
         		a.Industry_Sub_Type__c=null;
     		}
          }
	  }
       
              	
	}
}