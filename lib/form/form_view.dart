import 'package:bloc_textfield/form/form.dart';
import 'package:flutter/material.dart' hide FormState;
import 'package:flutter_bloc/flutter_bloc.dart';

class FormView extends StatelessWidget {
  const FormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FormBloc(),
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            _InputFormField(),
            _HelloStateButton(),
          ],
        ),
      ),
    );
  }
}

class _HelloStateButton extends StatelessWidget {
  const _HelloStateButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<FormBloc>().add(HelloButtonTapped("Hello"));
      },
      child: const Text("Set state to 'Hello'"),
    );
  }
}

class _InputFormField extends StatefulWidget {
  const _InputFormField({
    Key? key,
  }) : super(key: key);

  @override
  State<_InputFormField> createState() => _InputFormFieldState();
}

class _InputFormFieldState extends State<_InputFormField> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FormBloc, FormState>(
      listenWhen: (previous, current) => current.refresh,
      listener: (context, state) => _controller.text = state.text,
      builder: (context, state) {
        return TextFormField(
          controller: _controller,
          decoration: const InputDecoration(label: Text("Controller")),
          onChanged: (text) {
            context.read<FormBloc>().add(TextFieldUpdated(text));
          },
        );
      },
    );
  }
}
