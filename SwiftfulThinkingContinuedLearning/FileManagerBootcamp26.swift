//
//  FileManagerBootcamp26.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by User03 on 05.02.2023.
//

import SwiftUI

class LocalFileManager {
    static let instance = LocalFileManager()
    
    let folderName = "MyApp_Images"
    
    init() {
        createFolderIfNeeded()
    }
    
    func createFolderIfNeeded() {
        guard let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent(folderName).path else { return }
        
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.createDirectory(atPath: path,  withIntermediateDirectories: true)
                print("Success creating folder.")
            } catch let error {
                print("Error creating folder. \(error)")
            }
        }
    }
    
    func deleteFolder() {
        guard let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent(folderName).path else { return }

        do {
            try FileManager.default.removeItem(atPath: path)
        } catch let error {
            print("Error deleting folder \(error)")
        }
    }
    
    func getPathForImage(name: String) -> URL? {
        
//        let cachesDirectoryURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)       // путь к кешу
//        let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)   // путь к документам
//        let temporaryDirectory URL = FileManager.default.temporaryDirectory                                 // путь к временным файлам
        
        // после того как получили URL нужной нам директории создаем путь где будет лежать файл в который будем сохранять нашу data
//        let path = cachesDirectoryURL?.appendingPathExtension("\(name).jpg")
        
        
        // получаем URL директории и добавляем путь к файлу в одной строке
        guard let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent(folderName).appendingPathComponent("\(name).jpg") else {
            print("Error getting path")
            return nil
        }
        
        return path
    }
    
    
    //MARK: - saveImage
    func saveImage(image: UIImage, name: String) -> String {
        // конвертируем jpeg картинку в data при этом сжимая её (для png используем image.pngData())
        guard let data = image.jpegData(compressionQuality: 1.0),
        // получаем путь к файлу
              let path = getPathForImage(name: name) else {
            return "Error gettitn data"
            
        }
        
        // сохраняем картинку в файл по созданному выше пути
        do {
            try data.write(to: path)
            return "Success saving"
        } catch let error {
            return "Error saving. \(error)"
        }
    }
    
    //MARK: - getImage
    func getImage(name: String) -> UIImage? {
        // получаем путь к файлу
        guard let path = getPathForImage(name: name)?.path,
        // проверяем существует ли файл по заданному пути
        FileManager.default.fileExists(atPath: path) else {
            return nil
        }
        // возвращаем картинку
        return UIImage(contentsOfFile: path)
    }
    
    //MARK: - deleteImage
    func deleteImage(name: String) -> String {
        // получаем путь к файлу
        guard let path = getPathForImage(name: name),
        // проверяем существует ли файл по заданному пути
        FileManager.default.fileExists(atPath: path.path) else {
            return "Error getting path"
        }
        
        // удаляем картинку
        do {
            try FileManager.default.removeItem(at: path)
            return "Successfilly deleted"
        } catch let error {
            return "Error deliting image. \(error)"
        }
    }
}

class FileManagerViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var infoMessage = ""
    
    let imageName = "photo"
    let manager = LocalFileManager.instance
    
    init() {
//        getImageFromAssetsFolder()
        getImageFromFileManager()
    }
    
    func getImageFromAssetsFolder() {
        image = UIImage(named: imageName)
    }
    
    func getImageFromFileManager() {
        image = manager.getImage(name: imageName)
    }
    
    func saveImage() {
        guard let image = image else { return }
        infoMessage = manager.saveImage(image: image, name: imageName)
        print("saved")
    }
    
    func deleteImage() {
        infoMessage = manager.deleteImage(name: imageName)
        manager.deleteFolder()
    }
}

struct FileManagerBootcamp26: View {
    
    @StateObject var vm = FileManagerViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if let image = vm.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(20)
                }
                
                HStack {
                    Button {
                        vm.saveImage()
                    } label: {
                        Text("Save to FM")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .padding(.horizontal)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                    Button {
                        vm.deleteImage()
                    } label: {
                        Text("Delete from FM")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .padding(.horizontal)
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                }

                Text(vm.infoMessage)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.purple)
                
                Spacer()
            }
            .navigationTitle("File manager")
        }
    }
}

struct FileManagerBootcamp26_Previews: PreviewProvider {
    static var previews: some View {
        FileManagerBootcamp26()
    }
}
