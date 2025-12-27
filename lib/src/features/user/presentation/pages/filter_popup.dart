import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/user_bloc.dart';
import '../bloc/user_event.dart';

class FilterPopup extends StatelessWidget {
  const FilterPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Filter Users",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            Wrap(
              spacing: 10,
              children: [
                FilterChip(
                  label: const Text("Older 60+"),
                  onSelected: (_) {
                    context.read<UserBloc>().add(sortolder());
                    Navigator.pop(context);
                  },
                ),
                FilterChip(
                  label: const Text("Younger"),
                  onSelected: (_) {
                    context.read<UserBloc>().add(sortyounger());
                    Navigator.pop(context);
                  },
                ),
                FilterChip(
                  label: const Text("Reset"),
                  onSelected: (_) {
                    context.read<UserBloc>().add(sortreset());
                    Navigator.pop(context);
                  },
                ),
              ],
            ),

            const SizedBox(height: 18),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Close"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
