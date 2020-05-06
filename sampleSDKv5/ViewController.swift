//
//  ViewController.swift
//  sampleSDKv5
//
//  Created by manji6 on 2019/02/23.
//  Copyright © 2019 manjiro.net. All rights reserved.
//

import ACPCore
import ACPGriffon
import ACPTarget
import ACPAnalytics
import ACPUserProfile

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        //        ACPCore.updateConfiguration(["analytics.rsids": "hogehoge"])
        //        ACPCore.setAdvertisingIdentifier("hoge")
        
        ACPCore.trackState("index", data: ["customkey": "hoge"])
        
        var callbackData = ""
        
        let mboxParameters1 = [
            "status": "sample-mboxParameter"
        ]
        
        // send product data to Target
        let product1 = ACPTargetProduct(id: "example-entity.id", categoryId: "example-entity.categoryId")
        
        // build targetParams object
        let params1 = ACPTargetParameters(parameters: mboxParameters1, profileParameters: nil, product: product1, order: nil)
        
        let request1 = ACPTargetRequestObject(name: "example-mboxNameIndex", targetParameters: params1, defaultContent: "defaultContent", callback: { (_ content: String?) ->  Void in
            // do something with the received content
            callbackData = content!
            print("🎁callback処理")
            print(callbackData)
        })
        
        // Create request object array
        let requestArray = [request1]
        
        // Call the API
        ACPTarget.retrieveLocationContent(requestArray, with: params1)
        
        // Call griffon event
        let griffondlevent = ACPGriffonEvent(vendor: "myapp.hoge.hoge.bus", type: "downloadCustom", payload: ["eventname": "griffonevent", "customValue": mboxParameters1["status"]!])
        ACPGriffon.send(griffondlevent!)
        print("🎁デバッグログです：")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

