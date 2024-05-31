//
//  File.swift
//  TimeConverterApp
//
//  Created by Riley Koo on 5/31/24.
//

import SwiftUI

struct TimeView: View {
    
    @State private var date1 = Date()
    @State private var date2 = Date()
    @State var diff: Int = 0
    @State var totalDiff: Int = 0
    @State var totalHours: Double = 0.0
    @State var submitted = false
    
    var body: some View {
        VStack {
            Spacer()
            Text("\(totalDiff) Minutes")
                .font(.title.bold())
            Text("\(totalHours, specifier: "%.2f") Hours")
                .font(.title.bold())
            Spacer()
            if diff == 0 {
                VStack {
                    DatePicker("", selection: $date1, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                    DatePicker("", selection: $date2, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                .frame(height: 250)
            } else {
                Spacer()
                    .frame(height: 250)
            }
            Spacer()
            Button {
                if diff == 0 {
                    submitted = true
                    diff = timeDiff(d1: date1, d2: date2)
                    totalDiff += diff
                } else {
                    diff = 0
                    date1 = Date()
                    date2 = Date()
                }
            } label: {
                Text((diff == 0) ? "Calculate" : "Continue")
                    .font(.title2)
            }
            Spacer()
            Button {
                totalDiff = 0
                diff = 0
                date1 = Date()
                date2 = Date()
            } label: {
                Text("Reset")
                    .font(.title2)
            }
            Spacer()
        }
        .onChange(of: totalDiff) { _, _ in
            totalHours = minToHrs(x: totalDiff)
        }
    }
}

func timeDiff(d1: Date, d2: Date) -> Int {
    let x = Calendar.current.dateComponents([.hour, .minute], from: d1, to: d2)
    var y: Int = 0
    y += x.minute ?? 0
    y += (x.hour ?? 0) * 60
    return abs(y)
}
func minToHrs(x: Int) -> Double {
    return Double(x)/60
}
