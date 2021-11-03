import 'package:bloc/bloc.dart';

class FormCubit extends Cubit<String> {
  FormCubit() : super("");

  void updateText(String text) => emit(text);
}
