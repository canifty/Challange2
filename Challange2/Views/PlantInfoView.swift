import SwiftUI

struct PlantInfoView: View {
    var flowerName: String
    var flowerInfo: FlowerInfo? {
        FlowerData[flowerName]
    }

    // A closure for dismissing the modal
    var onDismiss: (() -> Void)?
    @Environment(\.presentationMode) var presentationMode  // Para manejar la navegación hacia atrás

    // Imágenes clasificadas cargadas dinámicamente
    @State private var classifiedImages: [UIImage] = []

    var body: some View {
        ZStack {
            Color(red: 200 / 255, green: 222 / 255, blue: 183 / 255)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 30) {

                ZStack {
                    // Go back button
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image("arrow")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .foregroundColor(Color(red: 0.236, green: 0.388, blue: 0.154))
                        }
                        .padding(.leading)
                        Spacer()
                    }

                    ZStack {
                        Text(flowerInfo?.title ?? "")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 0.236, green: 0.388, blue: 0.154))
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(.horizontal)

                // Flower vector and details
                HStack(alignment: .top, spacing: 10) {
                    ZStack {
                        Circle()
                            .fill(Color(red: 0.696, green: 0.771, blue: 0.63))
                            .frame(width: 150, height: 150)
                            .overlay(
                                Circle()
                                    .stroke(
                                        Color(
                                            red: 0.501, green: 0.607,
                                            blue: 0.443),
                                        lineWidth: 2)
                            )
                        Image(flowerInfo?.imageName ?? "")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 110, height: 110)
                    }

                    VStack(alignment: .leading, spacing: 2) {
                        Text("Family")
                            .font(.system(size: 14))
                        Text("\(flowerInfo?.family ?? [""])")
                            .font(.system(size: 18))
                            .foregroundStyle(
                                Color(
                                    red: 60 / 255, green: 99 / 255,
                                    blue: 39 / 255)
                            )
                        Spacer().frame(height: 5)
                        Text("Where to find it?")
                            .font(.system(size: 14))
                        Text("\(flowerInfo?.whereToFindIt ?? "")")
                            .font(.system(size: 18))
                            .foregroundStyle(
                                Color(
                                    red: 60 / 255, green: 99 / 255,
                                    blue: 39 / 255)
                            )
                        Spacer().frame(height: 5)
                        Text("Fun fact")
                            .font(.system(size: 14))
                        Text("\(flowerInfo?.funFact ?? "")")
                            .font(.system(size: 18))
                            .foregroundStyle(
                                Color(
                                    red: 60 / 255, green: 99 / 255,
                                    blue: 39 / 255)
                            )
                    }
                }
                .padding(.horizontal, 20)

                // Classified images in a grid layout
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                    ForEach(classifiedImages, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                            .padding(.top)
                    }
                }
                .padding(.horizontal, 20)

                Spacer()
            }
            .padding(.top, 20)
        }
        .navigationBarBackButtonHidden(true)  // Oculta el botón "Back" predeterminado
        .onAppear {
            loadClassifiedImages(for: flowerName)
        }
    }

    // Método para cargar imágenes de la carpeta local clasificadas por categoría
    func loadClassifiedImages(for category: String) {
        let fileManager = FileManager.default
        do {
            let documentsURL = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let categoryURL = documentsURL.appendingPathComponent(category)

            // Verificar si la carpeta existe
            guard fileManager.fileExists(atPath: categoryURL.path) else {
                print("Category folder does not exist: \(category)")
                return
            }

            // Iterar desde "image-01" hasta encontrar el último archivo
            var images: [UIImage] = []
            var counter = 1
            while true {
                let fileName = String(format: "image-%02d.jpg", counter)
                let fileURL = categoryURL.appendingPathComponent(fileName)

                // Verificar si el archivo existe
                if fileManager.fileExists(atPath: fileURL.path) {
                    if let image = UIImage(contentsOfFile: fileURL.path) {
                        images.append(image)
                    }
                    counter += 1
                } else {
                    // Salir del bucle si no se encuentra el archivo
                    break
                }
            }

            // Actualizar las imágenes clasificadas
            classifiedImages = images
            print("Loaded \(classifiedImages.count) images for category \(category).")
        } catch {
            print("Error loading images for category \(category): \(error.localizedDescription)")
        }
    }


}

#Preview {
    PlantInfoView(flowerName: "Cactus")
}
