import 'package:get/get.dart';
import 'song_list_controller.dart';

/// Binding para Register.
class SongListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SongListController>(() => SongListController());
  }
}
