//
//  NetworkClass.swift
//  AbjjadChartTest
//
//  Created by Mohamed Sadek on 24/08/2022.
//

import Alamofire
import UIKit
typealias JSON = [String : Any]
typealias JSONArray = [JSON]

struct NetworkingManager {
    
    static let shared: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        let sessionManager = Alamofire.SessionManager(configuration: configuration)
        return sessionManager
    }()
}

//MARK:- Send Request
/**
 This Function is used as an abstract to handle API requests using Alamofire
 - parameter method: The HTTP Methoud To Use
 - parameter param: this is a Dictionary contains all data that you need to send this request
 - parameter closure: This is the final result that you can get data from request using it
 */
class NetworkClass {
    class func sendRequestUsingAlamofire(method: HTTPMethod, fullURL: String, param: [String: Any] , closure: @escaping ([String: Any]?,_ statusCode: Int?) -> Void){
        
#if DEBUG
        print("URL:\(fullURL)")
#endif
        
        let jsonData = try! JSONSerialization.data(withJSONObject: param, options: [])
        let decoded = String(data: jsonData, encoding: .utf8)!
        print("Body" , decoded)
        
        
        Alamofire.request(fullURL, method: method, parameters: param, encoding: URLEncoding.default, headers: [:]).responseJSON { response in
            
            
#if DEBUG
            //print("Response: \(response.result.value)")
#endif
            switch response.result{
            case .success(_):
                if let res = response.result.value as? JSON{
                    //     print(res)
                    closure(["data": res], response.response?.statusCode)
                }else if let res = response.result.value as? JSONArray{
                    closure(["data": res], response.response?.statusCode)
                }else{
                    closure(nil, response.response?.statusCode)
                }
                guard let statusCode = response.response?.statusCode else {return}
                switch statusCode {
                case 401:
                    print("Success with 401 error")
                case 403,404:
                    print("Success with 403,404 error")
                case 500 ... 599:
                    AlertUtility.showInternalServerAlert()
                default:
                    break
                }
                
            case .failure(_):
                
                if let res = response.result.value as? [String: Any]{
                    closure(res, response.response?.statusCode)
                }else{
                    closure(nil, response.response?.statusCode)
                }
                guard let statusCode = response.response?.statusCode else {return}
                switch statusCode {
                case 401:
                    print("Failure with 403,404 error")
                case 403,404:
                    print("Failure with 403,404 error")
                case 500 ... 599:
                    AlertUtility.showInternalServerAlert()
                default:
                    break
                }
            }
        }
    }
}
