import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:telegram/core/component/clogo_loader.dart';
import 'package:telegram/core/component/csnack_bar.dart';
import 'package:telegram/core/routes/app_router.dart';
import 'package:telegram/core/utililes/app_enum/app_enum.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';
import 'package:telegram/feature/search/Presentation/Widget/search_result_tile.dart';
import 'package:telegram/feature/search/Presentation/controller/global_search_cubit.dart';
import 'package:telegram/feature/search/Presentation/controller/global_search_state.dart';

class GlobalSearchScreen extends StatelessWidget {
  const GlobalSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalSearchCubit, GlobalSearchState>(
      builder: (context, state) {
        if (state.state == CubitState.loading) {
          return const LogoLoader();
        } else if (state.state == CubitState.failure) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            CSnackBar.showErrorSnackBar(context, 'Error', state.errorMessage!);
          });
        } else if (state.state == CubitState.success) {
          return GlobalSearchPage(state: state);
        }
        return GlobalSearchPage(state: state);
      },
    );
  }
}

class GlobalSearchPage extends StatelessWidget {
  final GlobalSearchState state;

  const GlobalSearchPage({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final searchInputController = TextEditingController();
    final cubit = context.read<GlobalSearchCubit>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.brown),
          onPressed: () {
            context.go(AppRouter.kHome);
          },
        ),
        title: TextField(
          controller: searchInputController,
          maxLength: 40,
          decoration: const InputDecoration(
            counterText: "",
            hintText: 'Search...',
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.blue),
            onPressed: () async {
              final query = searchInputController.text;
              if (query.isNotEmpty) {
                await cubit.globalSearch(query);
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.chat,
                    color: state.selectedCategory == SearchCategory.chats
                        ? Colors.blue
                        : Colors.grey,
                  ),
                  onPressed: () {
                    cubit.updateCategory(SearchCategory.chats);
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.person,
                    color: state.selectedCategory == SearchCategory.users
                        ? Colors.blue
                        : Colors.grey,
                  ),
                  onPressed: () {
                    cubit.updateCategory(SearchCategory.users);
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.broadcast_on_personal_rounded,
                    color: state.selectedCategory == SearchCategory.channels
                        ? Colors.blue
                        : Colors.grey,
                  ),
                  onPressed: () {
                    cubit.updateCategory(SearchCategory.channels);
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.group,
                    color: state.selectedCategory == SearchCategory.groups
                        ? Colors.blue
                        : Colors.grey,
                  ),
                  onPressed: () {
                    cubit.updateCategory(SearchCategory.groups);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: _buildContent(state),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(GlobalSearchState state) {
    switch (state.selectedCategory) {
      case SearchCategory.users:
        return ListView.builder(
          itemCount: state.userResult.length,
          itemBuilder: (context, index) {
            final user = state.userResult[index];
            return SearchResultTile(
              leading: const CircleAvatar(child: Icon(Icons.person)),
              searchTitle: user.name,
              // searchSubtitle: Text("ID ${user.id}"),
              trailing: const Text("16.04.23"),
            );
          },
        );
      case SearchCategory.channels:
        return ListView.builder(
          itemCount: state.channelResult.length,
          itemBuilder: (context, index) {
            final channel = state.channelResult[index];
            return SearchResultTile(
              leading: const CircleAvatar(child: Icon(Icons.chat)),
              searchTitle: channel.name,
              // searchSubtitle: Text("ID ${channel.id}"),
            );
          },
        );
      case SearchCategory.groups:
        return ListView.builder(
          itemCount: state.groupResult.length,
          itemBuilder: (context, index) {
            final group = state.groupResult[index];
            return SearchResultTile(
              leading: const CircleAvatar(child: Icon(Icons.group)),
              searchTitle: group.name,
              // searchSubtitle: Text("ID ${group.id}"),
            );
          },
        );
      default:
        return const Center(child: Text("No results found"));
    }
  }
}
