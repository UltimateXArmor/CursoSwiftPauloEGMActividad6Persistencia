//
//  EmployeesTableViewController.swift
//  CursoSwiftSeguimiento
//
//  Created by usuario on 1/9/19.
//  Copyright © 2019 usuario. All rights reserved.
//

import UIKit
import CoreData

class EmployeesTableViewController: UITableViewController {

    var employees = [Employee]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var users = [UserObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //self.loadEmployees()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.loadCoreData()
    }
    
    func loadCoreData(){
        let context = appDelegate.persistentContainer.viewContext
        
        //let user = User(context: context)
        //user.name = "Roger"
        //appDelegate.saveContext()
        
        let usersFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "UserObject")
        
        do {
            let fetchedUsers = try context.fetch(usersFetch) as! [UserObject]
            //print(type(of:fetchedUsers))
            self.users.removeAll()
            for item in fetchedUsers{
                print(item.name)
                self.users.append(item)
            }
        } catch {
            fatalError("Failed to fetch users: \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadEmployees(){
        employees.removeAll()
        
        var emp = Employee()
        emp.name = "Diana"
        emp.clientName = "Ramiro"
        emp.clientDebt = 1000.00
        emp.postalCode = "14000"
        emp.isBoss = false
        emp.address = "Calle X #503"
        emp.routeLat = 19.4336523
        emp.routeLon = -99.1354316
        
        employees.append(emp)
        
        emp.name = "Paulo"
        emp.clientName = "Laura"
        emp.clientDebt = 1500.00
        emp.postalCode = "29950"
        emp.isBoss = true
        emp.address = "Calle Z #404"
        emp.routeLat = 19.4336523
        emp.routeLon = -99.1554316
        employees.append(emp)
        
        
        emp.name = "Emmanuel"
        emp.clientName = "Abril Amayrani"
        emp.clientDebt = 1500.00
        emp.postalCode = "14010"
        emp.isBoss = false
        emp.address = "Calle M #104"
        emp.routeLat = 19.4336523
        emp.routeLon = -99.1554316
        employees.append(emp)
        self.tableView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "basicCell") as! UITableViewCell
        guard (self.users.count > indexPath.row) else {
            return cell
        }
        
        let emp = self.users[indexPath.row]
        cell.textLabel?.text = "\(emp.name ?? "")"
        cell.detailTextLabel?.text = "\(emp.email ?? "")"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard (self.users.count > indexPath.row) else {
            return
        }
        
        let emp = self.users[indexPath.row]
        self.performSegue(withIdentifier: "editEmployeeSegue", sender: emp)
        //self.performSegue(withIdentifier: "showRouteSegue", sender: emp)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showRouteSegue"){
            guard let w = segue.destination as? MapRouteViewController, let emp = sender as? Employee else { return }
            w.employee = emp
        }
        
        if (segue.identifier == "editEmployeeSegue"){
            guard let w = segue.destination as? EditEmployeeViewController, let emp = sender as? UserObject else { return }
            w.user = emp
        }
    }
}
