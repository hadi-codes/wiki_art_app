import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wiki_art/Api/src/models/painting.dart';

part 'image_dialog_state.dart';

class ImageDialogCubit extends Cubit<ImageDialogState> {
  ImageDialogCubit(this.isVisable) : super(ImageDialogState(isVisble: false));
  bool isVisable;

  void show(Painting painting) {
    this.isVisable = true;
    emit(ImageDialogState(isVisble: isVisable, painting: painting));
    print("bShow${state.isVisble}");
  }

  void hide() {
    this.isVisable = false;
    emit(ImageDialogState(isVisble: isVisable));
    print("bHide${state.isVisble}");
  }
}
