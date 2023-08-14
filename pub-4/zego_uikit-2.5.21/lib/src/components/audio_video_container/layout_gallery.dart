// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:zego_uikit/src/components/audio_video/audio_video_view.dart';
import 'package:zego_uikit/src/components/audio_video/defines.dart';
import 'package:zego_uikit/src/components/audio_video/screen_sharing_controller.dart';
import 'package:zego_uikit/src/components/audio_video/screen_sharing_view.dart';
import 'package:zego_uikit/src/components/audio_video_container/gallery/grid_layout_delegate.dart';
import 'package:zego_uikit/src/components/audio_video_container/gallery/layout_gallery_last_item.dart';
import 'package:zego_uikit/src/components/audio_video_container/layout.dart';
import 'package:zego_uikit/src/components/defines.dart';
import 'package:zego_uikit/src/components/screen_util/screen_util.dart';
import 'package:zego_uikit/src/services/services.dart';

/// @nodoc
/// layout config of gallery
class ZegoLayoutGalleryConfig extends ZegoLayout {
  /// whether to display rounded corners and spacing between views
  bool addBorderRadiusAndSpacingBetweenView;

  /// screen sharing configs
  bool showNewScreenSharingViewInFullscreenMode;
  ZegoShowFullscreenModeToggleButtonRules
      showScreenSharingFullscreenModeToggleButtonRules;

  ZegoLayoutGalleryConfig({
    this.addBorderRadiusAndSpacingBetweenView = true,
    this.showNewScreenSharingViewInFullscreenMode = true,
    this.showScreenSharingFullscreenModeToggleButtonRules =
        ZegoShowFullscreenModeToggleButtonRules.showWhenScreenPressed,
  }) : super.internal();
}

/// @nodoc
/// picture in picture layout
class ZegoLayoutGallery extends StatefulWidget {
  const ZegoLayoutGallery({
    Key? key,
    required this.maxItemCount,
    required this.userList,
    required this.layoutConfig,
    this.backgroundColor = const Color(0xff171821),
    this.foregroundBuilder,
    this.backgroundBuilder,
    this.avatarConfig,
    this.screenSharingViewController,
  }) : super(key: key);

  final int maxItemCount;
  final List<ZegoUIKitUser> userList;
  final ZegoLayoutGalleryConfig layoutConfig;

  final Color backgroundColor;
  final ZegoAudioVideoViewForegroundBuilder? foregroundBuilder;
  final ZegoAudioVideoViewBackgroundBuilder? backgroundBuilder;

  /// avatar etc.
  final ZegoAvatarConfig? avatarConfig;

  final ZegoScreenSharingViewController? screenSharingViewController;

  @override
  State<ZegoLayoutGallery> createState() => _ZegoLayoutGalleryState();
}

