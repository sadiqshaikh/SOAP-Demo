//
//  MINetworkClass.swift
//  SOApLib
//
//  Created by Sadiq on 11/03/16.
//  Copyright © 2016 Demo. All rights reserved.
//

import Cocoa

enum APIS : String{
    case API_GetCitiesByCountry = "http://www.webserviceX.NET/GetCitiesByCountry"
}

let soapURL = "http://www.webservicex.com/globalweather.asmx"

enum Router: URLRequestConvertible {
    static let baseURLString = soapURL
    static var OAuthToken: String?
    
    case GetCitiesByCountry(String)
    var method: Method {
        switch self {
        case .GetCitiesByCountry:
            return .POST
        }
    }
    
    var soapMessage : String {
        switch self {
        case .GetCitiesByCountry(let country):
            let xml = XMLElement(name: "soap:Envelope")
            xml.attributes = ["xmlns:xsi":"http://schemas.xmlsoap.org/soap/envelope/","xmlns:xsd":"http://www.w3.org/2001/XMLSchema","xmlns:soap":"http://schemas.xmlsoap.org/soap/envelope/"]
            let body = xml.addElement("soap:Body", withAttributes: NSDictionary())
            let doc = body.addElement("GetCitiesByCountry", withAttributes: ["xmlns":"http://www.webserviceX.NET"])
            doc.addElement("CountryName", withAttributes: NSDictionary()).addText(country)
            return xml.description
            
        }
        
        
    }
    
    var soapAction : String {
        switch self {
        case .GetCitiesByCountry:
            return APIS.API_GetCitiesByCountry.rawValue
        default:
            return ""
        }
    }
    
    
    // MARK: URLRequestConvertible
    
    var URLRequest: NSMutableURLRequest {
        let URL = NSURL(string: Router.baseURLString)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL)
        mutableURLRequest.HTTPMethod = method.rawValue
        mutableURLRequest.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        //            mutableURLRequest.addValue(soapAction, forHTTPHeaderField: "SOAPAction")
        let data = soapMessage.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        let msgLength  = String(soapMessage.characters.count)
        mutableURLRequest.addValue(msgLength, forHTTPHeaderField: "Content-Length")
        //        mutableURLRequest.addValue(soapAction, forHTTPHeaderField: "SOAPAction")
        mutableURLRequest.HTTPBody = data
        
        return mutableURLRequest
        
    }
}

class MINetworkClass: NSObject {
    
}
