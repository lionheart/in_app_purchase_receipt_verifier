import Foundation

public extension Data {
    init(key: Key) throws {
        var error: Unmanaged<CFError>?
        guard let data = SecKeyCopyExternalRepresentation(key.key, &error) as Data? else {
            throw error!.takeRetainedValue() as Error
        }

        self = data
    }
}

public struct Key {
    var key: SecKey

    public var publicKey: Key? {
        guard let _key = SecKeyCopyPublicKey(key) else {
            return nil
        }

        return Key(key: _key)
    }

    public enum KeyClass {
        case `public`
        case `private`

        var rawValue: CFString {
            switch self {
            case .public: return kSecAttrKeyClassPublic
            case .private: return kSecAttrKeyClassPrivate
            }
        }
    }

    public init() throws {
        let type = kSecAttrKeyTypeRSA
        let attributes: [String: Any] =
            [kSecAttrKeyType as String: type,
             kSecAttrKeySizeInBits as String: 2048
        ]

        var error: Unmanaged<CFError>?
        guard let key = SecKeyCreateRandomKey(attributes as CFDictionary, &error) else {
            throw error!.takeRetainedValue() as Error
        }

        self.key = key
    }

    public init(key: SecKey) {
        self.key = key
    }

    public init(base64EncodedString string: String, keyClass: KeyClass) throws {
        let keyData = Data(base64Encoded: string)!

        let options: [String: Any] = [kSecAttrKeyType as String: kSecAttrKeyTypeRSA,
                                      kSecAttrKeyClass as String: keyClass.rawValue,
                                      kSecAttrKeySizeInBits as String: 2048]
        var error: Unmanaged<CFError>?
        guard let key = SecKeyCreateWithData(keyData as CFData, options as CFDictionary, &error) else {
            throw error!.takeRetainedValue() as Error
        }

        self.key = key
    }

    public func validateSignature(data: Data, signature: Data, algorithm: SecKeyAlgorithm = .rsaSignatureMessagePKCS1v15SHA256) -> Bool {
        var error: Unmanaged<CFError>?
        guard SecKeyVerifySignature(key, algorithm, data as CFData, signature as CFData, &error) else {
            return false
        }

        return true
    }
}
