import 'package:bloc/bloc.dart';

abstract class FormEvent {
  final String text;

  const FormEvent(this.text);
}

class TextFieldUpdated extends FormEvent {
  TextFieldUpdated(String text) : super(text);
}

class HelloButtonTapped extends FormEvent {
  HelloButtonTapped(String text) : super(text);
}

class FormState {
  final String text;
  final bool refresh;

  const FormState(this.text, this.refresh);

  static const empty = FormState("", false);
}

class FormBloc extends Bloc<FormEvent, FormState> {
  FormBloc() : super(FormState.empty) {
    on<TextFieldUpdated>(
      (event, emit) {
        emit(FormState(event.text, false));
      },
    );
    on<HelloButtonTapped>(
      (event, emit) {
        emit(FormState(event.text, true));
      },
    );
  }
}
