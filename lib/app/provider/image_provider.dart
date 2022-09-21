import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uandi/app/model/couple.dart';
import 'package:uandi/app/provider/counter_provider.dart';

final imageProvider = StateNotifierProvider<ImageNotifier, Couple>(
  (ref) => ImageNotifier(),
);

class ImageNotifier extends StateNotifier<Couple> {
  ImageNotifier() : super(Couple());



  void saveBackgroundImage(WidgetRef ref) async {
    final box = await Hive.openBox<Couple>('couple');
    int id = 0;
    box.put(
      id,
      Couple(
        backgroundImage: ref.watch(backgroundImageProvider.state).state,
      ),
    );
  }

  Future pickBackgroundImage() async {
    // XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    // if (pickedImage != null) {
    //   Uint8List _image = await pickedImage.readAsBytes();
    // }
    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      return await file.readAsBytes();
    }
    print('No image selected');
  }
}
