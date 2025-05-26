package utils;

import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.UUID;
import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

public class S3Uploader {

    private static final String BUCKET_NAME = ConfigGetter.getProperty("app.aws.bucket.name");
    private static final Region REGION = Region.AP_SOUTHEAST_1;

    public static String uploadToS3(InputStream inputStream, String originalFileName, long contentLength) throws IOException {
        String uuid = UUID.randomUUID().toString();
        String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
        String baseName = originalFileName.substring(0, originalFileName.lastIndexOf("."));
        String keyName = baseName + "_" + uuid + extension;

        S3Client s3 = S3Client.builder()
                .region(REGION)
                .credentialsProvider(
                        StaticCredentialsProvider.create(
                                AwsBasicCredentials.create(
                                        ConfigGetter.getProperty("app.aws.access.key.id"),
                                        ConfigGetter.getProperty("app.aws.secret.key")
                                )
                        )
                )
                .build();

        PutObjectRequest putRequest = PutObjectRequest.builder()
                .bucket("flexcarepplus")
                .key(keyName)
                .contentType("image/" + extension.replace(".", ""))
                .contentLength(contentLength)
                .build();

        s3.putObject(putRequest, RequestBody.fromInputStream(inputStream, contentLength));

        String encodedKey = URLEncoder.encode(keyName, StandardCharsets.UTF_8).replace("+", "%20");
        return String.format("https://%s.s3.%s.amazonaws.com/%s",
                BUCKET_NAME, REGION.id(), encodedKey);
    }

    public static void deleteFromS3(String imageUrl) {
        try {
            // Ví dụ URL: https://flexcarepplus.s3.ap-southeast-1.amazonaws.com/abc_xyz.jpg
            String prefix = String.format("https://%s.s3.%s.amazonaws.com/", BUCKET_NAME, REGION.id());

            if (!imageUrl.startsWith(prefix)) {
                System.out.println("⚠️ Not an S3 image from expected bucket. Skipping delete.");
                return;
            }

            String key = imageUrl.substring(prefix.length());

            S3Client s3 = S3Client.builder()
                    .region(REGION)
                    .credentialsProvider(
                            StaticCredentialsProvider.create(
                                    AwsBasicCredentials.create(
                                            ConfigGetter.getProperty("app.aws.access.key.id"),
                                            ConfigGetter.getProperty("app.aws.secret.key")
                                    )
                            )
                    )
                    .build();

            s3.deleteObject(builder -> builder.bucket(BUCKET_NAME).key(key).build());
            System.out.println("✅ Deleted old avatar from S3: " + key);

        } catch (Exception ex) {
            System.err.println("❌ Failed to delete from S3: " + ex.getMessage());
        }
    }
}
