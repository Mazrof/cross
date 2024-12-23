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


public class loginTesting {
   private AppiumDriver<MobileElement> driver;
   private MobileElement email;
   private MobileElement password;
   private MobileElement hidePasswordButton;
   private MobileElement rememberMeCheckbox;
   private MobileElement forgetPasswordButton;
   private MobileElement login;
   private MobileElement signUp;
   private MobileElement nextButton;
   private MobileElement startButton;
   private static final String EMAIL_EXAMPLE = "ma2736666@gmail.com";
   private static final String NONEXISTING_EMAIL_EXAMPLE = "test123@gmail.com";
   private static final String INVALID_EMAIL_FORMATE_EXAMPLE = "test123.com";
   private static final String PASSWORD_EXAMPLE = "Mm#123456";
   private static final String GMAIL_ACCOUNT_XPATH = "(//android.widget.LinearLayout[@resource-id=\"com.google.android.gms:id/container\"])[3]/android.widget.LinearLayout";
   private static final String VALID_GITHUB_ACCOUNT = "github@gmail.com";
   private static final String VALID_GITHUB_PASSWORD = "githubPassword";
   private static final String VALID_RESET_PASSWORD = "Mm@123456";

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
   }

   @AfterEach
   public void tearDown() {
      if (this.driver != null) {
         this.driver.quit();
         System.out.println("Application Closed...");
      }

   }

   private void generateLoginLocators() {
	   email = driver.findElement(By.xpath("//android.widget.FrameLayout[@resource-id=\"android:id/content\"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.view.View/android.widget.EditText[1]"));
       password = driver.findElement(By.xpath("//android.widget.FrameLayout[@resource-id=\"android:id/content\"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.view.View/android.widget.EditText[2]"));
       hidePasswordButton = driver.findElement(By.xpath("//android.widget.FrameLayout[@resource-id=\"android:id/content\"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.view.View/android.widget.EditText[2]/android.widget.Button"));
       login = driver.findElementByAccessibilityId("Login");
       rememberMeCheckbox = driver.findElement(By.className("android.widget.CheckBox"));
       forgetPasswordButton = driver.findElementByAccessibilityId("Forget Password");
       signUp = driver.findElementByAccessibilityId("Sign Up");
   }

   private void validTestsCheck(String order) {
      try {
         MobileElement loginPage = (MobileElement)this.driver.findElementByAccessibilityId("Login to your account");
         System.out.println(order + " valid test case: Failed");
         assertTrue(false);
      } catch (Exception var3) {
         System.out.println(order + " valid test case: Passed");
         assertTrue(true);
      }

   }

   private void validTestCasesBaseFunction(String emailExample, String passwordExample, String order) {
      try {
         generateLoginLocators();
         email.click();
         Thread.sleep(2000);
         email.sendKeys(emailExample);
         password.click();
         Thread.sleep(2000);
         password.sendKeys(passwordExample);
         driver.hideKeyboard();
         login.click();
         Thread.sleep(10000);
         validTestsCheck(order);
      } catch (Exception var5) {
         var5.printStackTrace();
      }

   }

   @Test
   public void testValidLogin() {
      validTestCasesBaseFunction(EMAIL_EXAMPLE, PASSWORD_EXAMPLE, "First");
   }

   @Test
   public void testValidLoginWithHidingPassword() {
      generateLoginLocators();
      hidePasswordButton.click();
      validTestCasesBaseFunction(EMAIL_EXAMPLE, PASSWORD_EXAMPLE, "Second");
   }

   @Test
   public void testValidLoginWithRememberMe() {
      generateLoginLocators();
      rememberMeCheckbox.click();
      validTestCasesBaseFunction(EMAIL_EXAMPLE, PASSWORD_EXAMPLE, "Third");
   }

   @Test
   public void testValidLoginWithGmail() {
      try {
         generateLoginLocators();
         MobileElement gmailButton = driver.findElement(By.xpath("//android.widget.FrameLayout[@resource-id=\"android:id/content\"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.view.View/android.widget.ImageView[2]"));
         gmailButton.click();
         Thread.sleep(5000);
         MobileElement gmailAccount = driver.findElement(By.xpath(GMAIL_ACCOUNT_XPATH));
         gmailAccount.click();
         Thread.sleep(5000);
         validTestsCheck("Fourth");
      } catch (Exception var3) {
         var3.printStackTrace();
      }

   }

   public void testValidLoginWithGitHub() {
      try {
         generateLoginLocators();
         MobileElement gitHubButton = driver.findElement(By.xpath("//android.widget.FrameLayout[@resource-id=\"android:id/content\"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.view.View/android.widget.ImageView[3]"));
         gitHubButton.click();
         Thread.sleep(5000);
         MobileElement loginField = driver.findElement(By.id("login_field"));
         loginField.click();
         Thread.sleep(2000);
         loginField.sendKeys(VALID_GITHUB_ACCOUNT);
         MobileElement passwordField = driver.findElement(By.id("login_field"));
         passwordField.click();
         Thread.sleep(2000);
         passwordField.sendKeys(VALID_GITHUB_PASSWORD);
         MobileElement signinButton = driver.findElement(By.xpath("//android.widget.Button[@text=\"Sign in\"]"));
         signinButton.click();
         Thread.sleep(5000);
         validTestsCheck("Fifth");
      } catch (Exception var5) {
         var5.printStackTrace();
      }

   }
   
   //-----------------------------------------------invalid test cases----------------------------------------

   private void inValidTestsCheck(String order) {
      try {
         MobileElement loginPage = driver.findElementByAccessibilityId("Login to your account");
         System.out.println(order + " invalid test case: Passed");
         assertTrue(true);
      } catch (Exception var3) {
         System.out.println(order + " invalid test case: Failed");
         assertTrue(false);
      }

   }

   private void inValidTestCasesBaseFunction(String emailExample, String passwordExample, String order) {
      try {
         generateLoginLocators();
         email.click();
         Thread.sleep(2000);
         email.sendKeys(emailExample);
         password.click();
         Thread.sleep(2000);
         password.sendKeys(passwordExample);
         login.click();
         Thread.sleep(10000);
         inValidTestsCheck(order);
      } catch (Exception var5) {
         var5.printStackTrace();
      }

   }

   
   @Test
   public void testEmptyEmailLogin() {
      inValidTestCasesBaseFunction("", PASSWORD_EXAMPLE, "First");
   }

   @Test
   public void testEmptyPasswordLogin() {
      inValidTestCasesBaseFunction(EMAIL_EXAMPLE, "", "Second");
   }

   @Test
   public void testEmptyEmailPasswordLogin() {
      inValidTestCasesBaseFunction("", "", "Third");
   }
   
   @Test
   public void testInvalidEmailLogin() {
	      inValidTestCasesBaseFunction(INVALID_EMAIL_FORMATE_EXAMPLE, PASSWORD_EXAMPLE, "Fourth");
   }

   @Test
   public void testNonExistingEmailLogin() {
	      inValidTestCasesBaseFunction(NONEXISTING_EMAIL_EXAMPLE, PASSWORD_EXAMPLE, "Fifth");
   }
   
   @Test
   public void testWrongPasswordLogin() {
	      inValidTestCasesBaseFunction(EMAIL_EXAMPLE, "111", "Sixth");
   }
   
   //-------------------------------------------------redirections-------------------------------------------
   @Test
   public void testForgetPassword(String password, String order) {
      try {
         this.generateLoginLocators();
         this.forgetPasswordButton.click();
         Thread.sleep(5000);
         MobileElement emailField = driver.findElementByClassName("android.widget.EditText");
         emailField.click();
         Thread.sleep(2000);
         emailField.sendKeys(EMAIL_EXAMPLE);
         MobileElement resetPasswordButton = driver.findElementByAccessibilityId("Reset Password");
         resetPasswordButton.click();
         Thread.sleep(5000);
         try {
        	 MobileElement checkReset = driver.findElementByAccessibilityId("Mail Sent: Reset link sent to your email ,please check your email");
        	 System.out.println(order + "Forget password test case: Passed");
             assertTrue(true);
         }catch(Exception e) {
        	 System.out.println(order + "Forget password test case: Failed");
             assertTrue(false);
         }
      } catch (Exception var9) {
         var9.printStackTrace();
      }

   }

   @Test
   public void testSignUpRedirection() {
      try {
         generateLoginLocators();
         signUp.click();
         Thread.sleep(5000);
         try {
             MobileElement loginPage = driver.findElementByAccessibilityId("Login to your account");
             System.out.println("Sign Up Redirection redirection test case: Failed");
             assertTrue(false);
          } catch (Exception var3) {
             System.out.println("Sign Up Redirection redirection test case: Passed");
             assertTrue(true);
          }
      } catch (Exception var2) {
         var2.printStackTrace();
      }

   }
}
