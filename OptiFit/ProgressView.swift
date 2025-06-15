//
//  ProgressView.swift
//  OptiFit
//
//  Created by Vincent Saikali on 2025-06-11.
//

import SwiftUI
import Charts

struct ProgressView: View {
    @EnvironmentObject var viewModel: WorkoutViewModel

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.sessions.isEmpty {
                    Text("No workouts yet")
                } else {
                    Chart {
                        ForEach(viewModel.sessions) { session in
                            LineMark(
                                x: .value("Date", session.date),
                                y: .value("Volume", session.totalVolume)
                            )
                        }
                    }
                    .frame(height: 250)
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Progress")
        }
    }
}

