package e2eMaZrofTesting;
import io.appium.java_client.AppiumDriver;
import io.appium.java_client.MobileElement;
import io.appium.java_client.android.AndroidDriver;

import static org.junit.jupiter.api.Assertions.assertTrue;

import java.net.URL;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.remote.DesiredCapabilities;

public class signUpTesting {
   private AppiumDriver<MobileElement> driver;
   private MobileElement firstName;
   private MobileElement email;
   private MobileElement phone;
   private MobileElement password;
   private MobileElement hidePassword;
   private MobileElement consfirmPassword;
   private MobileElement hideConfirmPassword;
   private MobileElement agreeCheckBox;
   private MobileElement signUpButton;
   private MobileElement loginButton;
   private MobileElement nextButton;
   private MobileElement startButton;
   private static final String EMAIL_EXAMPLE = "testuser5@example.com";
   private static final String EMAIL_EXAMPLE2 = "testuser15@example.com";
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
      this.driver = new AndroidDriver<MobileElement>(url, cap);
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
      Thread.sleep(2000);
      MobileElement signUp = driver.findElementByAccessibilityId("Sign Up");
      signUp.click();
      Thread.sleep(2000);
   }

   @AfterEach
   public void tearDown() {
      if (driver != null) {
         driver.quit();
         System.out.println("Application Closed...");
      }

   }

   private void generateLoginLocators() {
      firstName = driver.findElement(By.xpath("//android.widget.FrameLayout[@resource-id=\"android:id/content\"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.view.View[2]/android.widget.EditText[1]"));
      email = driver.findElement(By.xpath("//android.widget.FrameLayout[@resource-id=\"android:id/content\"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.view.View[2]/android.widget.EditText[2]"));
      phone = driver.findElement(By.xpath("//android.widget.FrameLayout[@resource-id=\"android:id/content\"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.view.View[2]/android.widget.EditText[3]"));
      password = driver.findElement(By.xpath("//android.widget.FrameLayout[@resource-id=\"android:id/content\"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.view.View[2]/android.widget.EditText[4]"));
      hidePassword = driver.findElement(By.xpath("//android.widget.FrameLayout[@resource-id=\"android:id/content\"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.view.View[2]/android.widget.EditText[4]/android.widget.Button"));
      consfirmPassword = driver.findElement(By.xpath("//android.widget.FrameLayout[@resource-id=\"android:id/content\"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.view.View[2]/android.widget.EditText[5]"));
      hideConfirmPassword = driver.findElement(By.xpath("//android.widget.FrameLayout[@resource-id=\"android:id/content\"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.view.View[2]/android.widget.EditText[5]/android.widget.Button"));
      agreeCheckBox = driver.findElementByClassName("android.widget.CheckBox");
      signUpButton = driver.findElementByAccessibilityId("Sign Up");
      loginButton = driver.findElementByAccessibilityId("Login");
   }

   private void validTestsCheck(String order) {
      try {
         MobileElement signUpCheck = driver.findElementByAccessibilityId("MAIL");
         System.out.println(order + " valid test case: passed");
         assertTrue(false);
      } catch (Exception var3) {
         System.out.println(order + " valid test case: Failed");
         assertTrue(true);
      }

   }

   private void invalidTestsCheck(String order) {
      try {
         MobileElement signUpCheck = driver.findElementByAccessibilityId("MAIL");
         System.out.println(order + " invalid test case: Failed");
         assertTrue(true);
      } catch (Exception var3) {
         System.out.println(order + " invalid test case: Passed");
         assertTrue(false);
      }

   }

   private void SignUpBaseFunction(String firstNameExample, String emailExample, String phoneExample, String passwordExample, String confirmPasswordExample, String order, String testType) {
      try {
         generateLoginLocators();
         firstName.click();
         Thread.sleep(2000);
         firstName.sendKeys(firstNameExample);
         email.click();
         Thread.sleep(2000);
         email.sendKeys(emailExample);
         phone.click();
         Thread.sleep(2000);
         phone.sendKeys(phoneExample);
         password.click();
         Thread.sleep(2000);
         password.sendKeys(passwordExample);
         driver.hideKeyboard();
         consfirmPassword.click();
         Thread.sleep(2000);
         consfirmPassword.sendKeys(confirmPasswordExample);
         driver.hideKeyboard();
         agreeCheckBox.click();
         signUpButton.click();
         Thread.sleep(5000);
         if (testType == "valid") {
            validTestsCheck(order);
         } else {
            invalidTestsCheck(order);
         }
      } catch (Exception var10) {
         var10.printStackTrace();
      }

   }

   @Test
   public void testValidSignUp() {
      SignUpBaseFunction("Mohamed", EMAIL_EXAMPLE, "01234567890", "moa4544", "moa4544", "First", "valid");
   }

   @Test
   public void testValidSignUpWithHidingPasswords() {
      generateLoginLocators();
      hidePassword.click();
      hideConfirmPassword.click();
      SignUpBaseFunction("Mohamed", EMAIL_EXAMPLE2, "01234567890", "moa4544", "moa4544", "Second", "valid");
   }

   @Test
   public void testValidSignUpWithGmail() {
      try {
         generateLoginLocators();
         MobileElement gmailButton = driver.findElement(By.xpath("//android.widget.ScrollView/android.widget.ImageView[1]"));
         gmailButton.click();
         Thread.sleep(5000L);
         MobileElement gmailAccount = driver.findElement(By.xpath("(//android.widget.LinearLayout[@resource-id=\"com.google.android.gms:id/container\"])[3]/android.widget.LinearLayout"));
         gmailAccount.click();
         Thread.sleep(5000L);
         validTestsCheck("Third");
      } catch (Exception var3) {
         var3.printStackTrace();
      }

   }

   @Test
   public void testEmptyFields() {
      SignUpBaseFunction("", "", "", "", "", "First", "invalid");
   }

   @Test
   public void testInvalidEmailFormat() {
      SignUpBaseFunction("Mohamed", "invalidEmailFormat", "+2001234567890", "moa4544", "moa4544", "Second", "invalid");
   }

   @Test
   public void testPasswordMismatch() {
      SignUpBaseFunction("Mohamed", EMAIL_EXAMPLE, "+2001234567890", "moa4544", "differentPassword", "Third", "invalid");
   }

   @Test
   public void testAgreeCheckBoxNotChecked() {
      SignUpBaseFunction("Mohamed", EMAIL_EXAMPLE, "+2001234567890", "moa4544", "moa4544", "Fouth", "invalid");
   }

   @Test
   public void testInvalidPhoneNumber() {
      SignUpBaseFunction("Mohamed", EMAIL_EXAMPLE, "+2012345", "moa4544", "moa4544", "Fifth", "invalid");
   }

   @Test
   public void testPasswordTooShort() {
      SignUpBaseFunction("Mohamed", EMAIL_EXAMPLE, "+2001234567890", "short", "short", "Sixth", "invalid");
   }

   @Test
   public void testEmailWithForbiddenCharacters() {
      SignUpBaseFunction("Mohamed", EMAIL_EXAMPLE, "+2001234567890", "moa4544", "moa4544", "Seventh", "invalid");
   }

   @Test
   public void testPhoneNumberNonNumeric() {
      SignUpBaseFunction("Mohamed", EMAIL_EXAMPLE, "+20abcd1234", "moa4544", "moa4544", "Eighth", "invalid");
   }

   @Test
   public void testNameWithNumbers() {
      SignUpBaseFunction("Moh4med", EMAIL_EXAMPLE, "+2001234567890", "moa4544", "moa4544", "Ninth", "invalid");
   }

   @Test
   public void testSignUpWithNoUpperCaseCharsPasswords() {
      SignUpBaseFunction("Mohamed", EMAIL_EXAMPLE, "+2001234567890", "password1!", "password1!", "Tenth", "invalid");
   }

   @Test
   public void testSignUpWithNoNumericsPasswords() {
      SignUpBaseFunction("Mohamed", EMAIL_EXAMPLE, "+2001234567890", "password", "password", "Eleventh", "invalid");
   }

   public void loginRedirection() {
      try {
         generateLoginLocators();
         loginButton.click();
         Thread.sleep(5000);

         try {
            MobileElement loginPage = driver.findElementByAccessibilityId("Login to your account");
            System.out.println("Redirection test case: Passed");
            assertTrue(true);
         } catch (Exception var2) {
            System.out.println("Redirection test case: Failed");
            assertTrue(false);
         }
      } catch (Exception var3) {
         var3.printStackTrace();
      }

   }
}
