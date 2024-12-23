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

public class homeScreenTesting {
	
	private static final String EMAIL = "kiro@gmail.com";
	private static final String PASSWORD = "Test@1234";
	private static final String GROUP_NAME_EXAMPLE = "group";// change every run
	private static final String CHANNEL_NAME_EXAMPLE = "ch";// change every run
	
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
	          Thread.sleep(15000);
	       } catch (Exception var5) {
	          var5.printStackTrace();
	       }
	      
	   }
	
	 @AfterEach
	   public void tearDown() {
	      if (this.driver != null) {
	         this.driver.quit();
	         System.out.println("Application Closed...");
	      }

	   }
	 
	 //--------------------------------------------------UI---------------------------------------------------

	 @Test
	 public void uiTestFunc(String id, String item) {
		 try {
			 MobileElement logo = driver.findElementByAccessibilityId("Mazrof");
			 MobileElement addStory = driver.findElementByAccessibilityId("Add Story");
			 MobileElement menuBar = driver.findElement(By.xpath("//android.widget.FrameLayout[@resource-id=\"android:id/content\"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.view.View[1]/android.widget.Button"));

		     assertTrue(true);
			 System.out.println("UI test case passed");
		 }
		 catch (Exception e) {
			 assertTrue(false);
			 System.out.println("UI test case failed");
		 }
	 }
	 
	//-------------------------------------------Home Functionality-------------------------------------------
	 
	@Test
	public void testMenuFunc() {
		try {
			MobileElement menu = driver.findElement(By.xpath("//android.widget.FrameLayout[@resource-id=\"android:id/content\"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.view.View[1]/android.widget.Button"));
			menu.click();
			Thread.sleep(2000);
			try {
				MobileElement logo = driver.findElementByAccessibilityId("Mazrof");
				System.out.println("Menu bar doesn't open, test case failed");
				assertTrue(false);
				
			}
			catch (Exception e) {
				System.out.println("Menu bar opened successfully, test case passed");
				assertTrue(true);
			}
		}
		catch (Exception e) {
			System.out.println("Error while executing the test case");
			e.printStackTrace();
		}
		
	}
	
	@Test
	public void testAddGroup() {
		try {
			MobileElement menu = driver.findElement(By.xpath("//android.widget.FrameLayout[@resource-id=\"android:id/content\"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.view.View[1]/android.widget.Button"));
			menu.click();
			Thread.sleep(2000);
			
			MobileElement addGroup = driver.findElementByAccessibilityId("New Group");
			addGroup.click();
			Thread.sleep(2000);
			
			MobileElement rightMark = driver.findElement(By.xpath("//android.widget.FrameLayout[@resource-id=\"android:id/content\"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.widget.Button"));
			rightMark.click();
			Thread.sleep(2000);
			
			MobileElement groupName = driver.findElement(By.xpath("//android.widget.FrameLayout[@resource-id=\"android:id/content\"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.view.View[2]/android.widget.EditText[1]"));
			groupName.click();
			Thread.sleep(2000);
			groupName.sendKeys(GROUP_NAME_EXAMPLE);
			Thread.sleep(2000);
			
			MobileElement groupSize = driver.findElement(By.xpath("//android.widget.FrameLayout[@resource-id=\"android:id/content\"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.view.View[2]/android.widget.EditText[2]"));
			groupSize.click();
			Thread.sleep(2000);
			groupSize.sendKeys("12");
			Thread.sleep(2000);
			
			MobileElement done = driver.findElement(By.xpath("//android.widget.FrameLayout[@resource-id=\"android:id/content\"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.widget.Button"));
			done.click();
			Thread.sleep(7000);
			try {
				MobileElement check = driver.findElementByAccessibilityId("Group Screen");
				System.out.println("Group added successfully, test case Passed");
				assertTrue(true);
			}catch(Exception e) {
				System.out.println("Group doesn't added successfully, test case Failed");
				assertTrue(false);
			}
			
		}
		catch (Exception e) {
			System.out.println("Error, test case failed");
			assertTrue(false);
			e.printStackTrace();
		}
		
	}
	
	@Test
	public void testAddChannel() {
		try {
			MobileElement menu = driver.findElement(By.xpath("//android.widget.FrameLayout[@resource-id=\"android:id/content\"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.view.View[1]/android.widget.Button"));
			menu.click();
			Thread.sleep(2000);
			
			MobileElement addChannel = driver.findElementByAccessibilityId("New Channel");
			addChannel.click();
			Thread.sleep(2000);
			
			MobileElement rightMark = driver.findElement(By.xpath("//android.widget.FrameLayout[@resource-id=\"android:id/content\"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.widget.Button"));
			rightMark.click();
			Thread.sleep(2000);
			
			MobileElement channelName = driver.findElement(By.xpath("//android.widget.EditText"));
			channelName.click();
			Thread.sleep(2000);
			channelName.sendKeys(CHANNEL_NAME_EXAMPLE);
			Thread.sleep(2000);
			
			MobileElement done = driver.findElement(By.xpath("//android.widget.FrameLayout[@resource-id=\"android:id/content\"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.widget.Button"));
			done.click();
			Thread.sleep(7000);
			try {
				MobileElement check = driver.findElementByAccessibilityId("channel Screen");
				System.out.println("Channel added successfully, test case Passed");
				assertTrue(true);
			}catch(Exception e) {
				System.out.println("Channel doesn't added successfully, test case Failed");
				assertTrue(false);
			}
			
		}
		catch (Exception e) {
			System.out.println("Status doesn't open, test case failed");
			assertTrue(false);
			e.printStackTrace();
		}
		
	}

	
	//@Test
	public void testAddStoryFunc() {
		try {
			MobileElement addStory = driver.findElementByAccessibilityId("M\\nAdd Story");
			addStory.click();
			Thread.sleep(2000);
			
			MobileElement photo = driver.findElement(By.id("com.google.android.providers.media.module:id/icon_thumbnail"));
			photo.click();
			Thread.sleep(2000);
			
			MobileElement post = driver.findElementByAccessibilityId("Post Story");
			post.click();
			Thread.sleep(2000);
			
			try {
				MobileElement myStory = driver.findElementByAccessibilityId("My Story");
				myStory.click();
				Thread.sleep(2000);
				
				System.out.println("Status added successfully, test case passed");
				assertTrue(true);
				
			}
			catch (Exception e) {
				System.out.println("Failed to add status, test case failed");
				assertTrue(false);
			}
		}
		catch (Exception e) {
			System.out.println("Error while executing the test case");
			e.printStackTrace();
		}
		
	}
	
	//@Test
	public void testGroupFunc() {
		try {
			MobileElement menu = driver.findElement(By.xpath("//android.widget.FrameLayout[@resource-id=\"android:id/content\"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.view.View[1]/android.widget.Button"));
			menu.click();
			Thread.sleep(2000);
			
			MobileElement addGroup = driver.findElementByAccessibilityId("New Group");
			addGroup.click();
			Thread.sleep(2000);
			
			MobileElement rightMark = driver.findElement(By.xpath("//android.widget.FrameLayout[@resource-id=\"android:id/content\"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.widget.Button"));
			rightMark.click();
			Thread.sleep(2000);
			
			MobileElement groupName = driver.findElement(By.xpath("//android.widget.FrameLayout[@resource-id=\"android:id/content\"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.view.View[2]/android.widget.EditText[1]"));
			groupName.click();
			Thread.sleep(2000);
			groupName.sendKeys(GROUP_NAME_EXAMPLE);
			Thread.sleep(2000);
			
			MobileElement groupSize = driver.findElement(By.xpath("//android.widget.FrameLayout[@resource-id=\"android:id/content\"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.view.View[2]/android.widget.EditText[2]"));
			groupSize.click();
			Thread.sleep(2000);
			groupSize.sendKeys("12");
			Thread.sleep(2000);
			
			MobileElement done = driver.findElement(By.xpath("//android.widget.FrameLayout[@resource-id=\"android:id/content\"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.widget.Button"));
			done.click();
			Thread.sleep(7000);
			
			MobileElement group = driver.findElementByAccessibilityId("M\ngroup");
			group.click();
			Thread.sleep(2000);
			
			MobileElement add_members = driver.findElementByAccessibilityId("Add Member");
			add_members.click();
			Thread.sleep(2000);
			
			MobileElement user = driver.findElementByAccessibilityId("K\\nkiro\\n2024-12-12 13:27:42.542Z");
			user.click();
			Thread.sleep(2000);
			
			MobileElement done2 = driver.findElement(By.xpath("//android.widget.FrameLayout[@resource-id=\"android:id/content\"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.widget.Button"));
			done2.click();
			Thread.sleep(5000);
			
			MobileElement userMenu = driver.findElement(By.xpath("//android.view.View[@content-desc=\"K kiro member\"]/android.widget.Button"));
			userMenu.click();
			Thread.sleep(2000);
			
			MobileElement editPer = driver.findElementByAccessibilityId("Edit Permissions");
			editPer.click();
			Thread.sleep(2000);
			
			MobileElement clickOnDisable = driver.findElement(By.xpath("(//android.widget.RadioButton[@content-desc=\"Disallow\"])[1]"));
			clickOnDisable.click();
			Thread.sleep(2000);
			
			MobileElement done3 = driver.findElement(By.xpath("//android.widget.FrameLayout[@resource-id=\"android:id/content\"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.widget.Button"));
			done3.click();
			Thread.sleep(2000);
			
			userMenu.click();
			Thread.sleep(2000);
			
			MobileElement setAdmin = driver.findElementByAccessibilityId("set admin");
			setAdmin.click();
			Thread.sleep(2000);
			
			userMenu.click();
			Thread.sleep(2000);
			
			MobileElement removeUser = driver.findElementByAccessibilityId("Remove Member");
			removeUser.click();
			Thread.sleep(2000);
			
			try {
				MobileElement check = driver.findElement(By.xpath("//android.view.View[@content-desc=\"K kiro member\"]/android.widget.Button"));
				System.out.println("user deletion failed, test case failed");
				assertTrue(false);
			}catch (Exception e) {
				System.out.println("user deletion succeeded, test case passed");
				assertTrue(true);
			}
			
			MobileElement trash = driver.findElement(By.xpath("//android.widget.FrameLayout[@resource-id=\"android:id/content\"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.view.View[1]/android.widget.Button[3]"));
			trash.click();
			Thread.sleep(2000);
			
			MobileElement confirmDeletion = driver.findElementByAccessibilityId("Confirm");
			confirmDeletion.click();
			Thread.sleep(2000);
			
		}
		catch (Exception e) {
			System.out.println("Error while executing the test case");
			e.printStackTrace();
		}	
	}
	
	//@Test
	public void testChannelFunc() {
		try {
			MobileElement menu = driver.findElement(By.xpath("//android.widget.FrameLayout[@resource-id=\"android:id/content\"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.view.View[1]/android.widget.Button"));
			menu.click();
			Thread.sleep(2000);
			
			MobileElement addChannel = driver.findElementByAccessibilityId("New Channel");
			addChannel.click();
			Thread.sleep(2000);
			
			MobileElement rightMark = driver.findElement(By.xpath("//android.widget.FrameLayout[@resource-id=\"android:id/content\"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.widget.Button"));
			rightMark.click();
			Thread.sleep(2000);
			
			MobileElement channelName = driver.findElement(By.xpath("//android.widget.FrameLayout[@resource-id=\"android:id/content\"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.view.View[2]/android.widget.EditText[1]"));
			channelName.click();
			Thread.sleep(2000);
			channelName.sendKeys(CHANNEL_NAME_EXAMPLE);
			Thread.sleep(2000);
			
			MobileElement done = driver.findElement(By.xpath("//android.widget.FrameLayout[@resource-id=\"android:id/content\"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.widget.Button"));
			done.click();
			Thread.sleep(7000);
			
			MobileElement channel = driver.findElementByAccessibilityId("C\nch");
			channel.click();
			Thread.sleep(2000);
			
			MobileElement add_members = driver.findElementByAccessibilityId("Add Member");
			add_members.click();
			Thread.sleep(2000);
			
			MobileElement user = driver.findElementByAccessibilityId("K\\nkiro\\n2024-12-12 13:27:42.542Z");
			user.click();
			Thread.sleep(2000);
			
			MobileElement done2 = driver.findElement(By.xpath("//android.widget.FrameLayout[@resource-id=\"android:id/content\"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.widget.Button"));
			done2.click();
			Thread.sleep(5000);
			
			MobileElement userMenu = driver.findElement(By.xpath("//android.view.View[@content-desc=\"K kiro member\"]/android.widget.Button"));
			userMenu.click();
			Thread.sleep(2000);
			
			MobileElement editPer = driver.findElementByAccessibilityId("Edit Permissions");
			editPer.click();
			Thread.sleep(2000);
			
			MobileElement clickOnDisable = driver.findElementByAccessibilityId("Disallow");
			clickOnDisable.click();
			Thread.sleep(2000);
			
			MobileElement done3 = driver.findElement(By.xpath("//android.widget.FrameLayout[@resource-id=\"android:id/content\"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.widget.Button"));
			done3.click();
			Thread.sleep(2000);
			
			userMenu.click();
			Thread.sleep(2000);
			
			MobileElement setAdmin = driver.findElementByAccessibilityId("set admin");
			setAdmin.click();
			Thread.sleep(2000);
			
			userMenu.click();
			Thread.sleep(2000);
			
			MobileElement removeUser = driver.findElementByAccessibilityId("Remove Member");
			removeUser.click();
			Thread.sleep(2000);
			
			try {
				MobileElement check = driver.findElement(By.xpath("//android.view.View[@content-desc=\"K kiro member\"]/android.widget.Button"));
				System.out.println("user deletion failed, test case failed");
				assertTrue(false);
			}catch (Exception e) {
				System.out.println("user deletion succeeded, test case passed");
				assertTrue(true);
			}
			
			MobileElement trash = driver.findElement(By.xpath("//android.widget.FrameLayout[@resource-id=\"android:id/content\"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.view.View[1]/android.widget.Button[3]"));
			trash.click();
			Thread.sleep(2000);
			
			MobileElement confirmDeletion = driver.findElementByAccessibilityId("Confirm");
			confirmDeletion.click();
			Thread.sleep(2000);
			
		}
		catch (Exception e) {
			System.out.println("Error while executing the test case");
			e.printStackTrace();
		}
		
	}
}
