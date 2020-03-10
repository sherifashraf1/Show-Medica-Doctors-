//
//  DoctorsListTableVC.swift
//  Medica
//
//  Created by Sherif on 3/5/20.
//  Copyright © 2020 Sherif. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import Toast_Swift
class DoctorsListTableVC: UITableViewController {
    
    var myDoctorsData : [ItemDatumList] = []
    lazy var hideNavButton: UIBarButtonItem = {
        return UIBarButtonItem(title: "Hide", style: .done, target: self, action: #selector(dismissDoctorListView))
    }()
    
    @objc func dismissDoctorListView(){
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Doctors List"
        navigationItem.setLeftBarButton(hideNavButton, animated: true)
        let cell = UINib(nibName: "DoctorsTableViewCell", bundle: nil)
        tableView.register(cell.self, forCellReuseIdentifier: "UITabelViewCell")
        loadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myDoctorsData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITabelViewCell", for: indexPath) as! DoctorsTableViewCell
        cell.drName.text = myDoctorsData[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedDoctor = myDoctorsData[indexPath.row]
        let vc = DoctorDetailsVC()
        vc.drName = selectedDoctor.title
        vc.drAddress = selectedDoctor.address
        vc.drInstitution = selectedDoctor.institutionTitle
        vc.drDescription = selectedDoctor.description
        vc.drSpeciality = selectedDoctor.specialty
        vc.drPrice = selectedDoctor.price
        present(vc, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func loadData() {
        let params : [String : String] = [
            "lat" : "31.222229",
            "lng" : "29.949358"
        ]
        let headers : HTTPHeaders = [
            "Content-Type" : "text/plain",
            "Accept" : "application/json",
            "From"   : "c213348c8e34e7dd",
            "User-Agent" : "android",
            "Accept-Language" : "en"
        ]
        self.view.makeToastActivity(.center)
        AF.request(StaticAPIsUrls.drsURl.rawValue, method: .get
            , parameters: params, encoding: URLEncoding.default, headers: headers, interceptor: nil).responseJSON { (response) in
                self.view.hideToastActivity()
                do{
                    let doctors = try JSONDecoder().decode(DoctorsModel.self, from: response.data!)
                    for doctor in doctors.item.data{
                        self.myDoctorsData.append(doctor)
                    }
                    self.tableView.reloadData()
                    
                }catch {
                    print("error",error)
                }
        }
    }
    
}
