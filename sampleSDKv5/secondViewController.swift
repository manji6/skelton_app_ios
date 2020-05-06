//
//  secondViewController.swift
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

class secondViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.cyan        
        

        // Do any additional setup after loading the view, typically from a nib.
        //        ACPCore.updateConfiguration(["analytics.rsids": "hogehoge"])
        //        ACPCore.setAdvertisingIdentifier("hoge")

        ACPCore.trackState("second", data: ["customkey2": "fuga"])
        let mboxParameters1 = [
            "status": "sample-mboxParameter"
        ]
        let product1 = ACPTargetProduct(id: "example-entityId", categoryId: "example-entity.categoryId")
        let order1 = ACPTargetOrder(id: "example-entityId", total: NSNumber(value: 1080), purchasedProductIds: ["example-entityId1", "example-entityId2"])
                
        let params1 = ACPTargetParameters(parameters: mboxParameters1, profileParameters: nil, product: product1, order: order1)
        let request1 = ACPTargetRequestObject(name: "example-mboxNameSecondView", targetParameters: params1, defaultContent: "defaultContent", callback: { (_ content: String?) ->  Void in
            // do something with the received content
            print("🎁callback処理")
            print(content!)
        })
        
        // Create request object array
        let requestArray = [request1]
        
        // Call the API
        ACPTarget.retrieveLocationContent(requestArray, with: params1)
        

    }
}

