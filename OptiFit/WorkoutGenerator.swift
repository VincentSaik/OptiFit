//
//  WorkoutGenerator.swift
//  OptiFit
//
//  Created by Vincent Saikali on 2025-06-11.
//

import Foundation

struct Exercise {
    let name: String
    let sets: Int
    let reps: String
}

struct WorkoutDay {
    let title: String
    let exercises: [Exercise]
}

enum WorkoutSplit: String {
    case fullBody = "Full Body"
    case upperLower = "Upper/Lower"
    case pushPullLegs = "Push/Pull/Legs"
}

struct WorkoutGenerator {
    static func generateWeeklyPlan(split: WorkoutSplit, goal: String, level: String) -> [WorkoutDay] {
        let reps: String
        let sets: Int
        switch goal {
        case "Muscle Gain": reps = "8–12"; sets = 4
        case "Fat Loss": reps = "12–15"; sets = 3
        case "Endurance": reps = "15–20"; sets = 2
        default: reps = "10–12"; sets = 3
        }

        let volume: Int
        switch level {
        case "Beginner": volume = 1
        case "Intermediate": volume = 2
        case "Advanced": volume = 3
        default: volume = 2
        }

        switch split {
        case .fullBody:
            return generateFullBody(sets: sets, reps: reps, volume: volume)
        case .upperLower:
            return generateUpperLower(sets: sets, reps: reps, volume: volume)
        case .pushPullLegs:
            return generatePPL(sets: sets, reps: reps, volume: volume)
        }
    }

    private static func generateFullBody(sets: Int, reps: String, volume: Int) -> [WorkoutDay] {
        let fullBodyExercises = allChest.prefix(volume)
            + allBack.prefix(volume)
            + allLegs.prefix(volume)
            + allShoulders.prefix(volume)

        let exercises = fullBodyExercises.map { Exercise(name: $0, sets: sets, reps: reps) }
        return Array(repeating: WorkoutDay(title: "Full Body Workout", exercises: exercises), count: 3)
    }

    private static func generateUpperLower(sets: Int, reps: String, volume: Int) -> [WorkoutDay] {
        let upper = allChest.prefix(volume)
            + allBack.prefix(volume)
            + allShoulders.prefix(volume)
            + allArms.prefix(volume)

        let lower = allLegs.prefix(volume * 2)

        let upperWorkout = upper.map { Exercise(name: $0, sets: sets, reps: reps) }
        let lowerWorkout = lower.map { Exercise(name: $0, sets: sets, reps: reps) }

        return [
            WorkoutDay(title: "Upper Body", exercises: upperWorkout),
            WorkoutDay(title: "Lower Body", exercises: lowerWorkout),
            WorkoutDay(title: "Upper Body", exercises: upperWorkout),
            WorkoutDay(title: "Lower Body", exercises: lowerWorkout)
        ]
    }

    private static func generatePPL(sets: Int, reps: String, volume: Int) -> [WorkoutDay] {
        let push = allChest.prefix(volume)
            + allShoulders.prefix(volume)
            + allTriceps.prefix(volume)

        let pull = allBack.prefix(volume)
            + allBiceps.prefix(volume)

        let legs = allLegs.prefix(volume * 2)

        return [
            WorkoutDay(title: "Push", exercises: push.map { Exercise(name: $0, sets: sets, reps: reps) }),
            WorkoutDay(title: "Pull", exercises: pull.map { Exercise(name: $0, sets: sets, reps: reps) }),
            WorkoutDay(title: "Legs", exercises: legs.map { Exercise(name: $0, sets: sets, reps: reps) }),
            WorkoutDay(title: "Push", exercises: push.map { Exercise(name: $0, sets: sets, reps: reps) }),
            WorkoutDay(title: "Pull", exercises: pull.map { Exercise(name: $0, sets: sets, reps: reps) }),
            WorkoutDay(title: "Legs", exercises: legs.map { Exercise(name: $0, sets: sets, reps: reps) })
        ]
    }

    static let allChest = [
        "Flat Press (barbell, dumbbell, machine)",
        "Incline Press (barbell, dumbbell, machine)",
        "Chest Fly (cables, dumbbells, machine)"
    ]

    static let allBack = [
        "Pull-ups / Lat Pulldown",
        "Barbell/Dumbbell/Cable Rows",
        "Deadlifts",
        "Flexion Rows"
    ]

    static let allShoulders = [
        "Dumbbell Lateral Raises",
        "Upright Rows",
        "Cable Lateral Raises"
    ]

    static let allBiceps = [
        "Bayesian Cable Curls",
        "Incline Cable Curls",
        "Preacher Curls",
        "Regular Curls (EZ, barbell, dumbbell)"
    ]

    static let allTriceps = [
        "Overhead Extensions",
        "Cable Pushdowns",
        "Close-Grip Pressing",
        "Dips"
    ]

    static let allArms = allBiceps + allTriceps

    static let allLegs = [
        "Barbell Squats",
        "Leg Presses",
        "Hack Squats",
        "Leg Extensions",
        "Stiff-Legged Deadlifts",
        "Seated Leg Curls",
        "Hip Thrusts",
        "Sumo Squats",
        "Calf Raises"
    ]
}
