import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../core/utils/widgets/custom_loading.dart';

class AppSmartRefreshScrollView extends StatefulWidget {
  const AppSmartRefreshScrollView({
    super.key,
    required this.child,
    this.onRefresh,
    this.onLoadMore,
    this.isRefresh = true,
    this.enableLoadMore = true, // Default is true
  });

  final Future<void> Function()? onRefresh;
  final Future<void> Function()? onLoadMore;
  final bool enableLoadMore; // Toggle for load more functionality
  final Widget child;
  final bool isRefresh;

  @override
  State<AppSmartRefreshScrollView> createState() =>
      _AppSmartRefreshScrollViewState();
}

class _AppSmartRefreshScrollViewState extends State<AppSmartRefreshScrollView> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    try {
      await widget.onRefresh?.call(); // Call the onRefresh callback
      await Future.delayed(const Duration(milliseconds: 500)); // Add delay
      _refreshController.refreshCompleted();
    } catch (e) {
      await Future.delayed(const Duration(milliseconds: 500)); // Add delay
      _refreshController.refreshFailed();
    }
  }

  void _onLoading() async {
    // Add a delay to maintain consistency
    await Future.delayed(const Duration(milliseconds: 500)); // Add delay

    if (!widget.enableLoadMore) {
      // When loading more is disabled, complete the loading and show "No more data"
      _refreshController.loadComplete();
      setState(() {}); // Trigger rebuild to update footer text
      return;
    }

    try {
      await widget.onLoadMore?.call(); // Call the onLoadMore callback
      _refreshController.loadComplete();
    } catch (e) {
      _refreshController.loadFailed();
    }
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
        physics: const ClampingScrollPhysics(), // <-- Add this line here
        enablePullDown: true,
        enablePullUp:
            widget.enableLoadMore, // Enable pull-up based on condition
        header: CustomHeader(
          builder: (_, mode) => const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(child: CustomLoading()),
          ),
        ),
        footer: CustomFooter(
          builder: (context, mode) {
            Widget? body;
            if (mode == LoadStatus.loading) {
              body = const CustomLoading();
            } else if (mode == LoadStatus.failed) {
              body = const Text("Load Failed! Click retry!");
            } else if (mode == LoadStatus.canLoading) {
              body = const CustomLoading();
            }
            return SizedBox(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: widget.child);
  }
}
