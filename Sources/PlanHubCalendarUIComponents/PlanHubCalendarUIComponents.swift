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
    @Binding var selection: Date
    @Binding var scrollFocusDate:Date
    @Binding var fgColor: Color
    @Binding var bgColor: Color
    @Binding var fontName: String
    @State private var month: String = ""
    @State private var year: String = ""
    
    public var body: some View {
        ZStack(alignment: .topLeading){
            MonthlyViewComponent(selection:$selection, month:$month, year:$year, fgColor:$fgColor, bgColor:$bgColor, fontName:fontName).onChange(of: selection, perform: { newValue in
                scrollFocusDate = selection
            })
                .padding(.top, 58)
            YearMonthPicker(month:$month, year:$year, fgColor:$fgColor, bgColor:$bgColor, fontName:fontName)
        }.onAppear {
            month = Date.getMonthStringByDate(scrollFocusDate)
            year = Date.getYearStringByDate(scrollFocusDate)
        }.onChange(of: scrollFocusDate, perform: { newValue in
            month = Date.getMonthStringByDate(scrollFocusDate)
            year = Date.getYearStringByDate(scrollFocusDate)
        })
        .padding(10).frame(maxHeight:320)
        .background(bgColor)
    }
}

struct PlanHubCalendarUIComponents_Previews: PreviewProvider {
    static var previews: some View {
        PlanHubCalendarUIComponents(selection:Binding.constant(Date()), scrollFocusDate: Binding.constant(Date()), fgColor: Binding.constant(Color.blue), bgColor: Binding.constant(Color.white), fontName:Binding.constant("Arial"))
    }
}
