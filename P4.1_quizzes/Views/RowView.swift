import SwiftUI

struct RowView: View {
    let quiz: QuizItem
    
    // Detectar el tamaño de la pantalla (horizontal/vertical)
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        Group {
            if horizontalSizeClass == .compact {
                // Vista para orientación vertical (por defecto)
                VStack(alignment: .leading, spacing: 10) {
                    // Pregunta y estrella de favorito
                    HStack {
                        Text(quiz.question)  // Mostrar la pregunta
                            .font(.body) // Ajustado para que sea más legible
                            .fontWeight(.medium)
                            .foregroundColor(.primary)
                            .lineLimit(2)
                            .truncationMode(.tail)
                            .padding(.trailing, 10)
                        
                        Spacer()
                        
                        if quiz.favourite {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                                .imageScale(.medium)
                        } else {
                            Image(systemName: "star")
                                .foregroundColor(.gray)
                                .imageScale(.medium)
                        }
                    }
                    .padding([.top, .horizontal])
                    .background(Color.clear)

                    // Imagen adjunta, si existe
                    if let imageUrl = quiz.attachment?.url {
                        AsyncImage(url: imageUrl) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 200, alignment: .center)
                                .clipped()
                                .cornerRadius(10)
                        } placeholder: {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                                .padding(.top, 5)
                        }
                    }
                    
                    // Información del autor
                    HStack(spacing: 12) {
                        if let autorphoto = quiz.author?.photo?.url {
                            AsyncImage(url: autorphoto) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                                    .shadow(radius: 2)
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                                    .background(Circle().fill(Color.gray.opacity(0.2)))
                                    .padding(2)
                            }
                        }
                        
                        if let author = quiz.author {
                            Text(author.profileName ?? "Desconocido")
                                .font(.subheadline)
                                .fontWeight(.regular)
                                .foregroundColor(.secondary)
                                .lineLimit(1)
                                .truncationMode(.tail)
                        }
                        
                        Spacer()
                    }
                    .padding([.horizontal, .bottom], 10)
                    .background(Color.clear)
                }
            } else {
                // Vista para orientación horizontal
                HStack(spacing: 15) {
                    VStack(alignment: .leading, spacing: 10) {
                        // Pregunta y estrella de favorito
                        HStack {
                            Text(quiz.question)  // Mostrar la pregunta
                                .font(.body)
                                .fontWeight(.medium)
                                .foregroundColor(.primary)
                                .lineLimit(2)
                                .truncationMode(.tail)
                                .padding(.trailing, 10)
                            
                            if quiz.favourite {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                    .imageScale(.medium)
                            } else {
                                Image(systemName: "star")
                                    .foregroundColor(.gray)
                                    .imageScale(.medium)
                            }
                        }
                        .padding([.top, .horizontal])

                        // Información del autor (solo en modo horizontal)
                        HStack(spacing: 12) {
                            if let autorphoto = quiz.author?.photo?.url {
                                AsyncImage(url: autorphoto) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 40, height: 40)
                                        .clipShape(Circle())
                                        .shadow(radius: 2)
                                } placeholder: {
                                    ProgressView()
                                        .frame(width: 40, height: 40)
                                        .clipShape(Circle())
                                        .background(Circle().fill(Color.gray.opacity(0.2)))
                                        .padding(2)
                                }
                            }
                            
                            if let author = quiz.author {
                                Text(author.profileName ?? "Desconocido")
                                    .font(.subheadline)
                                    .fontWeight(.regular)
                                    .foregroundColor(.secondary)
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                            }
                            
                            Spacer()
                        }
                        .padding([.horizontal, .bottom], 10)
                    }
                    
                    // Imagen adjunta, si existe (a la derecha de la pregunta en modo horizontal)
                    if let imageUrl = quiz.attachment?.url {
                        AsyncImage(url: imageUrl) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 120, height: 120)
                                .clipped()
                                .cornerRadius(10)
                        } placeholder: {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                                .padding(.top, 5)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .cornerRadius(15)
        .shadow(radius: 5)
        .padding(.horizontal)
        .padding(.bottom, 10)
        .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray.opacity(0.2), lineWidth: 1))
        .background(Color.clear)
    }
}

#Preview {
    let quizItem = QuizItem(id: 1, question: "¿Cuál es la capital de Francia?", answer: "París", author: nil, attachment: nil, favourite: true)
    RowView(quiz: quizItem)
}
