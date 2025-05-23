package utils;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ConfigGetter {

    private static Properties properties;

    private static void loadProperties() {
        if (properties == null) {
            properties = new Properties();
            try (InputStream input = ConfigGetter.class.getClassLoader().getResourceAsStream("Properties/application.properties")) {
                if (input != null) {
                    properties.load(input);
                }
            } catch (IOException e) {
                Logger.getLogger(ConfigGetter.class.getName()).log(Level.SEVERE, null, e);
            }
        }
    }

    public static String getProperty(String key) {
        if (properties == null) {
            loadProperties();
        }
        return properties.getProperty(key);
    }

    public static String getConnectionString() {
        String server = getProperty("db.server");
        String databaseName = getProperty("db.database");
        return "jdbc:sqlserver://" + server + ";databaseName=" + databaseName + ";encrypt=true;trustServerCertificate=true;loginTimeout=30";
    }
}
