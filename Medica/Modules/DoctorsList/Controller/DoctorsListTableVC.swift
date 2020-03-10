//
//  DoctorsListTableVC.swift
//  Medica
//
//  Created by Sherif on 3/5/20.
//  Copyright © 2020 Sherif. All rights reserved.
//

import UIKit
import CoreLocation
class DoctorsListTableVC: UITableViewController {
    
    var myDoctorsData : [ItemDatumList] = []
    lazy var hideNavButton: UIBarButtonItem = {
        return UIBarButtonItem(title: "Hide", style: .done, target: self, action: #selector(dismissDoctorListView))
    }()
    
    @objc func dismissDoctorListView(){
        dismiss(animated: true, completion: nil)
        hideActivityIndicator()
    }
 
    var spinner: UIActivityIndicatorView?

    func showActivityIndicator() {
        spinner = UIActivityIndicatorView(style: .gray)
        spinner?.color = .black
        spinner?.center = self.view.center
        spinner?.hidesWhenStopped = true
        spinner?.scaleIndicator(factor: 2)
        self.view.addSubview(spinner!)
        spinner?.startAnimating()
    }
    
     func hideActivityIndicator(){
        if (spinner != nil){
            spinner?.stopAnimating()

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Doctors List"
        navigationItem.setLeftBarButton(hideNavButton, animated: true)
        showActivityIndicator()
        let cell = UINib(nibName: "DoctorsTableViewCell", bundle: nil)
        tableView.register(cell.self, forCellReuseIdentifier: "UITabelViewCell")
        doctorsDataGet(){}
    }

    func doctorsDataGet(completed:()->())  {
        
        guard let  url = URL(string: "http://medicahealthy.net/api/institutions?lat=31.222229&lng=29.949358") else { return  }
        var request = URLRequest(url: url)
        request.addValue("text/plain", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("c213348c8e34e7dd", forHTTPHeaderField: "From")
        request.addValue("android", forHTTPHeaderField: "User-Agent")
        request.addValue("en", forHTTPHeaderField: "Accept-Language")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil{
                do{
                    let root = try JSONDecoder().decode(DoctorsModel.self, from: data!)

                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        for doctor in root.item.data{
                            self.myDoctorsData.append(doctor)
                        }
                        print("arrDoctorsData: \(self.myDoctorsData)")
                        self.tableView.reloadData()
                    }
                    
                }catch {
                    print("error",error)
                }
            }
            }.resume()
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
            vc.drInstitution = selectedDoctor.institution_title
            vc.drDescription = selectedDoctor.description
            vc.drSpeciality = selectedDoctor.specialty
            vc.drPrice = selectedDoctor.price
            present(vc, animated: true, completion: nil)
        }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
