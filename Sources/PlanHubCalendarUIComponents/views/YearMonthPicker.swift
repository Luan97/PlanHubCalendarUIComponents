//
//  YearMonthPicker.swift
//  Calendar
//
//  Created by LuanLing on 12/28/21.
//

import SwiftUI

struct YearMonthPicker: View {
    @Binding var month: String
    @Binding var year: String
    @Binding var fgColor: Color
    @Binding var bgColor: Color
    var fontName: String = "Arial"
    
    private let monthSymbols: [String] = Calendar.current.monthSymbols
    private let yearRange: Array = Array(2021...3000)
    @State private var expanded: Bool = false
    
    private let data: [[String]] = [
            Calendar.current.monthSymbols,
            Array(2021...3000).map { "\($0)" }
        ]
    @State private var selections: [Int] = [11, 0]
    @State private var disableLeft: Bool = false
    @State private var disableRight: Bool = false
    @State private var monthIndex: Int = 11
    @State private var yearIndex: Int = 0
    
    func updateMonthYearValue() {
        if let mIndex = selections.first, let yIndex = selections.last {
            month = monthSymbols[mIndex]
            for (i, yValue) in yearRange.enumerated() {
                if i == yIndex {
                    year = "\(yValue)"
                }
            }
        }
    }
    
    func updateCalendarByMonth(_ increase:Bool) {
        var m = selections.first ?? 0
        var y = selections.last ?? 0
        if increase {
            if m < monthSymbols.count - 1 {
                m += 1
            } else {
                m = 0
                if y < yearRange.count - 1 {
                    y += 1
                }
            }
        } else {
            if m > 0 {
                m -= 1
            } else {
                m = monthSymbols.count - 1
                if y >= 0 {
                    y -= 1
                }
            }
        }
        disableLeft = y == 0 && m == 0
        disableRight = y == yearRange.count - 1 && m == 11
        selections = [m, y]
    }

    var body: some View {
        VStack(alignment:.leading){
            HStack{
                Button (action: {
                    expanded.toggle()
                }) {
                    HStack{
                        Text("\(month) \(year)").font(.custom(fontName, size: 16))
                        Image(systemName: expanded ? "chevron.down": "chevron.right")
                    }
                }.buttonStyle(.plain).foregroundColor(fgColor)
                Spacer()
                Button {
                    updateCalendarByMonth(false)
                } label: {
                    Image(systemName: "chevron.left")
                }.disabled(disableLeft)
                Button {
                    updateCalendarByMonth(true)
                } label: {
                    Image(systemName: "chevron.right")
                }.disabled(disableRight)
            }.padding(.horizontal, 6)
            HStack {
                PickerView(data: data, fontName:fontName, fontSize: 18.0, selections: $selections)
            }.onChange(of: selections) { _ in
                updateMonthYearValue()
            }.opacity(expanded ? 1.0 : 0.0)
        }.onAppear {
            updateMonthYearValue()
        }.onChange(of: month, perform: { _ in
            for (i, symbol) in monthSymbols.enumerated() {
                if month == symbol {
                    monthIndex = i
                    selections = [monthIndex, yearIndex]
                }
            }
        }).onChange(of: year, perform: { _ in
            for (i, symbol) in yearRange.enumerated() {
                if year == String(symbol) {
                    yearIndex = i
                    selections = [monthIndex, yearIndex]
                }
            }
        })
        .frame(maxWidth:.infinity, maxHeight:300, alignment:.leading)
        .background(expanded ? bgColor : Color.clear)
    }
}

struct YearMonthPicker_Previews: PreviewProvider {
    static var previews: some View {
        YearMonthPicker(month:Binding.constant("December"), year:Binding.constant("2021"), fgColor: Binding.constant(Color.blue), bgColor:Binding.constant(Color.white))
    }
}
