import SwiftUI

struct ActiveWorkoutView: View {
    @EnvironmentObject var viewModel: WorkoutViewModel
    let day: WorkoutDay
    let planName: String

    @State private var currentExerciseIndex: Int = 0
    @State private var currentSet: Int = 1
    @State private var reps: String = ""
    @State private var weight: String = ""
    @State private var restSeconds: Int = 60
    @State private var timerActive: Bool = false

    @State private var records: [ExerciseRecord] = []

    var body: some View {
        VStack(spacing: 20) {
            if currentExerciseIndex < day.exercises.count {
                let exercise = day.exercises[currentExerciseIndex]
                Text(exercise.name)
                    .font(.title2)

                Text("Set \(currentSet) of \(exercise.sets)")

                HStack {
                    TextField("Reps", text: $reps)
                        .keyboardType(.numberPad)
                        .frame(width: 60)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Weight", text: $weight)
                        .keyboardType(.decimalPad)
                        .frame(width: 80)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }

                if timerActive {
                    Text("Rest: \(restSeconds)s")
                        .onReceive(timer) { _ in
                            if restSeconds > 0 { restSeconds -= 1 } else { timerActive = false }
                        }
                }

                Button(timerActive ? "Resting" : "Complete Set") {
                    recordSet()
                }
                .disabled(timerActive)
            } else {
                Button("Finish Workout") { finishWorkout() }
                    .font(.title2)
            }
        }
        .padding()
        .navigationTitle(day.title)
    }

    private var timer: Timer.TimerPublisher {
        Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }

    private func recordSet() {
        guard let r = Int(reps), let w = Double(weight) else { return }

        if records.indices.contains(currentExerciseIndex) {
            records[currentExerciseIndex].sets.append(SetRecord(reps: r, weight: w))
        } else {
            records.append(ExerciseRecord(id: UUID(), name: day.exercises[currentExerciseIndex].name, sets: [SetRecord(reps: r, weight: w)]))
        }

        if currentSet < day.exercises[currentExerciseIndex].sets {
            currentSet += 1
            startRest()
        } else {
            nextExercise()
        }
        reps = ""
        weight = ""
    }

    private func startRest() {
        restSeconds = 60
        timerActive = true
    }

    private func nextExercise() {
        currentExerciseIndex += 1
        currentSet = 1
    }

    private func finishWorkout() {
        let session = WorkoutSession(id: UUID(), date: Date(), exercises: records)
        viewModel.addSession(session)
    }
}
