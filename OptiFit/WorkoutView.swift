//
//  WorkoutView.swift
//  OptiFit
//
//  Created by Vincent Saikali on 2025-06-11.
//

import SwiftUI

struct WorkoutView: View {
    @EnvironmentObject var viewModel: WorkoutViewModel

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                NavigationLink(destination: CustomizeWorkoutView().environmentObject(viewModel)) {
                    HStack {
                        Image(systemName: "slider.horizontal.3")
                            .font(.title2)
                        Text("Customize Your Workout")
                            .font(.headline)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }

                NavigationLink(destination: SavedWorkoutsView().environmentObject(viewModel)) {
                    HStack {
                        Image(systemName: "doc.text")
                            .font(.title2)
                        Text("Saved Workouts")
                            .font(.headline)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Workouts")
        }
    }
}
