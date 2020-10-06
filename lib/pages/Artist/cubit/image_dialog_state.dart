part of 'image_dialog_cubit.dart';

class ImageDialogState extends Equatable {
  const ImageDialogState({this.isVisble, this.painting});
  final bool isVisble;
  final Painting painting;
  @override
  List<Object> get props => [isVisble];
}
