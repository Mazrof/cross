package e2eMaZrofTesting;

import static org.junit.jupiter.api.Assertions.assertTrue;

import java.net.URL;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.remote.DesiredCapabilities;

import io.appium.java_client.AppiumDriver;
import io.appium.java_client.MobileElement;
import io.appium.java_client.android.AndroidDriver;

public class settingsTesting {
	
	private static final String EMAIL = "kiro@gmail.com";
	private static final String PASSWORD = "Test@1234";
	private static final String USERNAME = "MohamedAshraf123";
	private static final String NAME = "Mohamed Ashraf";
	private static final String BIO = "Computer Engineering dept";
	private static final String PHONE = "+0201011451311";
	
	private AppiumDriver<MobileElement> driver;
	private MobileElement nextButton;
	private MobileElement startButton;
	
	@BeforeEach
	public void openApp() throws Exception {
	      DesiredCapabilities cap = new DesiredCapabilities();
	      cap.setCapability("deviceName", "sdk_gphone64_x86_64");// LLD-L21
	      cap.setCapability("udid", "emulator-5554");// HCY4C18427000226 --> real android
	      cap.setCapability("platformName", "Android");
	      cap.setCapability("platformVersion", "14");// 9
	      cap.setCapability("appPackage", "com.example.telegram");
	      cap.setCapability("appActivity", "MainActivity");
	      cap.setCapability("automationName", "UiAutomator2");
	      URL url = new URL("http://127.0.0.1:4723/");
	      driver = new AndroidDriver<MobileElement>(url, cap);
	      System.out.println("Application Started...");
	      Thread.sleep(10000);
	      MobileElement allow = driver.findElement(By.id("com.android.permissioncontroller:id/permission_allow_button"));
	      allow.click();
	      Thread.sleep(2000);
	      nextButton = driver.findElementByAccessibilityId("next");
	      nextButton.click();
	      Thread.sleep(2000);
	      nextButton = driver.findElementByAccessibilityId("next");
	      nextButton.click();
	      Thread.sleep(2000);
	      nextButton = driver.findElementByAccessibilityId("next");
	      nextButton.click();
	      Thread.sleep(2000);
	      startButton = driver.findElementByAccessibilityId("start");
	      startButton.click();
	      Thread.sleep(5000);
	      
	      MobileElement email = driver.findElement(By.xpath("//android.widget.FrameLayout[@resource-id=\"android:id/content\"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.view.View/android.widget.EditText[1]"));
	      MobileElement password = driver.findElement(By.xpath("//android.widget.FrameLayout[@resource-id=\"android:id/content\"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.view.View/android.widget.EditText[2]"));
	      MobileElement login = driver.findElementByAccessibilityId("Login");

	      try {
	          email.click();
	          Thread.sleep(2000);
	          email.sendKeys(EMAIL);
	          password.click();
	          Thread.sleep(2000);
	          password.sendKeys(PASSWORD);
	          driver.hideKeyboard();
	          login.click();
	          Thread.sleep(10000);
	       } catch (Exception var5) {
	          var5.printStackTrace();
	       }
	      
	      MobileElement menu = driver.findElement(By.xpath("//android.widget.FrameLayout[@resource-id=\"android:id/content\"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.view.View[1]/android.widget.Button"));
	      menu.click();
		  Thread.sleep(2000);
		  
		  MobileElement setting = driver.findElementByAccessibilityId("Settings");
		  setting.click();
		  Thread.sleep(2000);
		  
	   }
	
	 @AfterEach
	   public void tearDown() {
	      if (this.driver != null) {
	         this.driver.quit();
	         System.out.println("Application Closed...");
	      }

	   }
	 
	 //@Test
	 public void testUi_openComponents() {
		 try {
			 MobileElement Account = driver.findElementByAccessibilityId("Account"); 
			 MobileElement Settings = driver.findElementByAccessibilityId("Settings");
			 MobileElement Data_Settings = driver.findElementByAccessibilityId("Data Settings");
			 System.out.println("Ui test case passed");
			 assertTrue(true);
		 }
		 catch (Exception e) {
			 System.out.println("Ui test case failed");
			 assertTrue(false);
		}
	 }
	 
