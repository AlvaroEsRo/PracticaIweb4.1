//
//  QuizView.swift
//  P4.1_quizzes
//
//  Created by d074 DIT UPM on 14/11/24.
//

import SwiftUI

struct QuizView: View {
    @State private var userInput = ""
    let quiz : QuizItem
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Text(quiz.question)  // Mostrar la pregunta
                    .font(.headline)
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
            HStack{
                TextField("Escribe la respuesta aquí", text: $userInput)
                                .padding()  // Agrega espacio dentro del TextField
                                .textFieldStyle(RoundedBorderTextFieldStyle())  // Estilo del TextField
                                .frame(width: 300)  // Establece un ancho fijo para el TextField
            }
            
        }
    }
}
