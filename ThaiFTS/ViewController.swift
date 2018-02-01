//
//  ViewController.swift
//  ThaiFTS
//
//  Created by Siriwat Uamngamsup on 31/1/2018 AD.
//  Copyright © 2018 Siriwat Uamngamsup. All rights reserved.
//

import UIKit

class Content {
    var id: Int32
    var title: String
    var body: String
    
    init(id: Int32, title: String, body: String) {
        self.id = id
        self.title = title
        self.body = body
    }
}

class MyViewCell: UITableViewCell {
    @IBOutlet var title: UILabel!
    @IBOutlet var body: UILabel!
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var rows: [Content] = []
    @IBOutlet weak var contentsListView: UITableView!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let db = ThaiFTSDatabase.shared

        do {
            let rs = try db.executeQuery("select count(*) as cnt from content_th where content_th match ?", values: ["สาว"])

            if rs.next() {
                return Int(rs.int(forColumn: "cnt"))
            }
        } catch {
            print("failed: \(error.localizedDescription)")
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "row") as! MyViewCell
        let content = rows[indexPath.row]
        
        cell.title.text = content.title
        cell.body.text = content.body
        
        return cell
    }

    @IBAction func BtnClick(_ sender: Any) {
        let db = ThaiFTSDatabase.shared
        try! db.executeUpdate("insert into content_th (id, title, body) values (?, ?, ?)", values: [1, "article book simulate", "สองสาวสุดแสนสวยใส่เสื้อสีแสดสวมสร้อยสี่แสนสามสิบเส้นส้นสูงสีส้มเสื้อสูทสีแสบสันสาดส่องแสงสีสดใส 1"])
        try! db.executeUpdate("insert into content_th (id, title, body) values (?, ?, ?)", values: [2, "article robot universe", "ตัดคำได้ดีมาก 2"])
        
        reloadDatasource()
        contentsListView.reloadData()
    }
    
    func reloadDatasource() {
        let db = ThaiFTSDatabase.shared
        
        do {
            let rs = try db.executeQuery("select * from content_th where content_th match ?", values: ["สาว"])
            while rs.next() {
                let content = Content(id: rs.int(forColumn: "id"), title: rs.string(forColumn: "title")!, body: rs.string(forColumn: "body")!)
                rows.append(content)
            }
        } catch {
            print(error)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        reloadDatasource()
    }

    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    }



}
