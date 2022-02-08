//
//  PlanHubCalendarUIComponents.swift
//
//  Created by LuanLing on 12/28/21.
//

import SwiftUI

@available(iOS 15, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct PlanHubCalendarUIComponents: View {
    var from: Date
    var to: Date
    @Binding var selection: Date
    @Binding var scrollFocusDate:Date
    var fgColor: Color
    var bgColor: Color
    var labelColor: Color
    @Binding var fontName: String
    @State private var month: String = ""
    @State private var year: String = ""
    
    public var body: some View {
        ZStack(alignment: .topLeading){
            MonthlyViewComponent(from: from, to: to, selection:$selection, month:$month, year:$year, fgColor:fgColor, bgColor:bgColor, labelColor:labelColor ,fontName:fontName).onChange(of: selection, perform: { newValue in
                scrollFocusDate = selection
            }).padding(.top, 68)
            YearMonthPicker(from: from, to: to, month:$month, year:$year, fgColor:fgColor, bgColor:bgColor, fontName:fontName)
        }.onChange(of: scrollFocusDate, perform: { newValue in
            month = Date.getMonthStringByDate(scrollFocusDate)
            year = Date.getYearStringByDate(scrollFocusDate)
        }).onAppear{
            month = Date.getMonthStringByDate(scrollFocusDate)
            year = Date.getYearStringByDate(scrollFocusDate)
        }
        .padding(10).frame(maxHeight:320)
        .background(bgColor)
    }
}

struct PlanHubCalendarUIComponents_Previews: PreviewProvider {
    @State static var from = Date.getFutureDaysBy(Date(), -1, component: .month)
    @State static var to = Date.getFutureDaysBy(Date(), 10, component: .year)
    static var previews: some View {
        PlanHubCalendarUIComponents(from: from, to: to, selection:Binding.constant(Date()), scrollFocusDate: Binding.constant(Date()), fgColor: Color.blue, bgColor:Color.white, labelColor: Color.gray, fontName:Binding.constant("Arial"))
    }
}
