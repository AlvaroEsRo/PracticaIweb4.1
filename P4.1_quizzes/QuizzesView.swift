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
        NavigationView {
            List(quizzesModel.quizzes) { quiz in  // Usamos quizzesModel.quizzes como fuente de datos
                VStack(alignment: .leading) {
                    HStack{
                        Text(quiz.question)  // Mostrar la pregunta
                            .font(.headline)
                        if quiz.favourite {
                            Image(systemName: "starfill")
                                .foregroundColor(.yellow)
                        } else {
                            Image(systemName: "star")
                                .foregroundColor(.gray)
                        }
                    }
                    if let imageUrl = quiz.attachment?.url {
                        AsyncImage(url: imageUrl){image in
                            image.resizable()
                                .scaledToFit()
                                
                        }
                        placeholder: {
                            ProgressView()
                        }
                    }
                    HStack{
                        if let autorphoto = quiz.author?.photo?.url {
                            AsyncImage(url: autorphoto){image in
                                    image.resizable()
                                    .frame(width: 50, height:50)
                                        .clipShape(Circle())
                                }
                                placeholder: {
                                    ProgressView()
                                }
                        }
                        if let author = quiz.author {
                            Text(author.profileName ?? "Unknown Author")
                                .font(.footnote)
                                .foregroundColor(.blue)
                        }
                        
                        }
                    }
                
            }
            .onAppear {
                quizzesModel.load()  // Cargar los quizzes cuando la vista aparece
            }
            .navigationTitle("Quizzes")  // Título de la vista
        }
    }
}

#Preview {
    QuizzesView()
}