/// @nodoc
class _ZegoLayoutGalleryState extends State<ZegoLayoutGallery> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final itemsConfig = getLayoutItemsConfig();

    final columnCount = itemsConfig.hasScreenSharing
        ? (itemsConfig.layoutItems.length > 1 ? 2 : 1)
        : (itemsConfig.layoutItems.length > 2 ? 2 : 1);
    final layoutItemsContainer = CustomMultiChildLayout(
      delegate: GridLayoutDelegate.autoFill(
        autoFillItems: itemsConfig.layoutItems,
        columnCount: columnCount,
        lastRowAlignment: GridLayoutAlignment.start,
        itemPadding: widget.layoutConfig.addBorderRadiusAndSpacingBetweenView
            ? Size(10.0.zR, 10.0.zR)
            : Size.zero,
      ),
      children: itemsConfig.layoutItems,
    );

    return LayoutBuilder(builder: (context, constraints) {
      final rowCountWithScreenSharing =
          (itemsConfig.layoutItems.length / columnCount).ceil() + 1;
      return Container(
        color: widget.backgroundColor,
        child: itemsConfig.hasScreenSharing
            ? Column(
                children: [
                  Container(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight / rowCountWithScreenSharing,
                    padding:
                        widget.layoutConfig.addBorderRadiusAndSpacingBetweenView
                            ? EdgeInsets.symmetric(
                                horizontal: 10.0.zR, vertical: 10.0.zR)
                            : EdgeInsets.zero,
                    child: itemsConfig.topScreenSharing,
                  ),
                  SizedBox(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight -
                        (constraints.maxHeight / rowCountWithScreenSharing),
                    child: layoutItemsContainer,
                  ),
                ],
              )
            : layoutItemsContainer,
      );
    });
  }

  _ZegoLayoutGalleryItemsConfig getLayoutItemsConfig() {
    final itemsConfig = _ZegoLayoutGalleryItemsConfig.empty(layoutItems: []);

    final layoutUsers = List<ZegoUIKitUser>.from(widget.userList);

    var lastUsers = <ZegoUIKitUser>[];

    final screenSharingLayoutItems = <LayoutId>[];
    final audioVideoListUserIDs =
        ZegoUIKit().getAudioVideoList().map((e) => e.id).toList();
    final screenSharingListUserIDs =
        ZegoUIKit().getScreenSharingList().map((e) => e.id).toList();
    for (var index = 0; index < layoutUsers.length; index++) {
      final layoutUser = layoutUsers.elementAt(index);

      /// audio video
      if (audioVideoListUserIDs.contains(layoutUser.id)) {
        final audioVideoView = LayoutBuilder(builder: (context, constraints) {
          return ZegoAudioVideoView(
            user: layoutUser,
            backgroundBuilder: widget.backgroundBuilder,
            foregroundBuilder: widget.foregroundBuilder,
            borderRadius:
                widget.layoutConfig.addBorderRadiusAndSpacingBetweenView
                    ? 18.0.zW
                    : null,
            borderColor: Colors.transparent,
            avatarConfig: widget.avatarConfig,
          );
        });
        itemsConfig.layoutItems.add(LayoutId(
          id: layoutUser.id,
          child: audioVideoView,
        ));
      }

      /// screen sharing
      if (screenSharingListUserIDs.contains(layoutUser.id)) {
        final audioVideoView = LayoutBuilder(builder: (context, constraints) {
          return ZegoScreenSharingView(
            user: layoutUser,
            backgroundBuilder: widget.backgroundBuilder,
            foregroundBuilder: widget.foregroundBuilder,
            borderRadius:
                widget.layoutConfig.addBorderRadiusAndSpacingBetweenView
                    ? 18.0.zW
                    : null,
            borderColor: Colors.transparent,
            controller: widget.screenSharingViewController,
            showFullscreenModeToggleButtonRules: widget
                .layoutConfig.showScreenSharingFullscreenModeToggleButtonRules,
          );
        });

        if (!itemsConfig.hasScreenSharing) {
          itemsConfig.topScreenSharing = audioVideoView;
        } else {
          screenSharingLayoutItems.add(LayoutId(
            id: layoutUser.id,
            child: audioVideoView,
          ));
        }

        itemsConfig.hasScreenSharing = true;
      }

      if ((itemsConfig.layoutItems.length +
              screenSharingLayoutItems.length +
              (itemsConfig.topScreenSharing != null ? 2 : 0)) >
          widget.maxItemCount) {
        if (index != layoutUsers.length - 1) {
          lastUsers = List<ZegoUIKitUser>.from(layoutUsers.sublist(index + 1));
        }
        break;
      }
    }

    if (lastUsers.isNotEmpty) {
      itemsConfig.layoutItems.add(LayoutId(
        id: 'sbs_last_users',
        child: ZegoLayoutGalleryLastItem(
          users: lastUsers,
          backgroundColor: const Color(0xff4A4B4D),
          borderRadius: widget.layoutConfig.addBorderRadiusAndSpacingBetweenView
              ? 18.0.zW
              : null,
          borderColor: Colors.transparent,
        ),
      ));
    }

    if (screenSharingLayoutItems.isNotEmpty) {
      itemsConfig.layoutItems.insertAll(0, screenSharingLayoutItems);
    }

    return itemsConfig;
  }
}

class _ZegoLayoutGalleryItemsConfig {
  bool hasScreenSharing;

  Widget? topScreenSharing;
  List<LayoutId> layoutItems;

  _ZegoLayoutGalleryItemsConfig({
    required this.hasScreenSharing,
    required this.topScreenSharing,
    required this.layoutItems,
  });

  _ZegoLayoutGalleryItemsConfig.empty({
    this.hasScreenSharing = false,
    this.layoutItems = const [],
  });
}
