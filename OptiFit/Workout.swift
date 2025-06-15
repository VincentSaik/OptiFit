//
//  Workout.swift
//  OptiFit
//
//  Created by Vincent Saikali on 2025-06-11.
//

import Foundation

struct WorkoutSession: Identifiable, Codable {
    let id: UUID
    let date: Date
    var exercises: [ExerciseRecord]

    var totalVolume: Double {
        exercises.reduce(0) { $0 + $1.totalVolume }
    }
}

struct ExerciseRecord: Identifiable, Codable {
    let id: UUID
    let name: String
    var sets: [SetRecord]

    var totalVolume: Double {
        sets.reduce(0) { $0 + Double($1.reps) * $1.weight }
    }
}

struct SetRecord: Codable {
    var reps: Int
    var weight: Double
}

struct NamedWorkoutPlan: Identifiable, Codable {
    let id: UUID
    let name: String
    let days: [WorkoutDay]
}
