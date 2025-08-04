import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/core/theme/app_text_styles.dart';
import 'package:rick_and_morty_app/view_models/character_list_view_model.dart';
import 'package:rick_and_morty_app/views/widgets/character_card.dart';
import 'package:rick_and_morty_app/core/theme/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  bool _isSearching = false;
  final _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 80) {
      Provider.of<CharacterListViewModel>(
        context,
        listen: false,
      ).fetchMoreCharacters();
    }
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      final viewModel = Provider.of<CharacterListViewModel>(
        context,
        listen: false,
      );

      if (query.isNotEmpty) {
        viewModel.searchCharacters(query);
      } else {
        viewModel.clearSearch();
      }
    });
  }

  AppBar _buildDefaultAppBar() {
    return AppBar(
      title: Image.asset(
        'assets/images/rickandmortylogo.png',
        height: 72,
        width: 240,
        errorBuilder: (context, error, stackTrace) =>
            const Text('Rick And Morty'),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: AppColors.textPrimary),
          onPressed: () {
            setState(() {
              _isSearching = true;
            });
          },
        ),
      ],
    );
  }

  AppBar _buildSearchAppBar() {
    final viewModel = Provider.of<CharacterListViewModel>(
      context,
      listen: false,
    );
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
        onPressed: () {
          _debounce?.cancel();
          viewModel.clearSearch();
          setState(() {
            _isSearching = false;
            _searchController.clear();
          });
        },
      ),
      title: TextField(
        controller: _searchController,
        autofocus: true,
        decoration: const InputDecoration(
          hintText: 'Buscar personagens...',
          border: InputBorder.none,
          hintStyle: TextStyle(color: AppColors.textSecondary),
        ),
        style: const TextStyle(color: AppColors.textPrimary),
        onChanged: _onSearchChanged,
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.clear, color: AppColors.textPrimary),
          onPressed: () {
            _debounce?.cancel();
            viewModel.clearSearch();
            _searchController.clear();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isSearching ? _buildSearchAppBar() : _buildDefaultAppBar(),
      body: Consumer<CharacterListViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading && viewModel.characters.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.errorMessage != null && viewModel.characters.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Ocorreu um erro: ${viewModel.errorMessage}',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.errorMessage,
                ),
              ),
            );
          }

          return ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(8.0),
            itemCount: viewModel.hasMoreCharacters
                ? viewModel.characters.length + 1
                : viewModel.characters.length,
            itemBuilder: (context, index) {
              if (index >= viewModel.characters.length) {
                return viewModel.isLoadingMore
                    ? Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Image.asset(
                            'assets/gifs/rick-and-morty-television.gif',
                            width: 120,
                            height: 120,
                            fit: BoxFit.contain,
                          ),
                        ),
                      )
                    : const SizedBox.shrink();
              }

              final character = viewModel.characters[index];
              return CharacterCard(character: character);
            },
          );
        },
      ),
    );
  }
}
