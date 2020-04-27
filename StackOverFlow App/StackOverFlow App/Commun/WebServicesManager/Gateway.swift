//
//  Gateway.swift
//  StackOverFlow App
//
//  Created by Idris Sop on 2020/04/25.
//  Copyright © 2020 SINCO TECHNOLOGY. All rights reserved.
//

import UIKit

typealias GatewayCompletionBlock = (_ success: NSData?, _ response: URLResponse?, _ error: NSError?) -> Void

class Gateway: NSObject {
    
    private var session: URLSession?
    
    override init() {
        super.init()
        
        //MARK: Instantiate Session Configuration
        let sessionConfiguration = URLSessionConfiguration.default
        let operationQueue = OperationQueue.main
        sessionConfiguration.httpMaximumConnectionsPerHost = 5
        sessionConfiguration.requestCachePolicy = .reloadIgnoringLocalCacheData
        sessionConfiguration.timeoutIntervalForRequest = 60.0
        sessionConfiguration.timeoutIntervalForResource = 60.0
        self.session = URLSession(configuration: sessionConfiguration, delegate: self, delegateQueue: operationQueue)
    }
    
    //MARK: Execute HTTP Communication with Server
    func executeServerCommunicationWithURLRequest(with requestURL: URLRequest,
                                                  callBack: @escaping GatewayCompletionBlock) {
        let dataTask = session?.dataTask(with: requestURL) { (data, responseURL, error) in
            callBack(data as NSData?, responseURL, error as NSError?)
        }
        dataTask?.resume()
    }
}

extension Gateway: URLSessionDelegate {
    
}
