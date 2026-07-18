import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../core/annotations/debug_properties.dart';
import '../../../core/annotations/ephermal.dart';
import '../../misc/logger_service.dart';

typedef FetchDataCallback = Future<void> Function(int page, int pageSize);
typedef ScrollMaxExtent = int;
typedef AddAutomaticKeepAlive = bool;
typedef AddRepaintBoundary = bool;
typedef PreCacheExtentHeight = double;
typedef ShimmerWhilePaginationInProcess = Widget;


class PaginationWidget extends StatefulWidget {
  final int totalRecords;
  final int itemCount;
  final FetchDataCallback fetchData;
  final Widget Function(BuildContext, int) itemBuilder;
  final Widget Function(BuildContext, int)? separatorBuilder;
  final Widget noResultFound;
  final int pageSize;
  final ScrollMaxExtent maxExtent;
  final AddAutomaticKeepAlive addAutomaticKeepAlives;
  final PreCacheExtentHeight? cacheExtent;
  final AddRepaintBoundary addRepaintBoundary;
  final ShimmerWhilePaginationInProcess shimmer;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final ScrollController? controller;
  final EdgeInsetsGeometry? padding;
  final Axis scrollDirection;

  const PaginationWidget({
    super.key,
    required this.totalRecords,
    required this.fetchData,
    required this.itemBuilder,
    required this.itemCount,
    required this.noResultFound,
    required this.shimmer,
    this.shrinkWrap = false,
    this.maxExtent = 500,
    this.separatorBuilder,
    this.pageSize = 10,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundary = true,
    this.cacheExtent,
    this.physics,
    this.controller,
    this.padding,
    this.scrollDirection = Axis.vertical,
  });

  @override
  State<PaginationWidget> createState() => _PaginationWidgetState();

  @DebugProperties(
    purpose:
        'Provides debugging information for pagination configuration and state',
    trackedProperties: [
      'totalRecords - Total number of records available',
      'itemCount - Current number of loaded items',
      'pageSize - Number of items per page',
      'maxExtent - Scroll threshold for loading more items',
      'cacheExtent - Extent of item caching',
      'shrinkWrap - ListView shrink wrap status',
      'addAutomaticKeepAlives - Keep alive status',
      'addRepaintBoundary - Repaint boundary status',
      'separatorBuilder - Custom separator presence'
    ],
    notes:
        'These properties are crucial for understanding pagination behavior and performance optimization',
  )
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('totalRecords', totalRecords));
    properties.add(IntProperty('itemCount', itemCount));
    properties.add(IntProperty('pageSize', pageSize));
    properties.add(IntProperty('maxExtent', maxExtent));
    properties.add(DoubleProperty('cacheExtent', cacheExtent));
    properties.add(FlagProperty('shrinkWrap',
        value: shrinkWrap,
        ifTrue: 'shrinkWrap: enabled',
        ifFalse: 'shrinkWrap: disabled'));
    properties.add(FlagProperty('addAutomaticKeepAlives: ',
        value: addAutomaticKeepAlives,
        ifTrue: 'addAutomaticKeepAlives: enabled',
        ifFalse: 'addAutomaticKeepAlives: disabled'));
    properties.add(FlagProperty('addRepaintBoundary',
        value: addRepaintBoundary,
        ifTrue: 'addRepaintBoundary: enabled',
        ifFalse: 'addRepaintBoundary: disabled'));
    properties.add(ObjectFlagProperty<Widget Function(BuildContext, int)?>.has(
        'separatorBuilder', separatorBuilder));
  }
}

@Ephemeral('Handles scroll state and pagination loading logic')
class _PaginationWidgetState extends State<PaginationWidget> {
  late ScrollController _scrollController;
  bool _isLoading = false;
  bool _hasListeners = false;
  int _lastItemCount = -1;
  late PreCacheExtentHeight _cacheExtent;
  
  static const Key _listViewKey = PageStorageKey('pagination_listview');

  @override
  void initState() {
    super.initState();
    _scrollController = widget.controller ?? ScrollController();
  }

  @override
  void didUpdateWidget(PaginationWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.itemCount != oldWidget.itemCount) {
      _lastItemCount = -1;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cacheExtent = widget.cacheExtent ?? MediaQuery.sizeOf(context).height * 0.75;
    
    if (!_hasListeners) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _setupScrollListener();
      });
    }
  }

  void _setupScrollListener() {
    if (_hasListeners || !mounted) return;
    _scrollController.addListener(_handleScroll);
    _hasListeners = true;
  }

  void _handleScroll() {
    if (!mounted || !_scrollController.hasClients) return;
    
    final position = _scrollController.position;
    final isNearBottom = position.extentAfter < widget.maxExtent;
    final hasMoreData = widget.itemCount < widget.totalRecords;
    
    if (isNearBottom && hasMoreData && !_isLoading && widget.itemCount != _lastItemCount) {
      _fetchNextPage();
    }
  }

  Future<void> _fetchNextPage() async {
    if (_isLoading || !mounted) {
      LoggerService.log("Skip pagination: isLoading=$_isLoading, mounted=$mounted");
      return;
    }

    setState(() {
      _isLoading = true;
    });
    
    try {
      final currentPage = (widget.itemCount / widget.pageSize).ceil() + 1;
      LoggerService.log("Fetching page $currentPage with pageSize ${widget.pageSize}");
      final currentItemCount = widget.itemCount;
      await widget.fetchData(currentPage, widget.pageSize);
      if (mounted && widget.itemCount == currentItemCount) {
        _lastItemCount = widget.itemCount;
      }
    } catch (e) {
      LoggerService.log("Error fetching next page: $e");
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LoggerService.log("PaginationWidget build - itemCount: ${widget.itemCount}, totalRecords: ${widget.totalRecords}, isLoading: $_isLoading");
    
    if (widget.itemCount < 1) {
      LoggerService.log("No items found, showing noResultFound widget");
      return Center(child: widget.noResultFound);
    }

    // Calculate item count safely
    int displayItemCount = widget.itemCount;
    bool showLoader = _isLoading && widget.itemCount < widget.totalRecords;
    if (showLoader) {
      displayItemCount += 1;
    }

    LoggerService.log("Display info: itemCount=${widget.itemCount}, displayItemCount=$displayItemCount, showLoader=$showLoader");

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        return false;
      },
      child: ListView.separated(
        padding: widget.padding ?? EdgeInsets.zero,
        key: _listViewKey,
        scrollDirection: widget.scrollDirection,
        shrinkWrap: widget.shrinkWrap,
        cacheExtent: _cacheExtent,
        addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
        addRepaintBoundaries: widget.addRepaintBoundary,
        controller: _scrollController,
        physics: widget.physics ?? const AlwaysScrollableScrollPhysics(),
        itemCount: displayItemCount,
        separatorBuilder: widget.separatorBuilder ?? (_, _) => 
            widget.scrollDirection == Axis.vertical 
                ? const SizedBox(height: 10) 
                : const SizedBox(width: 10),
        itemBuilder: (context, index) {
          LoggerService.log("Building item at index $index (total: $displayItemCount)");
          
          // Show loading indicator at the end
          if (showLoader && index == displayItemCount - 1) {
            LoggerService.log("Showing loading shimmer at index $index");
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              key: const ValueKey('pagination_loading_indicator'),
              child: Center(child: widget.shimmer),
            );
          }
          
          // Ensure index is within bounds
          if (index >= widget.itemCount) {
            LoggerService.log(" Index $index is out of bounds (itemCount: ${widget.itemCount})");
            return const SizedBox.shrink();
          }
          
          return widget.itemBuilder(context, index);
        },
      ),
    );
  }
}
