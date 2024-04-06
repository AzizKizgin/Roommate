//
//  DateInput.swift
//  Roommate
//
//  Created by Aziz Kızgın on 6.04.2024.
//

import SwiftUI
struct DateInput: View {
    @State private var showCalendar: Bool = false
    @Binding var date: Date
    
    var body: some View {
        TextField("Birth Date", text: .constant(Utils.dateToString(date: date)))
            .disabled(true)
            .capsuleTextField(icon: "calendar.circle.fill")
            .onTapGesture {
                showCalendar.toggle()
            }
            .fullScreenCover(isPresented: $showCalendar){
                NavigationStack{
                    DatePicker("Date", selection: $date, in: ...Utils.get18YearsAgo(), displayedComponents: .date)
                        .datePickerStyle(.graphical)
                        .toolbar{
                            ToolbarItem(placement: .cancellationAction){
                                Button("Cancel"){
                                    showCalendar.toggle()
                                }
                            }
                            ToolbarItem(placement: .confirmationAction){
                                Button("Done"){
                                    showCalendar.toggle()
                                }
                            }
                        }
                }
            }
    }
}

#Preview {
    DateInput(date: .constant(.now))
}
