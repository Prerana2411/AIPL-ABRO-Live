//
//  WebServiceDelegates.swift
//  AIPL ABRO
//
//  Created by CST on 23/01/20.
//  Copyright © 2020 promatics. All rights reserved.
//

import Foundation
@objc protocol WebServiceDelegates:class {
    
    @objc optional func didGetResponse(inResponse: AnyObject,withRequest:String)
    @objc optional func didImageUploaded(inResponse : AnyObject,withRequest:String)
    @objc optional func didImageDownloaded(inData: AnyObject,withRequest:String)
    @objc optional func didGetError(inError : AnyObject)
    
}
