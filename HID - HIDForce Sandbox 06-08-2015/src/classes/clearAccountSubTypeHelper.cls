public class clearAccountSubTypeHelper 
{
    clearAccountSubTypeHandler handler = new clearAccountSubTypeHandler();
	public void beforeUpdate(List <Account> AccNew,List <Account> AccOld )
    {
        handler.setSubType(AccNew,AccOld);
    }
}