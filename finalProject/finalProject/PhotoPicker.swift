import SwiftUI
import PhotosUI

struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Binding var backgroundColor: Color
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        configuration.filter = .images
        configuration.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: PHPickerViewControllerDelegate {
        private let parent: PhotoPicker
        
        init(parent: PhotoPicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            guard !results.isEmpty else {
                parent.selectedImage = nil
                parent.backgroundColor = .white
                picker.dismiss(animated: true)
                return
            }
            
            if let provider = results.first?.itemProvider {
                if provider.canLoadObject(ofClass: UIImage.self) {
                    provider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                        if let image = image as? UIImage {
                            DispatchQueue.main.async {
                                self?.parent.selectedImage = image
                                let color = image.averageColor.map { Color($0) } ?? .white
                                print("Average color:", color)
                                self?.parent.backgroundColor = color
                            }
                        }
                    }
                }
            }
            
            picker.dismiss(animated: true)
        }
        
        func show_meta(_ image: PHPickerResult) {
            if image.itemProvider.hasItemConformingToTypeIdentifier(UTType.image.identifier) {
                image.itemProvider.loadDataRepresentation(forTypeIdentifier: UTType.image.identifier) { data, error in
                    guard let data = data else {
                        print("Error loading data:", error ?? "Unknown error")
                        return
                    }
                    // Extract metadata from data here
                    print("Loaded image data:", data)
                }
            }
        }
    }
}

