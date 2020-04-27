//
//  WebServicesManagerInterface.swift
//  StackOverFlow App
//
//  Created by Idris Sop on 2020/04/25.
//  Copyright © 2020 SINCO TECHNOLOGY. All rights reserved.
//

import UIKit

typealias WebServiceManagerSuccessBlock = (_ data: NSData) -> Void
typealias WebServiceManagerFailureBlock = (_ error: NSError?) -> Void

protocol WebServicesManagerInterface {

    //MARK: Perform API Call Interface
    func performServerOperationWithURLRequest(with stringURL: String,
                                              bodyRequestParameter: [String: Any]?,
                                              httpMethod: String,
                                              httpHeaderField: String?,
                                              success: @escaping (NSData?) -> (),
                                              failure: @escaping (NSError?) -> ())
}
