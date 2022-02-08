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
    @Binding var disabled:Bool
    var onTap: ((_ date:Date)->Void)?
    
    private let size: CGFloat = 28.0
    @State private var isToday: Bool = false
    @State private var selected: Bool = false
    @State private var bgColor: Color = .clear
    
    private func updateSelectedStatus(_ date:Date?) {
        if let date = date {
            isToday = Date.isSameDate(date, Date())
            selected = Date.isSameDate(date, selectedDate)
            bgColor = selected ? .blue : .clear
        }
    }
    
    var body: some View {
        Text(label).font(.custom(fontName, size: 14)).padding(.vertical, 6)
            .foregroundColor(isToday ? .blue : labelColor).opacity(disabled ? 0.5 : 1)
            .background(
                Circle()
                    .frame(width:size, height:size)
                    .foregroundColor(bgColor)
                    .opacity(0.2)
            )
            .onAppear {
                updateSelectedStatus(date)
            }.onChange(of: selectedDate, perform: { newValue in
                updateSelectedStatus(date)
            }).onChange(of: date, perform: { newDate in
                updateSelectedStatus(newDate)
            })
            .onTapGesture {
                if !disabled, let date = date {
                    onTap?(date)
                }
            }
    }
}

struct DateButton_Previews: PreviewProvider {
    static var previews: some View {
        DateButton(date: Binding.constant(Date()), selectedDate: Binding.constant(Date()), disabled: Binding.constant(false))
    }
}
