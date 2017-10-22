[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

# In-App Purchase Receipt Verifier

A simple, one-click deploy web app to simplify the process of validating In-App Purchase receipts on the App Store.

## Usage

1. Create the project on [Heroku](https://heroku.com) using the Deploy Button above. Before you do, make sure that you've already obtained an app-specific shared secret for authentication on iTunes Connect.

2. Use something like the following in your iOS app to validate your receipts.

    ```swift
    guard let receiptURL = Bundle.main.appStoreReceiptURL,
        let data = try? Data(contentsOf: receiptURL) else {
          return
    }

    let encodedData = data.base64EncodedData(options: [])
    let url = URL(string: "https://your-app.herokuapp.com/verify")!

    var request = URLRequest(url: url)
    request.httpBody = encodedData
    request.httpMethod = "POST"

    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        guard let data = data,
            let object = try? JSONSerialization.jsonObject(with: data, options: []),
            let json = object as? [String: Any] else {
                return
        }

        // Your application logic here.
    }
    task.resume()
    ```

3. Yep, that's it. There's no step 3!

## Local Testing

```
curl -X POST -T receipt https://your-app.herokuapp.com/verify
```

...where `receipt` is a file with base-64 encoded receipt data.

