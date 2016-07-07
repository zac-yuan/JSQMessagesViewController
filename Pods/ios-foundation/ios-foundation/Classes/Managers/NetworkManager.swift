import Foundation
import Alamofire

@objc public class NetworkManager: NSObject {
    
    public typealias SuccessHandler = (statusCode: Int, jsonData: NSData?) -> ()
    public typealias FailureHandler = (statusCode: Int, error: NSError, jsonData: NSData?) -> ()
    
    @objc public enum ParameterEncoding: Int {
        case URLEncodedInURL
        case JSON
        
        func alamofire() -> Alamofire.ParameterEncoding {
            switch self {
            case .URLEncodedInURL:
                return .URLEncodedInURL
            case .JSON:
                return .JSON
            }
        }
    }
    
    private var manager: Alamofire.Manager
    
    @objc public let baseURL: String
    @objc public var debugPrint: Bool
    @objc public var authToken: String? {
        get {
            var defaultHeaders = self.headers
            return defaultHeaders["x-wsse"] as? String
        }
        set {
            var defaultHeaders = self.headers
            defaultHeaders["x-wsse"] = newValue
            let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
            configuration.HTTPAdditionalHeaders = defaultHeaders
            self.manager = Alamofire.Manager(configuration: configuration)
        }
    }
    @objc public var headers: [NSObject : AnyObject] {
        get {
            return self.manager.session.configuration.HTTPAdditionalHeaders ?? [NSObject : AnyObject]()
        }
        set {
            let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
            configuration.HTTPAdditionalHeaders = newValue
            self.manager = Alamofire.Manager(configuration: configuration)
        }
    }
    @objc public var requestTimeout: Double {
        get {
            let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
            return configuration.timeoutIntervalForRequest
        }
        set {
            let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
            configuration.timeoutIntervalForRequest = newValue
            configuration.HTTPAdditionalHeaders = self.headers
            self.manager = Alamofire.Manager(configuration: configuration)
        }
    }
    @objc public var resourceTimeout: Double {
        get {
            let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
            return configuration.timeoutIntervalForResource
        }
        set {
            let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
            configuration.timeoutIntervalForResource = newValue
            configuration.HTTPAdditionalHeaders = self.headers
            self.manager = Alamofire.Manager(configuration: configuration)
        }
    }
    
    @objc public init(baseURL: String, headers: [NSObject : AnyObject], authToken: String?, requestTimeout: Double = 60, resourceTimeout: Double = 60, debugPrint: Bool = false) {
        self.baseURL = baseURL
        self.debugPrint = debugPrint
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.HTTPAdditionalHeaders = headers
        configuration.timeoutIntervalForResource = resourceTimeout
        configuration.timeoutIntervalForRequest = requestTimeout
        self.manager = Alamofire.Manager(configuration: configuration)
    
        super.init()
    }
    
    @objc public class func defaultHeaders(accept accept: String = "application/json", contentType: String = "application/json", acceptEncoding: String = "gzip;q=1.0,compress;q=0.5", authToken: String = "", timeZone: String = "Europe/London", userAgent: String, appVersion: String, platform: String = "ios") -> [NSObject: AnyObject] {
        var defaultHeaders = Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders ?? [:]
        defaultHeaders["Accept"] = accept
        defaultHeaders["Content-Type"] = contentType
        defaultHeaders["Accept-Encoding"] = acceptEncoding
        defaultHeaders["x-wsse"] = authToken
        defaultHeaders["timezone"] = timeZone
        defaultHeaders["User-Agent"] = userAgent
        defaultHeaders["X-App-Version"] = appVersion
        defaultHeaders["X-Platform"] = platform
        return defaultHeaders
    }
    
    // MARK: - Public
    
    @objc public func get(urlString: String, headers: [String: String]? = nil, parameters: [String : AnyObject]? = nil, encoding: ParameterEncoding =  .URLEncodedInURL, success: SuccessHandler, failure: FailureHandler) {
        self.sendRequest(method: .GET, urlString: urlString, headers: headers, parameters: parameters, encoding: encoding, success: success, failure: failure)
    }
    
    @objc public func head(urlString: String, headers: [String: String]? = nil, parameters: [String : AnyObject]? = nil, encoding: ParameterEncoding =  .URLEncodedInURL, success: SuccessHandler, failure: FailureHandler) {
        self.sendRequest(method: .HEAD, urlString: urlString, headers: headers, parameters: parameters, encoding: encoding, success: success, failure: failure)
    }
    
    @objc public func post(urlString: String, headers: [String: String]? = nil, parameters: [String : AnyObject]? = nil, encoding: ParameterEncoding =  .JSON, success: SuccessHandler, failure: FailureHandler) {
        self.sendRequest(method: .POST, urlString: urlString, headers: headers, parameters: parameters, encoding: encoding, success: success, failure: failure)
    }
    
    @objc public func put(urlString: String, headers: [String: String]? = nil, parameters: [String : AnyObject]? = nil, encoding: ParameterEncoding =  .JSON, success: SuccessHandler, failure: FailureHandler) {
        self.sendRequest(method: .PUT, urlString: urlString, headers: headers, parameters: parameters, encoding: encoding, success: success, failure: failure)
    }
    
    @objc public func patch(urlString: String, headers: [String: String]? = nil, parameters: [String : AnyObject]? = nil, encoding: ParameterEncoding =  .JSON, success: SuccessHandler, failure: FailureHandler) {
        self.sendRequest(method: .PATCH, urlString: urlString, headers: headers, parameters: parameters, encoding: encoding, success: success, failure: failure)
    }
    
