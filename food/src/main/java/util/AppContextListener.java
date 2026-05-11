package util;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

@WebListener
public class AppContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("=========================================");
        System.out.println("Forkly Application Starting...");
        System.out.println("=========================================");

        // Initialize data files
        FileHandler.initializeDataFiles();

        // Print data directory location
        System.out.println("Data Directory: " + FileHandler.getDataDir());
        System.out.println("=========================================");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("Forkly Application Shutting Down...");
    }
}