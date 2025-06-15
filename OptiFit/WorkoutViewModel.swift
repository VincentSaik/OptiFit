//
//  WorkoutViewModel.swift
//  OptiFit
//
//  Created by Vincent Saikali on 2025-06-11.
//

import Foundation
import SwiftUI

class WorkoutViewModel: ObservableObject {
    @Published var savedPlans: [NamedWorkoutPlan] = []
    @Published var sessions: [WorkoutSession] = []

    private let plansKey = "savedPlans"
    private let sessionsKey = "workoutSessions"

    init() {
        load()
    }

    func savePlan(name: String, days: [WorkoutDay]) {
        let plan = NamedWorkoutPlan(id: UUID(), name: name, days: days)
        savedPlans.append(plan)
        persist()
    }

    func addSession(_ session: WorkoutSession) {
        sessions.append(session)
        persist()
    }

    private func persist() {
        if let data = try? JSONEncoder().encode(savedPlans) {
            UserDefaults.standard.set(data, forKey: plansKey)
        }
        if let data = try? JSONEncoder().encode(sessions) {
            UserDefaults.standard.set(data, forKey: sessionsKey)
        }
    }

    private func load() {
        if let data = UserDefaults.standard.data(forKey: plansKey),
           let plans = try? JSONDecoder().decode([NamedWorkoutPlan].self, from: data) {
            savedPlans = plans
        }
        if let data = UserDefaults.standard.data(forKey: sessionsKey),
           let past = try? JSONDecoder().decode([WorkoutSession].self, from: data) {
            sessions = past
        }
    }
}
