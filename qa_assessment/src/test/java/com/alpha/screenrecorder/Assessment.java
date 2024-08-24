package com.alpha.screenrecorder;

import java.time.Duration;

import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.testng.Assert;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

import io.github.bonigarcia.wdm.WebDriverManager;


public class Assessment {
	
	public static WebDriver driver;
	
	@BeforeMethod
    public void setUp() {
       
		WebDriverManager.chromedriver().setup();
        driver = new ChromeDriver();
        driver.manage().window().maximize();
        
        //implicit wait
        driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(10));
    }

	    @Test
	    public void testFrontendBackendIntegration() throws Exception {
	        String frontendUrl = "http://127.0.0.1:55635/"; 

			 
			 driver.get(frontendUrl);
	        
	        try (CloseableHttpClient httpClient = HttpClients.createDefault()) {
	            HttpGet request = new HttpGet(frontendUrl);
	            HttpResponse response = httpClient.execute(request);
	            
	            // Verify status code
	            Assert.assertEquals(response.getStatusLine().getStatusCode(), 200);
	            
	            // Verify content
	            
	            String body = driver.findElement(By.tagName("h1")).getText();
	            System.out.println("frontend ="+ body);
	            
	            String responseBody = EntityUtils.toString(response.getEntity());
	            Assert.assertTrue(responseBody.contains(body));
	        }
	    }
	    
	    @AfterMethod
	    public void tearDown() {
	        try {
	            if (driver != null) {
	                driver.quit();
	            }
	        } catch (Exception e) {
	            e.printStackTrace(); 
	        } finally {
	            
	            driver = null;
	        }
	    }
	}



