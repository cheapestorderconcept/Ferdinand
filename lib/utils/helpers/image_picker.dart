import 'package:image_picker/image_picker.dart';

Future imagePicker(String? imageSource) async {
  final ImagePicker _picker = ImagePicker();
  final XFile? image = await _picker.pickImage(
      source:
          imageSource == 'gallery' ? ImageSource.gallery : ImageSource.camera);
  return image;
}
