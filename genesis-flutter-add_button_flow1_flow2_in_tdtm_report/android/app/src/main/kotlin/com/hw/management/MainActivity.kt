package com.hw.management

import io.flutter.embedding.android.FlutterActivity

import android.util.Log;

import androidx.annotation.NonNull;

import java.io.IOException;
import java.security.GeneralSecurityException;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;


class MainActivity: FlutterActivity() {

    private val methodChannelName = "flutter_to_native"
    private val methodEncrypt = "encrypt"
    private val methodDecrypt = "decrypt"
    private val encryptionKey = "78AZet%@/*5A"
    val encryptDecrypt:EncryptDecrypt = EncryptDecrypt()

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, methodChannelName)
            .setMethodCallHandler { call, result ->
                run {
                    if (call.method.equals(methodEncrypt, true)) {
                        val data: String? = call.argument("data")
                        result.success(encryptDecrypt.encrypt(data, encryptionKey))
                    }else if (call.method.equals(methodDecrypt,true)){
                        val data: String? = call.argument("data")
                        result.success(encryptDecrypt.decrypt(data,encryptionKey))
                    }
                }
            }
    }

}
