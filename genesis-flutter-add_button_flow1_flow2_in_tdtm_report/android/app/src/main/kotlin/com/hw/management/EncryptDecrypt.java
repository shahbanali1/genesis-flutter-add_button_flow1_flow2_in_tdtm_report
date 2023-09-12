package com.hw.management;

import android.util.Base64;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.KeyException;
import java.security.NoSuchAlgorithmException;
import java.util.Hashtable;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

public class EncryptDecrypt {
    //public final String SOAP_ACTION = APP_SERVER_URL + "/";
    //public final String WSDL_TARGET_NAMESPACE = APP_SERVER_URL;
    //public final String SOAP_ADDRESS = APP_SERVER_URL;
    private final String characterEncoding = "UTF-8";
    //private final String TAG = ServerRequest.class.getSimpleName();
    private final String cipherTransformation = "AES/CBC/PKCS5Padding";
    private final String aesEncryptionAlgorithm = "AES";
    public Hashtable<String, Object> requestParams = null;

    public EncryptDecrypt() {
        requestParams = new Hashtable<>();
    }

//    public Object Call(String MethodName) {
//        SoapObject request = new SoapObject(WSDL_TARGET_NAMESPACE, MethodName);
//        if (requestParams.size() >= 1) {
//            Set<String> keys = requestParams.keySet();
//            int index = 0;
//            for (String key : keys) {
//                PropertyInfo pi = new PropertyInfo();
//                pi.setName(key);
//                pi.setValue(encrypt(requestParams.get(key).toString(), encKey));
//                request.addProperty(pi);
//            }
//        }
//        SoapSerializationEnvelope envelope = new SoapSerializationEnvelope(SoapEnvelope.VER11);
//        envelope.dotNet = true;
//        envelope.setOutputSoapObject(request);
//        HttpTransportSE httpTransport = new HttpTransportSE(SOAP_ADDRESS, REQUEST_TIMEOUT);
//        Object response;
//        try {
//            httpTransport.call(SOAP_ACTION + MethodName, envelope);
//            response = decrypt(envelope.getResponse().toString(), encKey);
//            return response;
//        } catch (Exception exception) {
//            exception.printStackTrace();
//            response = exception.getMessage() + Common.ErrorCode;
//        }
//        return response;
//    }

    public String encrypt(String plainText, String key) {
        try {
            byte[] plainTextBytes = plainText.getBytes(characterEncoding);
            byte[] keyBytes = getKeyBytes(key);
            return Base64.encodeToString(encrypt(plainTextBytes, keyBytes, keyBytes), Base64.NO_WRAP);
        } catch (Exception ex) {
            ex.printStackTrace();
            return "";
        }
    }

    public String decrypt(String encryptedText, String key) throws
            KeyException, GeneralSecurityException, GeneralSecurityException,
            InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException, IOException {
        byte[] cipheredBytes = Base64.decode(encryptedText, Base64.NO_WRAP);
        byte[] keyBytes = getKeyBytes(key);
        return new String(decrypt(cipheredBytes, keyBytes, keyBytes), characterEncoding);
    }

    private byte[] getKeyBytes(String key) throws UnsupportedEncodingException {
        byte[] keyBytes = new byte[16];
        byte[] parameterKeyBytes = key.getBytes(characterEncoding);
        System.arraycopy(parameterKeyBytes, 0, keyBytes, 0, Math.min(parameterKeyBytes.length, keyBytes.length));
        return keyBytes;
    }

    public byte[] encrypt(byte[] plainText, byte[] key, byte[] initialVector) throws
            NoSuchAlgorithmException, NoSuchPaddingException, InvalidKeyException,
            InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException {
        Cipher cipher = Cipher.getInstance(cipherTransformation);
        SecretKeySpec secretKeySpec = new SecretKeySpec(key, aesEncryptionAlgorithm);
        IvParameterSpec ivParameterSpec = new IvParameterSpec(initialVector);
        cipher.init(Cipher.ENCRYPT_MODE, secretKeySpec, ivParameterSpec);
        plainText = cipher.doFinal(plainText);
        return plainText;
    }

    // Decryption utility
    public byte[] decrypt(byte[] cipherText, byte[] key, byte[] initialVector)
            throws NoSuchAlgorithmException, NoSuchPaddingException, InvalidKeyException,
            InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException {
        Cipher cipher = Cipher.getInstance(cipherTransformation);
        SecretKeySpec secretKeySpecy = new SecretKeySpec(key, aesEncryptionAlgorithm);
        IvParameterSpec ivParameterSpec = new IvParameterSpec(initialVector);
        cipher.init(Cipher.DECRYPT_MODE, secretKeySpecy, ivParameterSpec);
        cipherText = cipher.doFinal(cipherText);
        return cipherText;
    }
}