	 @Test 
	 public void testSettingsFunctionalities() {
		 try {
			 MobileElement edit = driver.findElement(By.xpath("//android.widget.FrameLayout[@resource-id=\"android:id/content\"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.view.View[1]/android.widget.Button[2]"));
			 edit.click();
			 Thread.sleep(2000);
			 
			 MobileElement editInfo = driver.findElementByAccessibilityId("Edit info");
			 editInfo.click();
			 Thread.sleep(2000);
			 
			 MobileElement editUsername = driver.findElement(By.xpath("//android.widget.FrameLayout[@resource-id=\"android:id/content\"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.widget.EditText[1]"));
			 editUsername.click();
			 Thread.sleep(2000);
			 editUsername.clear();
			 Thread.sleep(2000);
			 editUsername.sendKeys(USERNAME);
			 
			 MobileElement editName = driver.findElement(By.xpath("//android.widget.FrameLayout[@resource-id=\"android:id/content\"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.widget.EditText[2]"));
			 editName.click();
			 Thread.sleep(2000);
			 editName.clear();
			 Thread.sleep(2000);
			 editName.sendKeys(NAME);
			 
			 MobileElement editBio = driver.findElement(By.xpath("//android.widget.FrameLayout[@resource-id=\"android:id/content\"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.widget.EditText[3]"));
			 editBio.click();
			 Thread.sleep(2000);
			 editBio.clear();
			 Thread.sleep(2000);
			 editBio.sendKeys(BIO);
			 
			 MobileElement editPhone = driver.findElement(By.xpath("//android.widget.FrameLayout[@resource-id=\"android:id/content\"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.widget.EditText[4]"));
			 editPhone.click();
			 Thread.sleep(2000);
			 editPhone.clear();
			 Thread.sleep(2000);
			 editPhone.sendKeys(PHONE);
			 
			 MobileElement doneMark = driver.findElement(By.xpath("//android.widget.FrameLayout[@resource-id=\"android:id/content\"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.view.View[1]/android.widget.Button[2]"));
			 doneMark.click();
			 Thread.sleep(2000);
			 
			 edit = driver.findElement(By.xpath("//android.widget.FrameLayout[@resource-id=\"android:id/content\"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.view.View[1]/android.widget.Button[2]"));
			 edit.click();
			 Thread.sleep(2000);
			 
			 editInfo = driver.findElementByAccessibilityId("Edit info");
			 editInfo.click();
			 Thread.sleep(2000);
			 
			 
			 editUsername = driver.findElement(By.xpath("//android.widget.FrameLayout[@resource-id=\"android:id/content\"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.widget.EditText[1]"));
			 
			 editName = driver.findElement(By.xpath("//android.widget.FrameLayout[@resource-id=\"android:id/content\"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.widget.EditText[2]"));
			 
			 editBio = driver.findElement(By.xpath("//android.widget.FrameLayout[@resource-id=\"android:id/content\"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.widget.EditText[3]"));
			
			 editPhone = driver.findElement(By.xpath("//android.widget.FrameLayout[@resource-id=\"android:id/content\"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.widget.EditText[4]"));
			 			 
			 if(editUsername.getText().equals(USERNAME) && editName.getText().equals(NAME) && editBio.getText().equals(BIO) && editPhone.getText().equals(PHONE)) {
				 doneMark = driver.findElement(By.xpath("//android.widget.FrameLayout[@resource-id=\"android:id/content\"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.view.View[1]/android.widget.Button[2]"));
				 doneMark.click();
				 Thread.sleep(2000);
				 
				 MobileElement privacyAndPolicy = driver.findElementByAccessibilityId("Privacy And Security");
				 privacyAndPolicy.click();
				 
				 
				 System.out.println("Settings functionalities test case passed");
				 assertTrue(true);
			 }else {
				 System.out.println("Settings functionalities test case failed");
				 assertTrue(false);
			 }
			 
			 
		 }
		 catch (Exception e) {
			 System.out.println("Functionalities test case failed");
			 assertTrue(false);
		}
		 
	 }
	 
