

import 'package:bloc/bloc.dart';
import 'package:bloc_counter/bloc/imagePicker/image_picker_event.dart';
import 'package:bloc_counter/bloc/imagePicker/image_picker_state.dart';
import 'package:bloc_counter/ui/util/image_picker_util.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent,ImagePickerState>{

  final ImagePickerUtil imagePickerUtil;
  ImagePickerBloc(this.imagePickerUtil):super(ImagePickerState()){


  on<CameraCapture>(cameraCapture);
}

void cameraCapture(CameraCapture event, Emitter<ImagePickerState> states ) async{

   XFile? file=await imagePickerUtil.cameraCapture();
   emit(state.copyWith(file: file));
}

}