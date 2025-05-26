package utils;

import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

/**
 * Utility class for handling date and time conversions between Java types and SQL types
 */
public class DateTimeUtils {
    
    private static final String DATE_FORMAT = "yyyy-MM-dd";
    private static final String TIME_FORMAT = "HH:mm:ss";
    private static final String DATETIME_FORMAT = "yyyy-MM-dd HH:mm:ss";
    
    /**
     * Convert a LocalDate object to SQL Date
     * @param localDate The LocalDate to convert
     * @return SQL Date object or null if input is null
     */
    public static Date toSqlDate(LocalDate localDate) {
        return localDate != null ? Date.valueOf(localDate) : null;
    }
    
    /**
     * Convert a SQL Date object to LocalDate
     * @param date The SQL Date to convert
     * @return LocalDate object or null if input is null
     */
    public static LocalDate toLocalDate(Date date) {
        return date != null ? date.toLocalDate() : null;
    }
    
    /**
     * Convert a LocalTime object to SQL Time
     * @param localTime The LocalTime to convert
     * @return SQL Time object or null if input is null
     */
    public static Time toSqlTime(LocalTime localTime) {
        return localTime != null ? Time.valueOf(localTime) : null;
    }
    
    /**
     * Convert a SQL Time object to LocalTime
     * @param time The SQL Time to convert
     * @return LocalTime object or null if input is null
     */
    public static LocalTime toLocalTime(Time time) {
        return time != null ? time.toLocalTime() : null;
    }
    
    /**
     * Convert a LocalDateTime object to SQL Timestamp
     * @param localDateTime The LocalDateTime to convert
     * @return SQL Timestamp object or null if input is null
     */
    public static Timestamp toSqlTimestamp(LocalDateTime localDateTime) {
        return localDateTime != null ? Timestamp.valueOf(localDateTime) : null;
    }
    
    /**
     * Convert a SQL Timestamp object to LocalDateTime
     * @param timestamp The SQL Timestamp to convert
     * @return LocalDateTime object or null if input is null
     */
    public static LocalDateTime toLocalDateTime(Timestamp timestamp) {
        return timestamp != null ? timestamp.toLocalDateTime() : null;
    }
    
    /**
     * Parse a string to LocalDate
     * @param dateStr String representation of a date in yyyy-MM-dd format
     * @return LocalDate object or null if input is empty or invalid
     */
    public static LocalDate parseLocalDate(String dateStr) {
        if (dateStr == null || dateStr.isEmpty()) {
            return null;
        }
        try {
            return LocalDate.parse(dateStr, DateTimeFormatter.ofPattern(DATE_FORMAT));
        } catch (Exception e) {
            System.out.println("Error parsing date: " + e.getMessage());
            return null;
        }
    }
    
    /**
     * Parse a string to LocalTime
     * @param timeStr String representation of a time in HH:mm:ss format
     * @return LocalTime object or null if input is empty or invalid
     */
    public static LocalTime parseLocalTime(String timeStr) {
        if (timeStr == null || timeStr.isEmpty()) {
            return null;
        }
        try {
            return LocalTime.parse(timeStr, DateTimeFormatter.ofPattern(TIME_FORMAT));
        } catch (Exception e) {
            System.out.println("Error parsing time: " + e.getMessage());
            return null;
        }
    }
    
    /**
     * Parse a string to LocalDateTime
     * @param dateTimeStr String representation of a date-time in yyyy-MM-dd HH:mm:ss format
     * @return LocalDateTime object or null if input is empty or invalid
     */
    public static LocalDateTime parseLocalDateTime(String dateTimeStr) {
        if (dateTimeStr == null || dateTimeStr.isEmpty()) {
            return null;
        }
        try {
            return LocalDateTime.parse(dateTimeStr, DateTimeFormatter.ofPattern(DATETIME_FORMAT));
        } catch (Exception e) {
            System.out.println("Error parsing date-time: " + e.getMessage());
            return null;
        }
    }
    
    /**
     * Format a LocalDate to string
     * @param localDate The LocalDate to format
     * @return String representation in yyyy-MM-dd format or empty string if input is null
     */
    public static String formatLocalDate(LocalDate localDate) {
        return localDate != null ? localDate.format(DateTimeFormatter.ofPattern(DATE_FORMAT)) : "";
    }
    
    /**
     * Format a LocalTime to string
     * @param localTime The LocalTime to format
     * @return String representation in HH:mm:ss format or empty string if input is null
     */
    public static String formatLocalTime(LocalTime localTime) {
        return localTime != null ? localTime.format(DateTimeFormatter.ofPattern(TIME_FORMAT)) : "";
    }
    
    /**
     * Format a LocalDateTime to string
     * @param localDateTime The LocalDateTime to format
     * @return String representation in yyyy-MM-dd HH:mm:ss format or empty string if input is null
     */
    public static String formatLocalDateTime(LocalDateTime localDateTime) {
        return localDateTime != null ? localDateTime.format(DateTimeFormatter.ofPattern(DATETIME_FORMAT)) : "";
    }
}
