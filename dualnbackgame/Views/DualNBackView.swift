//
//  DualNBackView.swift
//  dualnbackgame
//
//  Created by Ashleigh Edwards on 24/12/2025.
//

import SwiftUI
import CoreData

struct DualNBackView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var vm: DualNBackViewModel
    @State var showAlert = false
    
    init() {
        _vm = StateObject(wrappedValue: DualNBackViewModel(
            context: PersistenceController.shared.container.viewContext
        ))
    }

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 8), count: 3)

    private func isActiveCell(_ pos: GridPos) -> Bool {
        pos == vm.currentStimulus?.position
    }

    var body: some View {
        VStack(spacing: 16) {
            Text("Dual N‑Back")
                .font(.title2).bold()
            Text("N: \(vm.config.nth)").font(.subheadline).bold()

            Text("Trial \(min(vm.currentIndex+1, vm.trials.count)) / \(vm.config.length)")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(GridPos.allCases, id: \.self) { pos in
                    Rectangle()
                        .fill(isActiveCell(pos) ? Color.blue : Color.gray.opacity(0.25))
                        .frame(height: 110)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.secondary.opacity(0.4))
                        )
                        .animation(.easeInOut(duration: 0.2), value: vm.currentStimulus)
                }
            }
            .padding(.horizontal)

            Text("Sound: \(vm.currentStimulus?.sound.rawValue ?? "-")")
                .font(.headline)

            HStack(spacing: 20) {
                Spacer()
                Button {
                    vm.respondPositionMatch()
                } label: {
                    VStack {
                        Text("Position").bold()
                    }.padding(25)
                }
                .background(Color.clear)
                .frame(minWidth: 120)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.primary, lineWidth: 0.5)
                )
                .disabled(!vm.canRespond)
                Spacer()

                Button {
                    vm.respondSoundMatch()
                } label: {
                    VStack {
                        Text("Sound").bold()
                    }.padding(25)
                }
                .background(Color.clear)
                .frame(minWidth: 120)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.primary, lineWidth: 0.5)
                )
                .disabled(!vm.canRespond)
                
                Spacer()
            }
            
            HStack(spacing: 16) {
                Button(startStopTitle(for: vm.state)) {
                    performStartStop(state: vm.state, vm: vm)
                }
                .buttonStyle(.bordered)
                .tint(vm.state == .running || vm.state == .paused ? .red : .green)
                .controlSize(.large)
                .frame(minWidth: 120)
                .disabled(!isStartStopEnabled(for: vm.state))
                
                Button(pauseResumeTitle(for: vm.state)) {
                    performPauseResume(state: vm.state, vm: vm)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .frame(minWidth: 120)
                .disabled(!isPauseResumeEnabled(for: vm.state))
            }
            .animation(.default, value: vm.state)

        }
        .alert("Score: \(vm.score)", isPresented: $showAlert ) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(String(format: "Accuracy: %.0f%%", ((vm.soundAccuracy+vm.posAccuracy)/2)*100))
        }
        .padding()
        .background(vm.feedbackColor ?? .clear)
        .animation(.easeOut(duration: 0.25), value: vm.feedbackColor)
        .onChange(of: vm.state) { _, newState in
            if newState == .finished {
                showAlert = true
            }
        }
    }
}

#Preview {
    let persistenceController = PersistenceController.preview

    DualNBackView()
        .environment(
            \.managedObjectContext,
            persistenceController.container.viewContext
        )
        .preferredColorScheme(.dark)
}
