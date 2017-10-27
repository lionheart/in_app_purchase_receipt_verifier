import Foundation

public extension SecKey {
    static func generateBase64Encoded2048BitRSAKey() throws -> (private: String, public: String) {
        let type = kSecAttrKeyTypeRSA
        let attributes: [String: Any] =
            [kSecAttrKeyType as String: type,
             kSecAttrKeySizeInBits as String: 2048
        ]

        var error: Unmanaged<CFError>?
        guard let key = SecKeyCreateRandomKey(attributes as CFDictionary, &error),
            let data = SecKeyCopyExternalRepresentation(key, &error) as Data?,
            let publicKey = SecKeyCopyPublicKey(key),
            let publicKeyData = SecKeyCopyExternalRepresentation(publicKey, &error) as Data? else {
                throw error!.takeRetainedValue() as Error
        }

        return (private: data.base64EncodedString(), public: publicKeyData.base64EncodedString())
    }
}
