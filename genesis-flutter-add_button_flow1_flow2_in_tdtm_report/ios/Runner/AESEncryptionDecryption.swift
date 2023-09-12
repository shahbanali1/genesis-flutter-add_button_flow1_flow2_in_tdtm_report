//
//  AESEncryptionDecryption.swift
//  Runner
//
//  Created by Vinod Maurya on 17/11/21.
//

import Foundation

let password = "78AZet%@/*5A"

class AESEncryptionDecryption: NSObject {
    
    internal  func EncryptAstring(_ myString : String) -> String {
        // Encryption
        let string = myString
        let data: Data = string.data(using: String.Encoding.utf8)!
      //  let ciphertext = RNCryptor.encryptData(data, password: password)
          let ciphertext = RNCryptor.encrypt(data: data as Data, withPassword: password)
        print(ciphertext)
        let myBase64String = ciphertext.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0));
        print(myBase64String)
        
        
        return myBase64String
    }
    
    internal  func DecryptAstring(_ encryptedString : String) -> String {
        // Decryption
        print(encryptedString)
        do {
            let decodedData = Data(base64Encoded: encryptedString, options: NSData.Base64DecodingOptions(rawValue: 0))
            if decodedData == nil {
             return "error"
            }
             let originalData = try RNCryptor.decrypt(data: decodedData! as Data, withPassword: password)
           // let originalData = try RNCryptor.decryptData(decodedData!, password: password)
            let decodedString = NSString(data: originalData as Data, encoding: String.Encoding.utf8.rawValue)
            print(decodedString)
            return decodedString! as String
            // ...
        } catch {
            print(error)
            return "error"
        }
       
        }

}
