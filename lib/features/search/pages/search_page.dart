import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/dependency_injection.dart';
import 'package:flutter_ecommerce/features/product/widgets/product_card.dart';
import 'package:flutter_ecommerce/features/search/blocs/search_bloc/search_bloc.dart';
import 'package:flutter_ecommerce/features/search/widgets/search_field.dart';
import 'package:flutter_ecommerce/features/search/widgets/search_filters.dart';
import 'package:gap/gap.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _minPriceController = TextEditingController();
  final TextEditingController _maxPriceController = TextEditingController();
  Timer? _debounce;
  double? _minPrice;
  double? _maxPrice;
  bool _showDiscountedOnly = false;
  final _searchBloc = sl<SearchBloc>();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _minPriceController.dispose();
    _maxPriceController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _applyFilters();
    });
  }

  void _applyFilters() {
    sl<SearchBloc>().add(SearchEvent.search(
      _searchController.text,
      minPrice: _minPrice,
      maxPrice: _maxPrice,
      showDiscountedOnly: _showDiscountedOnly,
    ));
  }

  void _clearFilters() {
    setState(() {
      _minPriceController.clear();
      _maxPriceController.clear();
      _minPrice = null;
      _maxPrice = null;
      _showDiscountedOnly = false;
    });
    _applyFilters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildDiscover(context),
            _buildSearchField(context),
            _buildSearchFilter(),
            _buildProducts(),
          ],
        ),
      ),
    );
  }

  SliverAppBar _buildSearchField(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: 0,
      scrolledUnderElevation: 0.0,
      title: SearchField(searchController: _searchController),
    );
  }

  Widget _buildSearchFilter() {
    return SliverToBoxAdapter(
      child: SearchFilters(
        minPrice: _minPrice,
        maxPrice: _maxPrice,
        minPriceController: _minPriceController,
        maxPriceController: _maxPriceController,
        showDiscountedOnly: _showDiscountedOnly,
        onMinPriceChanged: (value) => setState(() => _minPrice = value),
        onMaxPriceChanged: (value) => setState(() => _maxPrice = value),
        onDiscountedOnlyChanged: (value) =>
            setState(() => _showDiscountedOnly = value),
        onApplyFilters: _applyFilters,
        onClearFilters: _clearFilters,
      ),
    );
  }

  SliverToBoxAdapter _buildDiscover(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppBar(
              backgroundColor: Theme.of(context).colorScheme.surface,
              elevation: 0,
              title: Text(
                'Discover',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            ),
            const Gap(16),
          ],
        ),
      ),
    );
  }

  BlocBuilder<SearchBloc, SearchState> _buildProducts() {
    return BlocBuilder<SearchBloc, SearchState>(
      bloc: _searchBloc,
      builder: (context, state) {
        return state.maybeWhen(
          loading: () => const SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          ),
          failure: (failure) => SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${failure.toString()}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ),
          loaded: (products) => products.isEmpty
              ? const SliverFillRemaining(
                  child: Center(
                    child: Text('No products found'),
                  ),
                )
              : SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.85,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final product = products[index];
                        return ProductCard(
                          product: product,
                        );
                      },
                      childCount: products.length,
                    ),
                  ),
                ),
          orElse: () => const SliverFillRemaining(
            child: Center(
              child: Text('Start searching for products'),
            ),
          ),
        );
      },
    );
  }
}
