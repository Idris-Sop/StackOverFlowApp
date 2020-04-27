//
//  WebServicesManager.swift
//  StackOverFlow App
//
//  Created by Idris Sop on 2020/04/25.
//  Copyright © 2020 SINCO TECHNOLOGY. All rights reserved.
//

import UIKit

public class WebServicesManager: NSObject, WebServicesManagerInterface {

    var reachability: Reachability!
    //MARK: Perform API Call
    public func performServerOperationWithURLRequest(with stringURL: String,
                                                     bodyRequestParameter: [String: Any]?,
                                                     httpMethod: String,
                                                     httpHeaderField: String?,
                                                     success: @escaping (NSData?) -> (),
                                                     failure: @escaping (NSError?) -> ()) {
        if isNetworkReachable() {
            let properlyEncodedString = stringURL.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
            var requestURL = URLRequest(url: URL(string: properlyEncodedString ?? "")!)
            requestURL.httpMethod = httpMethod
            if let authorization = httpHeaderField {
                requestURL.setValue(authorization, forHTTPHeaderField: "Authorization")
            }
            
            //MARK: Set Body Request Parameter
            if let dictionary = bodyRequestParameter {
                if let bodyData = try? JSONSerialization.data(withJSONObject: dictionary) {
                    requestURL.httpBody = bodyData
                    requestURL.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    requestURL.setValue("application/json", forHTTPHeaderField: "Accept")
                }
            }
            
            let gateway = Gateway()
            gateway.executeServerCommunicationWithURLRequest(with: requestURL) { (data, response, error) in
                if let httpResponse = response as? HTTPURLResponse {
                    let statusCode = httpResponse.statusCode
                    if statusCode == 200 ||  statusCode == 201 ||  statusCode == 202 {
                        success(data)
                    } else {
                        failure(error)
                    }
                } else {
                    failure(error!)
                }
            }
        } else {
            var data = [String: Any]()
            data.updateValue("Network error (such as timeout, interrupted connection or unreachable host) has occured", forKey: NSLocalizedDescriptionKey)
            let error = NSError(domain: "", code: 0, userInfo: data)
            failure(error)
        }
    }
    
    public func isNetworkReachable() -> Bool {
        do {
               let remoteHostStatus = try? setupReachability()
                if remoteHostStatus == .unavailable {
                    return false
                }
           } catch {
               print(reachability.connection)
           }
        
        return true
    }
    
    func setupReachability() throws -> Reachability.Connection {
        reachability = try? Reachability()
        startNotifier()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(reachabilityChanged(_:)),
            name: .reachabilityChanged,
            object: reachability
        )
        return self.reachability.connection
    }
    
    @objc func reachabilityChanged(_ note: Notification) {
        let reachability = note.object as! Reachability
        
        if reachability.connection != .unavailable {
        } else {
        }
    }
    
    func startNotifier() {
        do {
            try reachability?.startNotifier()
        } catch {
            return
        }
    }
    
    func stopNotifier() {
        reachability?.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: nil)
        reachability = nil
    }
}
