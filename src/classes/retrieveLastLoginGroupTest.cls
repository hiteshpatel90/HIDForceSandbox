@isTest
private class retrieveLastLoginGroupTest {
    static testMethod void TEST_retrieveLastLoginGroup() {
		retrieveLastLoginGroup controller = new retrieveLastLoginGroup();
		List<User> myUser = controller.getSales();
		System.assertNotEquals(null, myUser);
		myUser.clear();
		myUser = controller.getSalesEmea();
		System.assertNotEquals(null, myUser);
		myUser.clear();
		myUser = controller.getCustomerService();
		System.assertNotEquals(null, myUser);
		myUser.clear();
		myUser = controller.getCustomerServiceEmea();
		System.assertNotEquals(null, myUser);
		myUser.clear();
		myUser = controller.getTechSupport();
		System.assertNotEquals(null, myUser);
		myUser.clear();
		myUser = controller.getTechSupportEmea();
		System.assertNotEquals(null, myUser);
		myUser.clear();
		myUser = controller.getMarketing();
		System.assertNotEquals(null, myUser);
		myUser.clear();
		myUser = controller.getOthers();
		System.assertNotEquals(null, myUser);
    }
}