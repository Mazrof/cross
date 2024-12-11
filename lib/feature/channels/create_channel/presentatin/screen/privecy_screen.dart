import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram/core/di/service_locator.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/feature/channels/create_channel/presentatin/controller/add_channel_cubit.dart';
import 'package:telegram/feature/channels/create_channel/presentatin/controller/add_channel_state.dart';

class PrivecyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Channel Settings'),
      ),
      body: BlocBuilder<AddChannelCubit, AddChannelState>(
        builder: (context, state) {
          if (state.state == CubitState.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Channel created successfully!')),
            );
            Navigator.of(context).pop();
          } else if (state.state == CubitState.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Error occurred')),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Channel Type',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                ListTile(
                  title: const Text('Public Channel'),
                  leading: Radio<bool>(
                    value: true,
                    groupValue: state.privacy,
                    onChanged: (value) => sl<AddChannelCubit>().setChannelPrivacy(value!),
                  ),
                ),
                ListTile(
                  title: const Text('Private Channel'),
                  leading: Radio<bool>(
                    value: false,
                    groupValue: state.privacy,
                    onChanged: (value) => sl<AddChannelCubit>().setChannelPrivacy(value!),
                  ),
                ),
                const SizedBox(height: 16),
                if (state.privacy)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextField(
                        decoration: InputDecoration(
                          labelText: 'Public Link',
                          prefixText: 't.me/',
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'If you set a public link, other people will be able to find and join your channel.\nYou can use a–z, 0–9, and underscores. Minimum length is 5 characters.',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Channel Name',
                  ),
                  onChanged: sl<AddChannelCubit>().setChannelName,
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Channel Image URL',
                  ),
                  onChanged: sl<AddChannelCubit>().setChannelImageUrl,
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.allSubscribers.length,
                    itemBuilder: (context, index) {
                      final subscriber = state.allSubscribers[index];
                      final isSelected =
                          state.selectedSubscribers.contains(subscriber);

                      return ListTile(
                        title: Text(subscriber.name),
                        trailing: Checkbox(
                          value: isSelected,
                          onChanged: (_) => sl<AddChannelCubit>()
                              .toggleSubscriber(subscriber),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                state.state == CubitState.loading
                    ? const Center(child: CircularProgressIndicator())
                    : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: sl<AddChannelCubit>().createChannel,
                          child: const Text('Create Channel'),
                        ),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
