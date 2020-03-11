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
    
    func refreshDoctors(){
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        tableView.addSubview(refreshControl!)
    }
    
    @objc func handleRefresh(_ sender : Any){
        refreshControl?.endRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Doctors List"
        navigationItem.setLeftBarButton(hideNavButton, animated: true)
        tableView.registerNib(cell: DoctorsTableViewCell.self)
        loadData()
        refreshDoctors()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myDoctorsData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myDoctorData = myDoctorsData[indexPath.row]
        let cell = tableView.dequeue() as DoctorsTableViewCell
        cell.recieveDoctorInfo(type: .drName, text: myDoctorData.title)
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
        self.view.makeToastActivity(.center)
        AF.request(MedicaURL.drsUrl, method: .get
            , parameters: MedicaURL.drsUrlParams, encoding: URLEncoding.default, headers: MedicaURL.drsUrlHeaders, interceptor: nil).responseJSON { (response) in
                self.view.hideToastActivity()
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do{
                    let doctors = try decoder.decode(DoctorsModel.self, from: response.data!)
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
