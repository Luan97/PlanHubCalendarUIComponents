//
//  DateButton.swift
//  Calendar
//
//  Created by LuanLing on 12/29/21.
//

import SwiftUI

struct DateButton: View {
    var label: String = ""
    var labelColor:Color = .gray
    var fontName: String = "Arial"
    @Binding var date: Date?
    @Binding var selectedDate: Date
    @State var isToday: Bool = false
    var onTap: ((_ date:Date)->Void)?
    
    private let size: CGFloat = 28.0
    @State private var selected: Bool = false
    
    private func updateSelectedStatus() {
        if let date = date {
            selected = Date.isSameDate(date, selectedDate)
        }
    }
    
    var body: some View {
        Text(label).font(.custom(fontName, size: 14)).padding(.vertical, 6)
            .foregroundColor(isToday ? .blue : labelColor)
            .background(
                Circle()
                    .frame(width:size, height:size)
                    .foregroundColor(selected ? Color.blue : Color.clear)
                    .opacity(0.2)
            )
            .onAppear {
                if let date = date {
                    isToday = Date.isSameDate(date, Date())
                }
                updateSelectedStatus()
            }.onChange(of: selectedDate, perform: { newValue in
                updateSelectedStatus()
            })
            .onTapGesture {
                if let date = date {
                    onTap?(date)
                }
            }
    }
}

struct DateButton_Previews: PreviewProvider {
    static var previews: some View {
        DateButton(date: Binding.constant(Date()), selectedDate: Binding.constant(Date()))
    }
}
