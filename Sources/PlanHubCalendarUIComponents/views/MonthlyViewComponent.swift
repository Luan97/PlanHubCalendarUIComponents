//
//  MonthlyViewComponent.swift
//  Calendar
//
//  Created by LuanLing on 12/28/21.
//

import SwiftUI

struct MonthlyViewComponent: View {
    @Binding var selection: Date
    @Binding var month: String
    @Binding var year: String
    var fgColor: Color
    var bgColor: Color
    var labelColor: Color
    var fontName: String = "Arial"
    
    @State private var totalDays: Int = 0
    @State private var firstWeekday: Int = 0
    @State private var daysArray: [Date?] = []
    @State private var transitOpacity: CGFloat = 1.0
    private let monthSymbols: [String] = Calendar.current.monthSymbols
    private let weekdaySymbols: [String] = Calendar.current.shortStandaloneWeekdaySymbols
    private let sevenColumnGrid:Array = Array(repeating: GridItem(.flexible(), alignment: .center), count: 7)
    private let today: Date = Date()
    @State private var todayYear: String = ""
    @State private var todayMonth: Int = 0
    @State private var todayDay: Int = 0
    @State private var isTodayFocusedMonth: Bool = false
    
    init(selection:Binding<Date>, month:Binding<String>, year:Binding<String>, fgColor:Color, bgColor:Color, labelColor:Color, fontName:String) {
        _selection = selection
        _month = month
        _year = year
        self.fgColor = fgColor
        self.bgColor = bgColor
        self.labelColor = labelColor
        self.fontName = fontName
    }
    
    func processMonthYear() {
        transitOpacity = 0.0
        let mInt = Date.getMonthIndexByMonthString(month)
        let yInt = Int(year) ?? 2021
        totalDays = Date.getNumberOfDaysInMonth(yInt, mInt)
        firstWeekday = Date.getWeekdayOfFirstdayInMonth(yInt, mInt)
        // compare today
        todayYear = Date.getYearStringByDate(today)
        todayMonth = Date.getMonthIntByDate(today)
        todayDay = Date.getDayIntByDate(today)
        isTodayFocusedMonth = mInt == todayMonth && year == todayYear
        daysArray = []
        let fIndex = firstWeekday > 0 ? firstWeekday - 1 : firstWeekday
        if fIndex > 0 {
            for _ in 1...fIndex {
                daysArray.append(nil)
            }
        }
        for i in 1...totalDays {
            let date = Date.dateSwapWithYearMonthAndDay(Date(), year: yInt, month:mInt , day: i)
            daysArray.append(date)
        }
        
        withAnimation(.easeInOut(duration: 0.3)) {
            transitOpacity = 1.0
        }
    }
    
    var body: some View {
        VStack{
            LazyVGrid(columns: sevenColumnGrid) {
                ForEach(weekdaySymbols, id:\.self) {sym in
                    Text(sym).font(.custom(fontName, size: 12)).foregroundColor(.gray)
                }
            }
            LazyVGrid(columns: sevenColumnGrid) {
                ForEach(daysArray.indices, id:\.self) {index in
                    let date = daysArray[index]
                    let day = Date.getDayStringByDate(date)
                    DateButton(label:day, labelColor:labelColor, fontName:fontName, date:Binding.constant(date ?? nil), selectedDate:$selection, onTap: { date in
                        selection = date
                    }).id(index)
                }
            }.id(UUID()).opacity(transitOpacity)
        }.frame(maxWidth:.infinity, alignment: .top).background(bgColor)
        .onChange(of: month) { _ in
            processMonthYear()
        }.onChange(of: year) { _ in
            processMonthYear()
        }
    }
}

struct MonthlyViewComponent_Previews: PreviewProvider {
    static var previews: some View {
        MonthlyViewComponent(selection:Binding.constant(Date()), month:Binding.constant("December"), year:Binding.constant("2021"), fgColor: Color.blue, bgColor: Color.white, labelColor: Color.gray, fontName:"Arial")
        
    }
}
