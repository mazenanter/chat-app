import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_chat_app/cubits/status_cubit/cubit.dart';
import 'package:my_chat_app/cubits/status_cubit/states.dart';
import 'package:my_chat_app/views/status_view.dart';
import 'package:my_chat_app/widgets/custom_indicator.dart';

class StatusListView extends StatelessWidget {
  const StatusListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StatusCubit, StatusStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = StatusCubit.get(context).statusList;
        return state is GetStatusLoadingState
            ? const CustomIndicator()
            : list.isEmpty
                ? const Center(
                    child: Text(
                    'No Stroies Yet',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ))
                : ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) =>
                        StatusView(model: list[index], index: index),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: .01,
                    ),
                    itemCount: list.length,
                  );
      },
    );
  }
}
