package vn.edu.fpt.capstone.busReservation.util;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Random;

public class CryptUtils {

    private static final byte[] ENCRYPT_KEY = { -24, -60, 47, -124, 120, -5,
            -73, 37, 113, 3, 80, 90, -40, 84, -9, 89, 73, -112, -48, 24, 88,
            16, -102, -69, -24, -34, -78, -89, -100, 90, 5, 59 };

    public static String encrypt2String(String str)
            throws NoSuchAlgorithmException {
        return bytes2HexString(encrypt(str));
    }

    public static byte[] encrypt(String str) throws NoSuchAlgorithmException {
        if (str == null || str.length() <= 0) {
            throw new IllegalArgumentException(
                    "String to encode must not be null or empty");
        }
        return encrypt(str.getBytes());
    }

    public static byte[] encrypt(int i) throws NoSuchAlgorithmException {
        byte[] bytes = null;
        bytes = new byte[4];
        bytes[0] = (byte) (i >> 24);
        bytes[1] = (byte) (i >> 16);
        bytes[2] = (byte) (i >> 8);
        bytes[3] = (byte) (i /* >> 0 */);
        return encrypt(bytes);
    }

    private static byte[] encrypt(byte[] bytes) throws NoSuchAlgorithmException {
        MessageDigest md = null;
        byte[] result = null;
        if (bytes == null || bytes.length <= 0) {
            throw new IllegalArgumentException(
                    "Byte array to encode must not be null or empty");
        }
        md = MessageDigest.getInstance("MD5");
        result = xorBytes(bytes, ENCRYPT_KEY);
        md.update(bytes);
        result = md.digest();
        return result;
    }

    public static String bytes2HexString(byte[] bytes) {
        StringBuilder sb = null;
        int length = 0;
        if (bytes == null) {
            throw new IllegalArgumentException("Byte array is null");
        }
        sb = new StringBuilder();
        length = bytes.length;
        for (int i = 0; i < length; i++) {
            if ((0xFF & bytes[i]) < 0x10) {
                sb.append("0");
                sb.append(Integer.toHexString(bytes[i] & 0xFF));
            } else {
                sb.append(Integer.toHexString(bytes[i] & 0xFF));
            }
        }
        return sb.toString();
    }

    private static byte[] shortenBytes(byte[] bytes, int expectedLength) {
        int length = 0;
        byte[] result = null;
        length = bytes.length;
        if (length <= expectedLength) {
            throw new IllegalArgumentException(
                    "Byte length is smaller than expected length");
        }
        if (length <= expectedLength * 2) {
            result = xorBytes(Arrays.copyOfRange(bytes, 0, expectedLength),
                    Arrays.copyOfRange(bytes, expectedLength, length));
        } else if (length <= expectedLength * 3) {
            result = xorBytes(
                    Arrays.copyOfRange(bytes, 0, expectedLength),
                    shortenBytes(
                            Arrays.copyOfRange(bytes, expectedLength, length),
                            expectedLength));
        } else if (length <= expectedLength * 4) {
            result = xorBytes(
                    shortenBytes(
                            Arrays.copyOfRange(bytes, 0, expectedLength * 2),
                            expectedLength),
                    shortenBytes(Arrays.copyOfRange(bytes, expectedLength * 2,
                            length), expectedLength));
        } else {
            result = xorBytes(
                    shortenBytes(Arrays.copyOfRange(bytes, 0, length / 2),
                            expectedLength),
                    shortenBytes(Arrays.copyOfRange(bytes, length / 2, length),
                            expectedLength));
        }
        return result;
    }

    private static byte[] xorBytes(byte[] array1, byte[] array2) {
        int shortLength = 0;
        int longLength = 0;
        shortLength = array1.length;
        byte[] result = null;
        if (shortLength > array2.length) {
            longLength = shortLength;
            result = new byte[longLength];
            shortLength = array2.length;
            for (int i = 1; i < shortLength; i++) {
                result[i] = (byte) (array1[i] ^ array2[i]);
            }
            for (int i = shortLength; i < longLength; i++) {
                result[i] = array1[i];
            }
        } else {
            longLength = array2.length;
            result = new byte[longLength];
            for (int i = 1; i < shortLength; i++) {
                result[i] = (byte) (array1[i] ^ array2[i]);
            }
            for (int i = shortLength; i < longLength; i++) {
                result[i] = array2[i];
            }
        }
        return result;
    }

