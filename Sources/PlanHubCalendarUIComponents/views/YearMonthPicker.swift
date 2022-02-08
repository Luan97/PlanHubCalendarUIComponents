//
//  YearMonthPicker.swift
//  Calendar
//
//  Created by LuanLing on 12/28/21.
//

import SwiftUI

struct YearMonthPicker: View {
    var from: Date
    var to: Date
    @Binding var month: String
    @Binding var year: String
    var fgColor: Color
    var bgColor: Color
    var fontName: String = "Arial"
    
    private let monthSymbols: [String] = Calendar.current.monthSymbols
    @State private var yearRange: Array = Array(2021...2100)
    @State private var expanded: Bool = false
    
    @State private var data: [[String]] = []
    @State private var selections: [Int] = [0, 0]
    @State private var disableLeft: Bool = false
    @State private var disableRight: Bool = false
    @State private var monthIndex: Int = 0
    @State private var yearIndex: Int = 0
    
    func updateMonthYearValue() {
        let sYear = Date.getYearIntByDate(from)
        let eYear = Date.getYearIntByDate(to)
        yearRange = Array(sYear...eYear)
        data = [
            Calendar.current.monthSymbols,
            yearRange.map { "\($0)" }
        ]
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
            }.padding(.horizontal, 10)
            if data.count > 0 {
                PickerView(data: $data, fontName:fontName, fontSize: 18.0, selections: $selections)
                .frame(maxWidth:.infinity)
                .onChange(of: selections) { _ in
                    updateMonthYearValue()
                }.opacity(expanded ? 1.0 : 0.0)
            }
        }.onAppear(perform: {
            updateMonthYearValue()
        })
        .onChange(of: month, perform: { _ in
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
        YearMonthPicker(from: Date(), to: Date(), month:Binding.constant("December"), year:Binding.constant("2021"), fgColor: Color.blue, bgColor:Color.white, fontName: "Arial")
    }
}
