package controllers;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import daos.WalletDAO;
import daos.WalletTransferDAO;
import dtos.UserDetailDTO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import models.User;
import models.WalletTransfer;
import utils.VnPayEncryption;
import java.util.Calendar;
import java.util.TimeZone;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.nio.charset.StandardCharsets;
import models.Wallet;

public class WalletController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String actor = (String) request.getSession().getAttribute("actor");
        switch (actor) {
            case "admin" ->
                adminGet(request, response);
            case "customer" ->
                customerGet(request, response);
            case "staff" ->
                staffGet(request, response);
            default ->
                response.sendRedirect("./");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String actor = (String) request.getSession().getAttribute("actor");
        switch (actor) {
            case "admin" ->
                adminPost(request, response);
            case "customer" ->
                customerPost(request, response);
            case "staff" ->
                staffPost(request, response);
            default ->
                response.sendRedirect("./");
        }
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String actor = (String) request.getSession().getAttribute("actor");
        switch (actor) {
            case "admin" ->
                adminPut(request, response);
            case "customer" ->
                customerPut(request, response);
            case "staff" ->
                staffPut(request, response);
            default ->
                response.sendRedirect("./");
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String actor = (String) request.getSession().getAttribute("actor");
        switch (actor) {
            case "admin" ->
                adminDelete(request, response);
            case "customer" ->
                customerDelete(request, response);
            case "staff" ->
                staffDelete(request, response);
            default ->
                response.sendRedirect("./");
        }
    }

    // Admin role methods
    private void adminGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // To be implemented
    }

    private void adminPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // To be implemented
    }

    private void adminPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // To be implemented
    }

    private void adminDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // To be implemented
    }

    // Customer role methods
    private void customerGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
            case "getWallet" ->
                getWallet(request, response);
            case "depositResult" ->
                depositResult(request, response);
        }

    }

    private void customerPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
            case "deposit" ->
                deposit(request, response);

        }
    }

    private void customerPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // To be implemented
    }

    private void customerDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // To be implemented
    }

    // Staff role methods
    private void staffGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // To be implemented
    }

    private void staffPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // To be implemented
    }

    private void staffPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // To be implemented
    }

    private void staffDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // To be implemented
    }

    private void getWallet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        UserDetailDTO userDetailDTO = (UserDetailDTO) session.getAttribute("userDetailDTO");
        List<WalletTransfer> walletTransfers = WalletTransferDAO.getByUserId(userDetailDTO.getUser().getUserId());
        request.setAttribute("walletTransfers", walletTransfers);
        request.setAttribute("isSuccess", session.getAttribute("isSuccess"));
        session.removeAttribute("isSuccess");
        request.getRequestDispatcher("client/wallet.jsp").forward(request, response);
    }

    private void deposit(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String vnp_Version = "2.1.0";
        String vnp_Command = "pay";
        String orderType = "other";
        long amount = Integer.parseInt(request.getParameter("amount")) * 100;
        String bankCode = request.getParameter("bankCode");

        String vnp_TxnRef = VnPayEncryption.getRandomNumber(8);
        String vnp_IpAddr = VnPayEncryption.getIpAddress(request);

        String vnp_TmnCode = VnPayEncryption.vnp_TmnCode;

        Map<String, String> vnp_Params = new HashMap<>();
        vnp_Params.put("vnp_Version", vnp_Version);
        vnp_Params.put("vnp_Command", vnp_Command);
        vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
        vnp_Params.put("vnp_Amount", String.valueOf(amount));
        vnp_Params.put("vnp_CurrCode", "VND");

        if (bankCode != null && !bankCode.isEmpty()) {
            vnp_Params.put("vnp_BankCode", bankCode);
        }
        vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
        vnp_Params.put("vnp_OrderInfo", "Nap tien vao vi FlexCarePPlus\nMa giao dich: " + vnp_TxnRef);
        vnp_Params.put("vnp_OrderType", orderType);

        String locate = request.getParameter("language");
        if (locate != null && !locate.isEmpty()) {
            vnp_Params.put("vnp_Locale", locate);
        } else {
            vnp_Params.put("vnp_Locale", "vn");
        }
        vnp_Params.put("vnp_ReturnUrl", VnPayEncryption.vnp_ReturnUrl);
        vnp_Params.put("vnp_IpAddr", vnp_IpAddr);

        Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
        String vnp_CreateDate = formatter.format(cld.getTime());
        vnp_Params.put("vnp_CreateDate", vnp_CreateDate);

        cld.add(Calendar.MINUTE, 15);
        String vnp_ExpireDate = formatter.format(cld.getTime());
        vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);

        List fieldNames = new ArrayList(vnp_Params.keySet());
        Collections.sort(fieldNames);
        StringBuilder hashData = new StringBuilder();
        StringBuilder query = new StringBuilder();
        Iterator itr = fieldNames.iterator();
        while (itr.hasNext()) {
            String fieldName = (String) itr.next();
            String fieldValue = (String) vnp_Params.get(fieldName);
            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                //Build hash data
                hashData.append(fieldName);
                hashData.append('=');
                hashData.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                //Build query
                query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII.toString()));
                query.append('=');
                query.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                if (itr.hasNext()) {
                    query.append('&');
                    hashData.append('&');
                }
            }
        }
        String queryUrl = query.toString();
        String vnp_SecureHash = VnPayEncryption.hmacSHA512(VnPayEncryption.secretKey, hashData.toString());
        queryUrl += "&vnp_SecureHash=" + vnp_SecureHash;
        String paymentUrl = VnPayEncryption.vnp_PayUrl + "?" + queryUrl;
        com.google.gson.JsonObject job = new JsonObject();
        job.addProperty("code", "00");
        job.addProperty("message", "success");
        job.addProperty("data", paymentUrl);
        Gson gson = new Gson();
        response.getWriter().write(gson.toJson(job));
    }

    private void depositResult(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        UserDetailDTO userDetailDTO = (UserDetailDTO) session.getAttribute("userDetailDTO");
        User user = userDetailDTO.getUser();
        String transCode = request.getParameter("vnp_TxnRef");
        String timeCode = request.getParameter("vnp_PayDate");
        String respondCode = request.getParameter("vnp_ResponseCode");
        float amount = Float.parseFloat(request.getParameter("vnp_Amount"));
        if (respondCode.equals("00")) {
            Wallet wallet = WalletDAO.getByUserId(user.getUserId());
            float money = wallet.getAmount() + amount / 100;
            wallet.setAmount(money);
            WalletDAO.update(wallet);
            WalletTransfer walletTransfer = new WalletTransfer();
            walletTransfer.setUserID(user.getUserId());
            walletTransfer.setTransCode(transCode);
            walletTransfer.setContent("Nap tien vao vi FlexCarePPlus\nMa giao dich: " + transCode);
            walletTransfer.setTimeCode(timeCode);
            walletTransfer.setAmount(amount / 100);
            walletTransfer.setIsRefunded(false);
            WalletTransferDAO.create(walletTransfer);
            session.setAttribute("wallet", wallet);
            session.setAttribute("isSuccess", true);
        } else {
            session.setAttribute("isSuccess", false);
        }
        response.sendRedirect("wallet?action=getWallet");
    }
}
