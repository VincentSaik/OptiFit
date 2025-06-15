//
//  CustomizeWorkoutView.swift
//  OptiFit
//
//  Created by Vincent Saikali on 2025-06-11.
//

import SwiftUI

struct CustomizeWorkoutView: View {
    @State private var goal = "Muscle Gain"
    @State private var level = "Intermediate"
    @State private var split = "Full Body"
    @State private var generatedWorkout: [WorkoutDay] = []
    @State private var showGeneratedPlan = false

    let goals = ["Muscle Gain", "Fat Loss", "Endurance"]
    let levels = ["Beginner", "Intermediate", "Advanced"]
    let splits = ["Full Body", "Upper/Lower", "Push/Pull/Legs"]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Workout Goal")) {
                    Picker("Goal", selection: $goal) {
                        ForEach(goals, id: \.self) { Text($0) }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("Training Split")) {
                    Picker("Split", selection: $split) {
                        ForEach(splits, id: \.self) { Text($0) }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("Level")) {
                    Picker("Level", selection: $level) {
                        ForEach(levels, id: \.self) { Text($0) }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Button("Generate Workout") {
                    let selectedSplit: WorkoutSplit = {
                        switch split {
                        case "Upper/Lower": return .upperLower
                        case "Push/Pull/Legs": return .pushPullLegs
                        default: return .fullBody
                        }
                    }()

                    generatedWorkout = WorkoutGenerator.generateWeeklyPlan(split: selectedSplit, goal: goal, level: level)
                    showGeneratedPlan = true
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)

                if showGeneratedPlan {
                    NavigationLink(destination: WorkoutPlanView(planTitle: split, workoutPlan: generatedWorkout)) {
                        Text("View \(split) Plan")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            .navigationTitle("Customize Workout")
        }
    }
}

struct WorkoutPlanView: View {
    let planTitle: String
    let workoutPlan: [WorkoutDay]
    @State private var workoutName: String = ""
    @State private var saved = false
    let dayNames = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                TextField("Name this plan...", text: $workoutName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                ForEach(0..<min(workoutPlan.count, dayNames.count), id: \.self) { index in
                    DisclosureGroup("\(dayNames[index]) – \(workoutPlan[index].title)") {
                        ForEach(workoutPlan[index].exercises, id: \.name) { ex in
                            Text("• \(ex.name) – \(ex.sets)x\(ex.reps)")
                                .padding(.leading)
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }

                Button("Save Workout Plan") {
                    saved = true
                    // Implement storage logic here (e.g., UserDefaults, CoreData, or file)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(saved ? Color.gray : Color.orange)
                .foregroundColor(.white)
                .cornerRadius(10)
                .disabled(saved)
            }
            .padding()
        }
        .navigationTitle("\(planTitle) Plan")
    }
}
