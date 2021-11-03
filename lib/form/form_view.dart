import 'package:bloc_textfield/form/form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormView extends StatelessWidget {
  const FormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FormCubit(),
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _InputFormField(),
            const _UniqueKeyFormField(),
            const _HelloStateButton(),
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
        context.read<FormCubit>().updateText("Hello");
      },
      child: const Text("Set state to 'Hello'"),
    );
  }
}

class _InputFormField extends StatelessWidget {
  _InputFormField({
    Key? key,
  }) : super(key: key);

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<FormCubit, String>(
      listener: (context, state) {
        _controller.text = state;
      },
      child: TextFormField(
        controller: _controller,
        onChanged: (text) {
          context.read<FormCubit>().updateText(text);
        },
      ),
    );
  }
}

class _UniqueKeyFormField extends StatelessWidget {
  const _UniqueKeyFormField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormCubit, String>(
      builder: (context, state) {
        return TextFormField(
          key: UniqueKey(),
          initialValue: state,
          onChanged: (text) {
            context.read<FormCubit>().updateText(text);
          },
        );
      },
    );
  }
}
