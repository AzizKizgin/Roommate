//
//  DateInput.swift
//  Roommate
//
//  Created by Aziz Kızgın on 6.04.2024.
//

//
//  DateInput.swift
//  Roommate
//
//  Created by Aziz Kızgın on 28.12.2023.
//

import SwiftUI

struct DateInput: View {
    @AppStorage("isDark") private var isDark: Bool = false
    @State private var showCalendar: Bool = false
    @State private var date: Date = Date()
    @Binding var dateText: String
    
    var body: some View {
        HStack(alignment:.top){
            Image(systemName: "calendar.circle.fill")
                .font(.title3)
                .foregroundStyle(Color.accentColor)
            TextField("Birth Date", text: .constant(dateText))
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .disabled(true)
        }
            .padding()
            .background{
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .foregroundStyle(.gray.opacity(isDark ? 0.25: 0.15))
            }
            .onTapGesture {
                showCalendar.toggle()
            }
            .onAppear{
                // setting user's date to self.date
                if let defaultDate = Utils.stringtoDate(dateString: dateText){
                    date = defaultDate
                }
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
                                    dateText = Utils.dateToString(date: date)
                                    showCalendar.toggle()
                                }
                            }
                        }
                }
            }
    }
}

#Preview {
    DateInput(dateText: .constant("28.12.2023"))
}
