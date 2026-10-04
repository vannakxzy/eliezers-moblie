import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:photo_view/photo_view.dart';

import '../../../app/base/page/base_page_bloc_state.dart';
import '../../../core/constants/icon_constant.dart';
import '../../../data/data_sources/remotes/report_api_service.dart';
import '../bloc/bloc/display_image_bloc.dart';
import '../bottomsheet/display_image_bottomsheet.dart';

class DisplayImagePage extends StatefulWidget {
  final String imageUrl;
  final String tag;
  final ReportInput report;
  final bool isYourImage;
  const DisplayImagePage(
      {super.key,
      required this.imageUrl,
      required this.isYourImage,
      required this.report,
      required this.tag});

  @override
  State<DisplayImagePage> createState() => _DisplayImagePageState();
}

class _DisplayImagePageState
    extends BasePageBlocState<DisplayImagePage, DisplayImageBloc> {
  @override
  void initState() {
    debugPrint("image ${widget.imageUrl}");
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const CloseButton(),
        actions: [
          IconButton(
            onPressed: () {
              DisplayImageBottomsheet.show(context, (value) {
                if (value == displayImageEnum.downloadImage) {
                  bloc.add(ClickDownloadImage(widget.imageUrl));
                }
                if (value == displayImageEnum.report) {
                  bloc.add(ClickReportImage(
                      widget.report.copyWith(reason: "Image Issue")));
                }
              }, widget.isYourImage);
            },
            icon: const Icon(
              MiconMoreHori,
              size: 30,
            ),
          ),
        ],
      ),
      body: Center(
        child: GestureDetector(
          onDoubleTap: () {
            Navigator.of(context).pop();
          },
          child: Hero(
            tag: widget.tag,
            child: PhotoView(
              imageProvider: CachedNetworkImageProvider(widget.imageUrl),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered,
              backgroundDecoration:
                  BoxDecoration(color: context.moonColors!.goku),
            ),
          ),
        ),
      ),
    );
  }
}