	 @Test
	 public void testPrivacyAndPolictFunctionalities() {
		 try {
			 MobileElement privacyAndPolicy = driver.findElementByAccessibilityId("Privacy And Security");
			 privacyAndPolicy.click();
			 Thread.sleep(2000);
			 
			 MobileElement autoDeleteMessages = driver.findElementByAccessibilityId("Auto-Delete Messages");
			 autoDeleteMessages.click();
			 Thread.sleep(2000);
			 
			 MobileElement off = driver.findElementByAccessibilityId("Off");
			 off.click();
			 Thread.sleep(2000);
			 
			 MobileElement goBack = driver.findElementByClassName("android.widget.Button");
			 goBack.click();
			 Thread.sleep(2000);
			 
			 autoDeleteMessages = driver.findElementByAccessibilityId("Auto-Delete Messages");
			 autoDeleteMessages.click();
			 Thread.sleep(2000);
			 
			 MobileElement oneDay = driver.findElementByAccessibilityId("After 1 day");
			 oneDay.click();
			 Thread.sleep(2000);
			 
			 goBack = driver.findElementByClassName("android.widget.Button");
			 goBack.click();
			 Thread.sleep(2000);
			 
			 MobileElement blockUsers = driver.findElementByAccessibilityId("Blocked Users");
			 blockUsers.click();
			 Thread.sleep(2000);
			 
			 goBack = driver.findElementByClassName("android.widget.Button");
			 goBack.click();
			 Thread.sleep(2000);
			 
			 MobileElement lastseenAndOnline = driver.findElementByAccessibilityId("Last Seen & Online\nNobody");
			 lastseenAndOnline.click();
			 Thread.sleep(2000);
			 
			 MobileElement eveybody = driver.findElementByAccessibilityId("Everybody");
			 eveybody.click();
			 Thread.sleep(2000);
			 
			 goBack = driver.findElementByClassName("android.widget.Button");
			 goBack.click();
			 Thread.sleep(10000);
			 
			 lastseenAndOnline = driver.findElementByAccessibilityId("Last Seen & Online\nEverybody");
			 lastseenAndOnline.click();
			 Thread.sleep(2000);
			 
			 MobileElement contactsOnly = driver.findElementByAccessibilityId("My Contacts");
			 contactsOnly.click();
			 Thread.sleep(2000);
			 
			 goBack = driver.findElementByClassName("android.widget.Button");
			 goBack.click();
			 Thread.sleep(10000);
			 
			 lastseenAndOnline = driver.findElementByAccessibilityId("Last Seen & Online\nMy Contacts");
			 lastseenAndOnline.click();
			 Thread.sleep(2000);
			 
			 MobileElement noBody = driver.findElementByAccessibilityId("Nobody");
			 noBody.click();
			 Thread.sleep(2000);
			 
			 goBack = driver.findElementByClassName("android.widget.Button");
			 goBack.click();
			 Thread.sleep(2000);
			 
			 
			 MobileElement profilePhotos = driver.findElementByAccessibilityId("Profile Photos\nNobody");
			 profilePhotos.click();
			 Thread.sleep(2000);
			 
			 MobileElement eveybodyPhothos = driver.findElementByAccessibilityId("Everybody");
			 eveybodyPhothos.click();
			 Thread.sleep(2000);
			 
			 goBack = driver.findElementByClassName("android.widget.Button");
			 goBack.click();
			 Thread.sleep(10000);
			 
			 profilePhotos = driver.findElementByAccessibilityId("Profile Photos\nEverybody");
			 profilePhotos.click();
			 Thread.sleep(2000);
			 
			 MobileElement contactsOnlyPhotos = driver.findElementByAccessibilityId("My Contacts");
			 contactsOnlyPhotos.click();
			 Thread.sleep(2000);
			 
			 goBack = driver.findElementByClassName("android.widget.Button");
			 goBack.click();
			 Thread.sleep(10000);
			 
			 profilePhotos = driver.findElementByAccessibilityId("Profile Photos\nMy Contacts");
			 profilePhotos.click();
			 Thread.sleep(2000);
			 
			 MobileElement noBodyPhotos = driver.findElementByAccessibilityId("Nobody");
			 noBodyPhotos.click();
			 Thread.sleep(2000);
			 
			 goBack = driver.findElementByClassName("android.widget.Button");
			 goBack.click();
			 Thread.sleep(2000);
			 
			 MobileElement enableReadReceipts = driver.findElementByAccessibilityId("Read Receipts\nNobody");
			 enableReadReceipts.click();
			 
			 MobileElement eveybodyRR = driver.findElementByAccessibilityId("Everybody");
			 eveybodyRR.click();
			 Thread.sleep(2000);
			 
			 goBack = driver.findElementByClassName("android.widget.Button");
			 goBack.click();
			 Thread.sleep(10000);
			 
			 enableReadReceipts = driver.findElementByAccessibilityId("Read Receipts\nEverybody");
			 enableReadReceipts.click();
			 Thread.sleep(2000);
			 
			 MobileElement nobodyRR = driver.findElementByAccessibilityId("Nobody");
			 nobodyRR.click();
			 Thread.sleep(2000);
			 
			 System.out.println("Privacy and Policy functionalities test case passed");
			 assertTrue(true);
			 
		 }
		 catch (Exception e) {
			 System.out.println("Privacy and Policy functionalities test case failed");
			 assertTrue(false);
		}
		 
	 }
	 
}
