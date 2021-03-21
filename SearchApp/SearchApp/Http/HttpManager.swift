//
//  HttpManager.swift
//  SearchApp
//
//  Created by 이아연 on 2021/03/21.
//

import Foundation

class HttpManager : NSObject {
    
    public class func request<T, E>(_ url: String, _ method: String, encodable: E, responseClass:T.Type, completionHandler: @escaping (_ result: T?, _ error: NSError?) -> Void) where T: Decodable, E: Encodable {
        
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(encodable)
            if let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
                
                requestApi(url: url, method : method, param : jsonObject, responseClass: responseClass) { (result, error) in
                    completionHandler(result, error)
                }
            } else {
                completionHandler(nil, nil)
            }
        } catch {
            debugPrint("\(error)")
            completionHandler(nil, error as NSError?)
        }
    }
    
    private class func requestApi<T>(url: String, method : String, param : [String : Any]?, responseClass:T.Type, completionHandler: @escaping (_ result: T?, _ error: NSError?) -> Void) where T: Decodable {
        
        let parameter: [String: Any] = param != nil ? param! : [:]
        switch method {
        case "GET" :
          
            var urlComponents = URLComponents(string: url)
        
            var urlQueryItems: [URLQueryItem] = []
            for (key, value) in parameter {
                urlQueryItems.append(URLQueryItem(name: key, value: String(describing: value)))
            }

            if urlQueryItems.count > 0 {
                urlComponents?.queryItems = urlQueryItems
            }
            
            guard let url = urlComponents?.url else {
                completionHandler(nil, NSError(domain: "Invalid url", code: -1, userInfo: nil))
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = method
           
            startRequest(req : request, responseClass : responseClass, completionHandler : completionHandler)
            
        case "POST" :
            guard let url = URL(string: url) else {
                print("Error: cannot create URL")
                return
            }

            let sendData = try! JSONSerialization.data(withJSONObject: parameter, options: [])
            
            var request = URLRequest(url: url)
            request.httpMethod = method
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = sendData
            
            startRequest(req : request, responseClass : responseClass, completionHandler : completionHandler)
        default :
            break
        }
    }

    private class func startRequest<T>(req : URLRequest ,responseClass: T.Type, completionHandler: @escaping (_ result: T?, _ error: NSError?) -> Void) where T: Decodable {
        
        print(req.url as Any)
        URLSession.shared.dataTask(with: req) { data, response, error in
            guard error == nil else {
                print("Error: error calling Method")
                DispatchQueue.main.async {
                    completionHandler(nil, error as NSError?)
                }
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                DispatchQueue.main.async {
                    completionHandler(nil,nil)
                }
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                DispatchQueue.main.async {
                    completionHandler(nil,nil)
                }
                return
            }
            
            do {
                let result = try JSONDecoder().decode(responseClass, from: data)
                DispatchQueue.main.async {
                    completionHandler(result, nil)
                }
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
                completionHandler(nil, error as NSError?)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
                completionHandler(nil, error as NSError?)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
                completionHandler(nil, error as NSError?)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
                completionHandler(nil, error as NSError?)
            } catch {
                print("error: ", error)
                completionHandler(nil, error as NSError?)
            }
            
            
            
        }.resume()
        
    }


}
