import SwiftUI

struct SavedWorkoutsView: View {
    @EnvironmentObject var viewModel: WorkoutViewModel

    var body: some View {
        List {
            ForEach(viewModel.savedPlans) { plan in
                NavigationLink(destination: PlanDetailView(plan: plan)) {
                    Text(plan.name)
                }
            }
        }
        .navigationTitle("Saved Workouts")
    }
}

struct PlanDetailView: View {
    @EnvironmentObject var viewModel: WorkoutViewModel
    let plan: NamedWorkoutPlan

    var body: some View {
        List {
            ForEach(plan.days.indices, id: \.self) { index in
                NavigationLink(destination: ActiveWorkoutView(day: plan.days[index], planName: plan.name).environmentObject(viewModel)) {
                    Text(plan.days[index].title)
                }
            }
        }
        .navigationTitle(plan.name)
    }
}