    @objc public func delete(urlString: String, headers: [String: String]? = nil, parameters: [String : AnyObject]? = nil, encoding: ParameterEncoding =  .JSON, success: SuccessHandler, failure: FailureHandler) {
        self.sendRequest(method: .DELETE, urlString: urlString, headers: headers, parameters: parameters, encoding: encoding, success: success, failure: failure)
    }
    
    @objc public func formPost(urlString: String, headers: [String: String]? = nil, parameters: [String : AnyObject]? = nil, encoding: ParameterEncoding =  .JSON, success: SuccessHandler, failure: FailureHandler) {
        self.upload(method: .POST, urlString: urlString, headers: headers, parameters: parameters, encoding: encoding, success: success, failure: failure)
    }
    
    @objc public func cancelAllNetworkRequests() {
        self.cancelTasksInSession(self.manager.session)
        self.cancelTasksInSession(Alamofire.Manager.sharedInstance.session)
    }
    
    // MARK: - Private
    
    private func cancelTasksInSession(session: NSURLSession) {
        session.getTasksWithCompletionHandler({ (dataTasks: [NSURLSessionDataTask], uploadTasks: [NSURLSessionUploadTask], downloadTasks: [NSURLSessionDownloadTask]) in
            for task in dataTasks { task.cancel() }
            for task in uploadTasks { task.cancel() }
            for task in downloadTasks { task.cancel() }
        })
    }
    
    private func sendRequest(method method: Alamofire.Method, urlString: String, headers: [String: String]? = nil, parameters: [String : AnyObject]? = nil, encoding: ParameterEncoding, success: (SuccessHandler)? = nil, failure: (FailureHandler)? = nil) {
        
        self.manager.request(method, urlString, parameters: parameters, encoding: encoding.alamofire(), headers: headers).validate().response { [weak self] (request: NSURLRequest?, response: NSHTTPURLResponse?, responseData: NSData?, error: NSError?) -> Void in
            
            if let strongSelf = self where strongSelf.debugPrint == true {
                strongSelf.debugPrint(method, urlString: urlString, params: parameters, baseURL: strongSelf.baseURL, request: request, response: response, responseData: responseData)
            }
            
            if let error = error {
                guard error.code != NSURLErrorCancelled else {
                    return
                }
                
                if let response = response, responseData = responseData {
                    failure?(statusCode: response.statusCode, error: error, jsonData: responseData)
                } else if let response = response {
                    failure?(statusCode: response.statusCode, error: error, jsonData: nil)
                } else {
                    failure?(statusCode: 500, error: error, jsonData: nil)
                }
                return
            }
            
            if let response = response, responseData = responseData {
                success?(statusCode: response.statusCode, jsonData: responseData)
            } else if let response = response {
                success?(statusCode: response.statusCode, jsonData: nil)
            }
        }
    }
    
    private func upload(method method: Alamofire.Method, urlString: String, headers: [String: String]? = nil, parameters: [String : AnyObject]? = nil, encoding: ParameterEncoding, success: (SuccessHandler)? = nil, failure: (FailureHandler)? = nil) {
        self.manager.upload(.POST, urlString, headers: headers, multipartFormData: { (multipartFormData: MultipartFormData) in
            if let parameters = parameters {
                for key in parameters.keys {
                    if let value = parameters[key] as? String, data = value.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
                        multipartFormData.appendBodyPart(data: data, name: key)
                    }
                }
            }
        }, encodingCompletion: { (encodingResult: Manager.MultipartFormDataEncodingResult) in
            switch encodingResult {
            case .Success(let request, _, _):
                request.responseJSON(completionHandler: { (let response: Response<AnyObject, NSError>) in
                    if let statusCode = response.response?.statusCode {
                        switch response.result {
                        case .Success(_):
                            success?(statusCode: statusCode, jsonData: response.data)
                        case .Failure(_):
                            let error = NSError(domain: "\(NetworkManager.self)", code: 0, userInfo: [
                                NSLocalizedDescriptionKey : "upload failed"
                                ])
                            failure?(statusCode: statusCode, error: error, jsonData: nil)
                        }
                    } else {
                        let error = NSError(domain: "\(NetworkManager.self)", code: 0, userInfo: [
                            NSLocalizedDescriptionKey : "response object is nil"
                            ])
                        failure?(statusCode: 500, error: error, jsonData: nil)
                    }
                })
                break
            case .Failure(_):
                let error = NSError(domain: "\(NetworkManager.self)", code: 0, userInfo: [
                    NSLocalizedDescriptionKey : "encoding error"
                    ])
                failure?(statusCode: 500, error: error, jsonData: nil)
                break
            }
        })
    }
    
    private func debugPrint(method: Alamofire.Method, urlString: String, params: [String: AnyObject]?, baseURL: String, request: NSURLRequest?, response: NSHTTPURLResponse?, responseData: NSData?) {
        print("++++++++++++++  Network Request Start \(urlString) ++++++++++++++")
        print("")
        print("__ Request __")
        print("URL: \(request?.URL?.absoluteString ?? "")")
        print("Headers: \(request?.allHTTPHeaderFields ?? [:])")
        print("Parameters: \(params)")
        print("")
        print("__ Response __")
        print("Status:" + String(response?.statusCode) ?? "")
        print("Headers: \(response?.allHeaderFields ?? [:])")
        print("Response Body:")
        
        do {
            if let responseData = responseData {
                let json = try NSJSONSerialization.JSONObjectWithData(responseData, options: .MutableContainers);
                print(json)
            } else {
                print("empty json")
            }
        } catch _ {
            print("couldnt read json")
        }

        print("")
        print("-------------------  Network Request End \(urlString) -------------------")
        print("")
    }
}