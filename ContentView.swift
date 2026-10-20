import SwiftUI

struct ShiftTask: Identifiable {
    let id = UUID()
    let title: String
    var isCompleted: Bool = false
}

struct ContentView: View {
    @State private var tasks: [ShiftTask] = [
        ShiftTask(title: "Complete opening walkthrough"),
        ShiftTask(title: "Verify cash drawers"),
        ShiftTask(title: "Check equipment status"),
        ShiftTask(title: "Assign team stations")
    ]

    private var completedTasks: Int {
        tasks.filter { $0.isCompleted }.count
    }

    private var progress: Double {
        guard !tasks.isEmpty else { return 0 }
        return Double(completedTasks) / Double(tasks.count)
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                VStack(spacing: 8) {
                    Image(systemName: "checklist")
                        .font(.system(size: 42))

                    Text("ShiftFlow")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text("Run the shift. Know the status.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Shift Progress")
                            .font(.headline)

                        Spacer()

                        Text("\(completedTasks)/\(tasks.count)")
                            .fontWeight(.semibold)
                    }

                    ProgressView(value: progress)
                }

                VStack(spacing: 12) {
                    ForEach($tasks) { $task in
                        Button {
                            task.isCompleted.toggle()
                        } label: {
                            HStack(spacing: 14) {
                                Image(
                                    systemName: task.isCompleted
                                        ? "checkmark.circle.fill"
                                        : "circle"
                                )
                                .font(.title2)

                                Text(task.title)
                                    .strikethrough(task.isCompleted)
                                    .foregroundStyle(
                                        task.isCompleted
                                            ? .secondary
                                            : .primary
                                    )

                                Spacer()
                            }
                            .padding()
                            .background(
                                .thinMaterial,
                                in: RoundedRectangle(cornerRadius: 14)
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Today's Shift")
        }
    }
}
