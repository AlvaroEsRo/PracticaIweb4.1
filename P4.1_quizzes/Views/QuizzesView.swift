//
//  QuizzesView.swift
//  P4.1_quizzes
//
//  Created by d074 DIT UPM on 14/11/24.
//

import SwiftUI

struct QuizzesView: View {
    @StateObject private var quizzesModel = QuizzesModel()  // Crear instancia de QuizzesModel
    
    var body: some View {
        NavigationStack{
            List(quizzesModel.quizzes) { quiz in  // Usamos quizzesModel.quizzes como fuente de datos
                NavigationLink(destination: QuizView(quiz: quiz)) {
                    RowView(quiz: quiz)
                    
                }
                .onAppear {
                    quizzesModel.load()  // Cargar los quizzes cuando la vista aparece
                }
                .navigationTitle("Quizzes")  // Título de la vista
            }
        }
    }
}
