import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc-aktarılacak/basvuru_form/form_bloc.dart';
import '../bloc-aktarılacak/basvuru_form/form_event.dart';
 
class FormScreen extends StatelessWidget {
  const FormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FormBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Başvuru Formu"),
          leading: const BackButton(),
          centerTitle: true,
        ),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: _FormFields(),
        ),
      ),
    );
  }
}

class _FormFields extends StatelessWidget {
  const _FormFields();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<FormBloc>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Ad/İşletme Adı"),
        const SizedBox(height: 8),
        TextField(
          decoration: _inputDecoration("Ad giriniz"),
          onChanged: (value) => bloc.add(NameChanged(value)),
        ),
        const SizedBox(height: 16),
        const Text("Katılım Amacı"),
        const SizedBox(height: 8),
        TextField(
          decoration: _inputDecoration("Katılım amacı giriniz"),
          maxLines: 4,
          onChanged: (value) => bloc.add(PurposeChanged(value)),
        ),
        const SizedBox(height: 16),
        const Text("Ek Not"),
        const SizedBox(height: 8),
        TextField(
          decoration: _inputDecoration("Opsiyonel"),
          onChanged: (value) => bloc.add(NoteChanged(value)),
        ),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              bloc.add(SubmitForm());
              final state = context.read<FormBloc>().state;
              if (state.name.isEmpty || state.purpose.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Lütfen gerekli alanları doldurun")),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Form başarıyla gönderildi")),
                );
              }
            },
            child: const Text("Gönder"),
          ),
        )
      ],
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}
