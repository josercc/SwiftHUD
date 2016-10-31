//
//  ViewController.swift
//  SwiftHUD
//
//  Created by 张行 on 16/8/9.
//  Copyright © 2016年 张行. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var tableView:UITableView?

    var style:Array<SwiftString> = [SwiftString]()

    var hud:SwiftHUD?

    override func viewDidLoad() {
        super.viewDidLoad()
        style.append(SwiftString(string: "Show Default Text", complete: { () in
            self.hud = SwiftHUD.show()
        }))

        style.append(SwiftString(string: "Show Custom Text", complete: { () in
            self.hud = SwiftHUD.show("Show Custom Text")
        }))

        style.append(SwiftString(string: "Show Long Lenght Custom Text", complete: { () in
            self.hud = SwiftHUD.show("Show Long Lenght Custom Text,Show Long Lenght Custom Text,Show Long Lenght Custom Text,Show Long Lenght Custom Text,Show Long Lenght Custom Text")
        }))

        style.append(SwiftString(string: "Show Custom Text In Custom View", complete: { () in
            self.hud = SwiftHUD.show("Show Custom Text In Custom View", view: self.view)
        }))


        style.append(SwiftString(string: "Show Default Text Loading Style", complete: { () in
            self.hud = SwiftHUD.show("Show Default Text Loading Style", view: self.view, style: SwiftHUDStyle.loading)
        }))

        style.append(SwiftString(string: "Show Default Text Error Style", complete: { () in
            self.hud = SwiftHUD.show("Show Default Text Error Style", view: self.view, style: SwiftHUDStyle.error)
        }))

        style.append(SwiftString(string: "Show Default Text Success Style", complete: { () in
            self.hud = SwiftHUD.show("Show Default Text Success Style", view: self.view, style: SwiftHUDStyle.success)
        }))

        style.append(SwiftString(string: "Show Default Text Info Style", complete: { () in
            self.hud = SwiftHUD.show("Show Default Text Info Style", view: self.view, style: SwiftHUDStyle.info)
        }))

        style.append(SwiftString(string: "Show Default Text After Dismiss Complete", complete: { () in
            self.hud = SwiftHUD.show("Show Default Text After Complete", view: self.view, style: SwiftHUDStyle.none, after: 2, complete: { (hud) in
                UIAlertView(title: "This is Alert", message: nil, delegate: nil, cancelButtonTitle: "OK").show()

            })
        }))

        style.append(SwiftString(string: "Hide No Text", complete: { () in
            self.hud?.hide()
        }))

        style.append(SwiftString(string: "Hide Show Text After Dismiss Default ", complete: { () in
            self.hud?.hide("Hide Show Text After Dismiss Default ")
        }))

        style.append(SwiftString(string: "Hide Show Text After Dismiss Custom 3 second", complete: { () in
            self.hud?.hide("Hide Show Text After Dismiss Custom 3 second", after: 3)
        }))

        style.append(SwiftString(string: "Hide Show Text After Dismiss Custom 3 second After Complete", complete: { () in
            self.hud?.hide("Hide Show Text After Dismiss Custom 3 second After Complete", after: 3, complete: { (hud) in
                UIAlertView(title: "This is Alert", message: nil, delegate: nil, cancelButtonTitle: "OK").show()
            })
        }))

        self.tableView = UITableView(frame: CGRect.zero, style: .plain)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.view.addSubview(self.tableView!)

        self.tableView!.snp_makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
            
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        cell.textLabel?.text = style[(indexPath as NSIndexPath).row].string
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.font = UIFont.systemFont(ofSize: 12)
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return style.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let string:SwiftString = style[(indexPath as NSIndexPath).row]
        string.toComplete()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

typealias SwiftStringComplete = (Void) -> Void

class SwiftString {
    var string:String
    var complete:SwiftStringComplete
    init(string:String, complete:@escaping SwiftStringComplete) {
        self.string = string
        self.complete = complete
    }

    func toComplete()  {
        self.complete()
    }
}
