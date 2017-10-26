//: ## Signing Key Generator
/*:
 This playground contains helper methods to quickly generate a valid 2048-bit RSA key. The web app will use this key to sign the data it sends back to your app, and your app will use the public key to verify that the data has not been tampered with.
 */
import UIKit
let privateKey = try! Key()

// Copy the value of `privateKeyString` into the Heroku Deploy field for `B64_ENCODED_SIGNING_KEY`.
let privateKeyString = (try! Data(key: privateKey)).base64EncodedString()
print(privateKeyString)

// Derive the public key. Use this value in your iOS app to verify that the payload from the web app is valid.
let publicKeyString = (try! Data(key: privateKey.publicKey!)).base64EncodedString()
print(publicKeyString)

//: Here's an example for how you might validate the signature in your app.
//let publicKeyString = "MIIBCgKCAQEArZCqOKSEUyeOF//WL+61slkwlAqjFQ++g2kX2LS08e1F/ZFyhU7AzBSR1TLxjg/Nl9a1JjaAbboYFXtdL4cxE+6UE41VxWMZ+fk3jVeFVGaqEXZy6zaPJ9Kr4g5mQyce0JCh24GQTeTz7HDahfny0trQOxajgYhG0WfpSXDqosvH7e1mtIkfz5euS29FfW5aXVslfs2heQTVmh9EbDy/cn4uf5b0gkN4w+oMj7AHK8mwwQMYjTNF9bHJxgRjWE0eUwi6JbvX8/n6ZAB2AvDc0gg0URfM00rEDc+0rTZ7ArncBGTSU8yHrhrNZ31PmcAgoHMk7OtrB25dFFXILIBKgwIDAQAB"
let key: Key = try! Key(base64EncodedString: publicKeyString, keyClass: .public)

// This is the signature of the payload, provided in the header `X-Signature`:
let signatureBase64 = "DO+1fR285NYRUPhqjyCZyRQMo372AVNEpEh5J8gghQNw7XjLAbrCXVLCLeMMkkkDm7VSoDZEZbwMMauxtxnmRQVQkF2pFdHcLjadcvHcPO2vSws2OwhMss6E+D6IsYqU0e2zLPzgQ3RT5F6hbkU4YQTklpMjh8ciRE6iekZUdiGUVme+tZ8yYJx54Lza4yeai10AD6Bdr12+wzzuldkcZOdUxYjcu4sJ44VtmgBPveZVULSSjPX+mtQ/5mOWGpbYCjmDQPHXqKgkbEt+AhSGZDueUa5UbFBk/RwbjNj4//IfZ31k7KD9npeAgzI3FYuK7VAX2euB5PJ0K0IHpxeqFA=="
let signatureData = Data(base64Encoded: signatureBase64)!

// This is the JSON payload of the server, converted to a `String`.
let payload = "{\"status\": 21002}"
var data = (payload as NSString).data(using: String.Encoding.utf8.rawValue)!

let isSignatureValid = key.validateSignature(data: data, signature: signatureData)
