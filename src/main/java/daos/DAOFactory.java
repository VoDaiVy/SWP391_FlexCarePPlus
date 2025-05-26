package daos;

/**
 * Factory class for creating DAO instances
 * This helps maintain a single instance of each DAO and provides a central point for DAO creation
 */
public class DAOFactory {
    
    // Singleton instances of each DAO
    private static UserDAO userDAO;
    private static UserDetailDAO userDetailDAO;
    private static BookingDAO bookingDAO;
    private static BookingDetailDAO bookingDetailDAO;
    private static ServiceDAO serviceDAO;
    private static CategoryServiceDAO categoryServiceDAO;
    private static RoomDAO roomDAO;
    private static WalletDAO walletDAO;
    private static WalletTransferDAO walletTransferDAO;
    private static FeedbackServiceDAO feedbackServiceDAO;
    
    /**
     * Get UserDAO instance
     * @return UserDAO instance
     */
    public static UserDAO getUserDAO() {
        if (userDAO == null) {
            userDAO = new UserDAO();
        }
        return userDAO;
    }
    
    /**
     * Get UserDetailDAO instance
     * @return UserDetailDAO instance
     */
    public static UserDetailDAO getUserDetailDAO() {
        if (userDetailDAO == null) {
            userDetailDAO = new UserDetailDAO();
        }
        return userDetailDAO;
    }
    
    /**
     * Get BookingDAO instance
     * @return BookingDAO instance
     */
    public static BookingDAO getBookingDAO() {
        if (bookingDAO == null) {
            bookingDAO = new BookingDAO();
        }
        return bookingDAO;
    }
    
    /**
     * Get BookingDetailDAO instance
     * @return BookingDetailDAO instance
     */
    public static BookingDetailDAO getBookingDetailDAO() {
        if (bookingDetailDAO == null) {
            bookingDetailDAO = new BookingDetailDAO();
        }
        return bookingDetailDAO;
    }
    
    /**
     * Get ServiceDAO instance
     * @return ServiceDAO instance
     */
    public static ServiceDAO getServiceDAO() {
        if (serviceDAO == null) {
            serviceDAO = new ServiceDAO();
        }
        return serviceDAO;
    }
    
    /**
     * Get CategoryServiceDAO instance
     * @return CategoryServiceDAO instance
     */
    public static CategoryServiceDAO getCategoryServiceDAO() {
        if (categoryServiceDAO == null) {
            categoryServiceDAO = new CategoryServiceDAO();
        }
        return categoryServiceDAO;
    }
    
    /**
     * Get RoomDAO instance
     * @return RoomDAO instance
     */
    public static RoomDAO getRoomDAO() {
        if (roomDAO == null) {
            roomDAO = new RoomDAO();
        }
        return roomDAO;
    }
    
    /**
     * Get WalletDAO instance
     * @return WalletDAO instance
     */
    public static WalletDAO getWalletDAO() {
        if (walletDAO == null) {
            walletDAO = new WalletDAO();
        }
        return walletDAO;
    }
    
    /**
     * Get WalletTransferDAO instance
     * @return WalletTransferDAO instance
     */
    public static WalletTransferDAO getWalletTransferDAO() {
        if (walletTransferDAO == null) {
            walletTransferDAO = new WalletTransferDAO();
        }
        return walletTransferDAO;
    }
    
    /**
     * Get FeedbackServiceDAO instance
     * @return FeedbackServiceDAO instance
     */
    public static FeedbackServiceDAO getFeedbackServiceDAO() {
        if (feedbackServiceDAO == null) {
            feedbackServiceDAO = new FeedbackServiceDAO();
        }
        return feedbackServiceDAO;
    }
}
