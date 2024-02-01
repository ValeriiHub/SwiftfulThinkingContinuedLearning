//
//  BusinessView.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by User03 on 24.07.2023.
//

import SwiftUI

struct BusinessView: View {
    
    let entity: BusinessEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Name: \(entity.name ?? "")")
                .bold()

            if let departments = entity.departments?.allObjects as? [DepartmentEntity] {
                Text("Departments:")
                    .bold()
                
                ForEach(departments) { department in
                    Text(department.name ?? "")
                }
            }
            
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                Text("Employees:")
                    .bold()
                
                ForEach(employees) { employee in
                    Text(employee.name ?? "")
                }
            }
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.gray.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}
