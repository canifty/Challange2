import SwiftUI

struct PlantInfoView: View {
    var flowerName: String
    var flowerInfo: FlowerInfo? {
        FlowerData[flowerName]
    }
    
    // A closure for dismissing the modal
    var onDismiss: (() -> Void)?
    @Environment(\.presentationMode) var presentationMode  // To handle navigation back
    
    // Dynamically loaded classified images
    @State private var classifiedImages: [UIImage] = []
    @State private var selectedImage: UIImage? = nil  // Track the selected image
    @State private var isImageExpanded: Bool = false  // Toggle for showing full-screen image
    
    var body: some View {
        ZStack {
            Color(red: 200 / 255, green: 222 / 255, blue: 183 / 255)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {  // Wrap the VStack inside a ScrollView
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
                        Image(flowerInfo?.imageName ?? "")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 180)
                            .padding(.horizontal, 20)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Spacer().frame(height: 5)
                            Text("Where to find it:")
                                .bold()
                                .font(.system(size: 18))
                            Text("\(flowerInfo?.whereToFindIt ?? "")")
                                .bold()
                                .font(.system(size: 20))
                                .foregroundStyle(Color(red: 60 / 255, green: 99 / 255, blue: 39 / 255))
                            
                            Spacer().frame(height: 5)
                            
                            Text("Fun fact:").bold()
                                .font(.system(size: 18))
                            Text("\(flowerInfo?.funFact ?? "")")
                                .bold()
                                .font(.system(size: 20))
                                .foregroundStyle(Color(red: 60 / 255, green: 99 / 255, blue: 39 / 255))
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    // Classified images in a grid layout
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                        ForEach(classifiedImages, id: \.self) { image in
                            Button(action: {
                                selectedImage = image
                                isImageExpanded = true
                            }) {
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
                    }
                    .padding(.horizontal, 20)
                    
                    Spacer()
                }
                .padding(.top, 20)
            }
        }
        .navigationBarBackButtonHidden(true)  // Hides the default "Back" button
        .onAppear {
            loadClassifiedImages(for: flowerName)
        }
        
        .sheet(isPresented: $isImageExpanded) {
            ZStack {
                // Background color
                Color(red: 150 / 255, green: 180 / 255, blue: 130 / 255)
                    .edgesIgnoringSafeArea(.all)

                if let selectedImage = selectedImage {
                    Spacer()
                    VStack(spacing: 20) {
                        Spacer()

                        // Plant Info Section
                        VStack(spacing: 15) {
                            // Plant Name Section
                            HStack {
                                Text("Plant Name:")
                                    .font(.headline)
                                    .foregroundColor(Color.gray)
                                    .bold()
                                Spacer()
                                Text("Parodia")
                                    .font(.subheadline)
                                    .bold()

                                    .foregroundColor(Color.black)
                                    .fontWeight(.medium)
                            }
                            .padding(.horizontal)

                            // Common Name Section
                            HStack {
                                Text("Common Name:")
                                    .font(.headline)
                                    .foregroundColor(Color.gray)
                                    .bold()
                                Spacer()
                                Text("Cactaceae")
                                    .font(.subheadline)
                                    .foregroundColor(Color.black)
                                    .bold()
                                    .fontWeight(.medium)
                            }
                            .padding(.horizontal)

                            // Probability Section
                            HStack {
                                Text("Probability:")
                                    .font(.headline)
                                    .foregroundColor(Color.gray)
                                    .bold()
                                Spacer()
                                Text("%94.3")
                                    .bold()
                                    .font(.subheadline)
                                    .foregroundColor(Color.green)
                                    .fontWeight(.medium)
                            }
                            .padding(.horizontal)
                        }
                        .padding(20)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.white, Color(white: 0.95)]), startPoint: .top, endPoint: .bottom))
                        .cornerRadius(20)
                        .shadow(radius: 10)

                        // Image Viewer Section
                        ImageViewer(image: selectedImage)
                            .frame(width: 350, height: 350)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .shadow(radius: 15)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.white, lineWidth: 4)
                                    .shadow(radius: 10)
                            )
                            .padding(.top, 20)

                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 30)
//                    .background(.ultraThinMaterial)
                    .shadow(radius: 20)
                }
            }
        }
        
    }
    
    // Method to load images from the local folder classified by category
    func loadClassifiedImages(for category: String) {
        let fileManager = FileManager.default
        do {
            let documentsURL = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let categoryURL = documentsURL.appendingPathComponent(category)
            
            // Verify if the folder exists
            guard fileManager.fileExists(atPath: categoryURL.path) else {
                print("Category folder does not exist: \(category)")
                return
            }
            
            // Iterate from "image-01" until the last file is found
            var images: [UIImage] = []
            var counter = 1
            while true {
                let fileName = String(format: "image-%02d.jpg", counter)
                let fileURL = categoryURL.appendingPathComponent(fileName)
                
                // Verify if the file exists
                if fileManager.fileExists(atPath: fileURL.path) {
                    if let image = UIImage(contentsOfFile: fileURL.path) {
                        images.append(image)
                    }
                    counter += 1
                } else {
                    // Exit the loop if the file is not found
                    break
                }
            }
            
            // Update the classified images
            classifiedImages = images
            print("Loaded \(classifiedImages.count) images for category \(category).")
        } catch {
            print("Error loading images for category \(category): \(error.localizedDescription)")
        }
    }
}

struct ImageViewer: View {
    var image: UIImage
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
        }
    }
}

#Preview {
    PlantInfoView(flowerName: "Cactus")
}
