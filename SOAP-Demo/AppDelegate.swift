//
//  AppDelegate.swift
//  SOAP-Demo
//
//  Created by Sadiq on 11/04/16.
//  Copyright © 2016 Demo. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        getCities()
    }

    
    func getCities(){

        
        request(Router.GetCitiesByCountry("india")).response { _, _, data, _ in
            if let
                data = data,
                str = NSString(data: data, encoding: NSUTF8StringEncoding)
            {
                let xml = SWXMLHash.parse(str as String)
                print("Data: \(str))")
                
                var obj = xml.children.first
                repeat {
                    obj = obj!.children[0]
                    if obj?.children.count > 1 {
                        obj = obj!.children[1]
                    }
                    print(obj?.element?.name)
                } while obj?.element?.name != "GetCitiesByCountryResult"
                
                var final = obj?.element
                print("Data: \(final))")
            }
        }
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