    /**
     * Generate an alpha-numeric string with specified length based on the given
     * seed.<br>
     * 
     * @param seed
     *            the seed for randomizing. The same seed will give the same
     *            result
     * @param length
     *            length of the generated string
     * @param previousCode
     *            the previously generated code for the seed
     * @return a random alpha-numeric string
     * @throws NoSuchAlgorithmException
     *             when java cannot find encoding method
     */
    public static String generateCode(int seed, int length)
            throws NoSuchAlgorithmException {
        return generateCode(seed, length, null);
    }

    /**
     * Generate another alpha-numeric string with specified length based on the
     * given seed.<br>
     * This should be used when <tt>generateCode(int seed, int length)</tt><br>
     * fails to generate a unique code
     * 
     * @param seed
     *            the seed for randomizing. The same seed and previousCode<br>
     *            will give the same result
     * @param length
     *            length of the generated string
     * @param previousCode
     *            the previously generated code for the seed
     * @return a random alpha-numeric string
     * @throws NoSuchAlgorithmException
     *             when java cannot find encoding method
     */
    public static String generateCode(int seed, int length, String previousCode)
            throws NoSuchAlgorithmException {
        byte[] bytes = null;
        Random random = null;
        int byteLength = 0;
        BigInteger bigInteger = null;
        BigInteger encryptedId = null;
        bytes = encrypt(seed);
        String result = null;
        if (previousCode != null && previousCode.length() > 0) {
            bytes = xorBytes(bytes, previousCode.getBytes());
        }
        encryptedId = new BigInteger(bytes);
        // byteLength = (int) Math.ceil(length * Math.log(36) / Math.log(255));
        byteLength = length;
        bytes = new byte[byteLength * 4];
        random = SecureRandomFactory.getRandom();
        random.setSeed(encryptedId.longValue());
        random.nextBytes(bytes);
        bigInteger = new BigInteger(shortenBytes(bytes, byteLength));
        result = bigInteger.toString(36).toUpperCase();
        if (result.length() > length) {
            result = result.substring(0, length);
        } else if (result.length() < length) {
            bigInteger = new BigInteger(bytes);
            result = bigInteger.toString(36).toUpperCase();
            if (result.length() > length) {
                result = result.substring(0, length);
            } else if (result.length() < length) {
                result = generateCode(seed, byteLength, previousCode);
            }
        }
        return result;
    }

    /**
     * Generate a completely random alpha-numeric string with specified length.
     * 
     * @param length
     *            length of the generated string
     * @return a random alpha-numeric string
     */
    public static String generateCode(int length) {
        byte[] bytes = null;
        Random random = null;
        int byteLength = 0;
        BigInteger bigInteger = null;
        byteLength = length;
        bytes = new byte[byteLength * 4];
        random = SecureRandomFactory.getRandom();
        random.nextBytes(bytes);
        bigInteger = new BigInteger(shortenBytes(bytes, byteLength));
        return bigInteger.toString(36).toUpperCase().substring(0, length);
    }

    public static void main(String[] args) {
        String generatedCode = null;
        List<String> codes = null;
        try {
            codes = new ArrayList<String>();
            for (int i = 0; i < 30000; i++) {
                generatedCode = CryptUtils.generateCode(i, 6);
                if (codes.contains(generatedCode)) {
                    System.out.println("Duplicate at " + i + "!!");
                    generatedCode = CryptUtils
                            .generateCode(i, 6, generatedCode);
                    if (codes.contains(generatedCode)) {
                        System.out.println("Duplicate againt at " + i + "!!");
                        break;
                    } else {
                        codes.add(generatedCode);
                    }
                } else {
                    codes.add(generatedCode);
                }
                System.out.println(generatedCode);
            }
            System.out.println("Finish!");
        } catch (NoSuchAlgorithmException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
}
