//
//  CoreDataReletionsheepBootcamp16.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by User03 on 23.07.2023.
//

import SwiftUI
import CoreData

class CoreDataReletionsheepViewModel: ObservableObject {
    
    let manager = CoreDataManager()
    
    @Published var businesses: [BusinessEntity] = []
    @Published var departments: [DepartmentEntity] = []
    @Published var empoyees: [EmployeeEntity] = []
    
    init() {
        getBusiness()
        getDepartments()
        getEmployees()
//        getEmployees(forBusiness: businesses[0])
        
    }
    
    func save() {
        manager.save()
        getBusiness()
    }
    
    // FETCH
    func getBusiness() {
        let request = NSFetchRequest<BusinessEntity>(entityName: "BusinessEntity")
        
        let sort = NSSortDescriptor(keyPath: \BusinessEntity.name, ascending: true)   // сортируем полученные данные по имени
        request.sortDescriptors = [sort]
        
        let filter = NSPredicate(format: "name == %@", "Apple")                       // фильтруем полученные данные по имени
        request.predicate = filter
        
        do {
            businesses = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching. \(error.localizedDescription)")
        }
    }
    
    func getDepartments() {
        let request = NSFetchRequest<DepartmentEntity>(entityName: "DepartmentEntity")
        
        do {
            departments = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching. \(error.localizedDescription)")
        }
    }
    
    func getEmployees() {
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        
        do {
            empoyees = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching. \(error.localizedDescription)")
        }
    }
    
    func getEmployees(forBusiness business: BusinessEntity) {
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        
        let filter = NSPredicate(format: "business == %@", business)
        request.predicate = filter
        
        do {
            empoyees = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching. \(error.localizedDescription)")
        }
    }
    
    // ADD
    func addBusiness() {
        let newBusiness = BusinessEntity(context: manager.context)
        newBusiness.name = "Facebook"
        
        
//         // add existing departments to the new business
//         newBusiness.departments = [departments[0], departments[1]]
//
//         // add existing employees to the new business
//         newBusiness.employees = [empoyees[1]]
//
//         // add new business to the existing department
//         newBusiness.addToDepartments(<#T##value: DepartmentEntity##DepartmentEntity#>)
//
//         // add new business to existing employee
//         newBusiness.addToEmployees(<#T##value: EmployeeEntity##EmployeeEntity#>)
         
        
        save()
    }
    
    func addDepartment() {
        let newDepartment = DepartmentEntity(context: manager.context)
        newDepartment.name = "Finance"
        newDepartment.businesses = [businesses[0], businesses[1], businesses[2]]
//        newDepartment.employees = [empoyees[1]]
        newDepartment.addToEmployees(empoyees[1])
        save()
    }
    
    func addEmployee () {
        let newEmployee = EmployeeEntity(context: manager.context)
        newEmployee.name = "John"
        newEmployee.age = 21
        newEmployee.dateJoined = Date()
        newEmployee.business = businesses[2]
        newEmployee.department = departments[1]
        
        save()
    }
    
    // UPDATE
    func updateBusines() {
        let existingBusiness = businesses[2]
        existingBusiness.addToDepartments(departments[1])
        save()
    }
    
    // DELETE
    func deleteDepartment() {
        let department = departments[2]
        manager.context.delete(department)
        
        save()
    }
}

struct CoreDataReletionsheepBootcamp16: View {
    
    @StateObject var vm = CoreDataReletionsheepViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Button {
//                        vm.addBusiness()
//                        vm.addDepartment()
//                        vm.addEmployee()
//                        vm.updateBusines()
                        vm.deleteDepartment()
                    } label: {
                        Text("Perform Action")
                            .foregroundColor(.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue.cornerRadius(10))
                    }
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top) {
                            ForEach(vm.businesses) { business in
                                BusinessView(entity: business)
                            }
                        }
                    }
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top) {
                            ForEach(vm.departments) { department in
                                DepartmentView(entity: department)
                            }
                        }
                    }
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top) {
                            ForEach(vm.empoyees) { empoyee in
                                EmployeeView(entity: empoyee)
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Relationships")
        }
    }
}

struct CoreDataReletionsheepBootcamp16_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataReletionsheepBootcamp16()
    }
}

