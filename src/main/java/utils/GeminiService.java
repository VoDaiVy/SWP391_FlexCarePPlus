package utils;

import java.io.IOException;
import java.net.URL;
import java.util.Scanner;
import javax.net.ssl.HttpsURLConnection;
import java.io.OutputStream;
import java.nio.charset.StandardCharsets;

public class GeminiService {

    private final String apiUrl = ConfigGetter.getProperty("gemini.url");
    private final String apiKey = ConfigGetter.getProperty("gemini.key");

    public String validateContent(String content) throws IOException {
        String urlStr = apiUrl + "?key=" + apiKey;
        URL url = new URL(urlStr);
        HttpsURLConnection conn = (HttpsURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
        conn.setDoOutput(true);

        String requestBody = "{"
                + "\"contents\":[{\"role\":\"user\",\"parts\":[{\"text\":\"" + escapeJson(content) + "\"}]}],"
                + "\"generationConfig\":{"
                + "\"response_mime_type\":\"application/json\","
                + "\"response_schema\":{"
                + "\"type\":\"object\","
                + "\"properties\":{"
                + "\"is_valid\":{\"type\":\"boolean\",\"description\":\"True nếu nội dung hợp lệ, False nếu có công kích, thô tục, phân biệt chủng tộc hoặc phản cảm, độc hại.\"},"
                + "\"reason\":{\"type\":\"string\",\"description\":\"Giải thích ngắn gọn lý do vì sao nội dung hợp lệ hoặc không hợp lệ.\"}"
                + "},"
                + "\"required\":[\"is_valid\",\"reason\"]"
                + "}"
                + "}"
                + "}";

        try (OutputStream os = conn.getOutputStream()) {
            byte[] input = requestBody.getBytes(StandardCharsets.UTF_8);
            os.write(input, 0, input.length);
        }

        int code = conn.getResponseCode();
        if (code != 200) {
            throw new IOException("Gemini API error: " + code);
        }

        StringBuilder response = new StringBuilder();
        try (Scanner scanner = new Scanner(conn.getInputStream(), StandardCharsets.UTF_8.name())) {
            while (scanner.hasNextLine()) {
                response.append(scanner.nextLine());
            }
        }

        return response.toString();
    }

    public String generateVetNews(String topic) throws IOException {
        String urlStr = apiUrl + "?key=" + apiKey;
        URL url = new URL(urlStr);
        HttpsURLConnection conn = (HttpsURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
        conn.setDoOutput(true);

        // Prompt cho Gemini
        String prompt = "Bạn là một nhà chăm sóc thú y chuyên nghiệp, nhiều kinh nghiệm. "
                + "Hãy viết một bài tin tức về chủ đề: \"" + escapeJson(topic) + "\". "
                + "Bài viết cần có tiêu đề nổi bật và nội dung hữu ích, dễ hiểu cho người nuôi thú cưng. "
                + "Trả về kết quả dưới dạng JSON với 2 trường: 'title' (tiêu đề) và 'content' (nội dung bài viết).";

        String requestBody = "{"
                + "\"contents\":[{\"role\":\"user\",\"parts\":[{\"text\":\"" + escapeJson(prompt) + "\"}]}],"
                + "\"generationConfig\":{"
                + "\"response_mime_type\":\"application/json\","
                + "\"response_schema\":{"
                + "\"type\":\"object\","
                + "\"properties\":{"
                + "\"title\":{\"type\":\"string\",\"description\":\"Tiêu đề bài viết\"},"
                + "\"content\":{\"type\":\"string\",\"description\":\"Nội dung bài viết\"}"
                + "},"
                + "\"required\":[\"title\",\"content\"]"
                + "}"
                + "}"
                + "}";

        try (OutputStream os = conn.getOutputStream()) {
            byte[] input = requestBody.getBytes(StandardCharsets.UTF_8);
            os.write(input, 0, input.length);
        }

        int code = conn.getResponseCode();
        if (code != 200) {
            throw new IOException("Gemini API error: " + code);
        }

        StringBuilder response = new StringBuilder();
        try (Scanner scanner = new Scanner(conn.getInputStream(), StandardCharsets.UTF_8.name())) {
            while (scanner.hasNextLine()) {
                response.append(scanner.nextLine());
            }
        }

        return response.toString();
    }

    public byte[] generateImageByGemini(String prompt, int height, int width) throws IOException {
        String urlStr = apiUrl + "?key=" + apiKey;
        URL url = new URL(urlStr);
        HttpsURLConnection conn = (HttpsURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
        conn.setDoOutput(true);

        // Prompt cho Gemini sinh ảnh
        String requestBody = "{"
                + "\"contents\":[{\"role\":\"user\",\"parts\":[{\"text\":\"" + escapeJson(prompt) + "\"}]}],"
                + "\"generationConfig\":{"
                + "\"response_mime_type\":\"image/png\","
                + "\"imageConfig\":{"
                + "\"height\":" + height + ","
                + "\"width\":" + width
                + "}"
                + "}"
                + "}";

        try (OutputStream os = conn.getOutputStream()) {
            byte[] input = requestBody.getBytes(StandardCharsets.UTF_8);
            os.write(input, 0, input.length);
        }

        int code = conn.getResponseCode();
        if (code != 200) {
            throw new IOException("Gemini API error: " + code);
        }

        // Đọc dữ liệu ảnh trả về
        try (java.io.ByteArrayOutputStream baos = new java.io.ByteArrayOutputStream(); java.io.InputStream is = conn.getInputStream()) {
            byte[] buffer = new byte[4096];
            int len;
            while ((len = is.read(buffer)) != -1) {
                baos.write(buffer, 0, len);
            }
            return baos.toByteArray();
        }
    }

    private String escapeJson(String s) {
        if (s == null) {
            return "";
        }
        return s.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
    }
}
