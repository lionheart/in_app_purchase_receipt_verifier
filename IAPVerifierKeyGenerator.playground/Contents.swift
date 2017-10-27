//: ## Signing Key Generator
/*:
 This playground contains helper methods to quickly generate a valid 2048-bit RSA key. The web app will use this key to sign the data it sends back to your app, and your app will use the public key to verify that the data has not been tampered with.
 */
import UIKit

let privateKey: String
let publicKey: String
do {
    (privateKey, publicKey) = try SecKey.generateBase64Encoded2048BitRSAKey()
} catch {
    fatalError()
}

print("Private key: ")
print(privateKey)
print()
print("Public key: ")
print(publicKey)
