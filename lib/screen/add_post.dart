// ignore_for_file: avoid_unnecessary_containers

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertest1/screen/addpost_text.dart';

import 'package:photo_manager/photo_manager.dart';

class AddPostScreen extends StatefulWidget {
  final ScrollController? scrollCtr;

  const AddPostScreen({
    Key? key,
    this.scrollCtr,
  }) : super(key: key);

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final List<Widget> _mediaList = [];
  final List<File> path = [];
  File? _file;
  int currentPage = 0;
  int? lastPage;

  @override
  void initState() {
    super.initState();
    _fetchNewMedia();
  }

  handleScrollEvent(ScrollNotification scroll) {
    if (scroll.metrics.pixels / scroll.metrics.maxScrollExtent > 0.33) {
      if (currentPage != lastPage) {
        _fetchNewMedia();
      }
    }
  }

  _fetchNewMedia() async {
    lastPage = currentPage;
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps.isAuth) {
      // success
//load the album list
      List<AssetPathEntity> albums =
          await PhotoManager.getAssetPathList(onlyAll: true);
      print(albums);
      List<AssetEntity> media = await albums[0]
          .getAssetListPaged(size: 60, page: currentPage); //preloading files
      print(media);
      for (var asset in media) {
        if (asset.type == AssetType.image) {
          // Get the file path for image assets
          final file = await asset.file;
          if (file != null) {
            path.add(File(file.path));
            print(path);
            _file = path[0];
            print(_file);
          }
        }
      }

      List<Widget> temp = [];
      for (var asset in media) {
        // path.add(asset.title!);
        temp.add(
          FutureBuilder(
            future: asset.thumbnailDataWithSize(
                const ThumbnailSize(200, 200)), //resolution of thumbnail
            builder:
                (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
              if (snapshot.connectionState == ConnectionState.done)
                // ignore: curly_braces_in_flow_control_structures
                return Container(
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Image.memory(
                          snapshot.data!,
                          fit: BoxFit.cover,
                        ),
                      ),
                      if (asset.type == AssetType.video)
                        const Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 5, bottom: 5),
                            child: Icon(
                              Icons.videocam,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              return Container();
            },
          ),
        );
      }
      setState(() {
        _mediaList.addAll(temp);
        currentPage++;
      });
    } else {
      // fail
      /// if result is fail, you can call `PhotoManager.openSetting();`  to open android/ios applicaton's setting to get permission
    }
  }

  @override
  int indexx = 0;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'New Post',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddpostTextScreen(_file!)));
                },
                child: Text(
                  'Nex',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 375.h,
                child: GridView.builder(
                    shrinkWrap: true,
                    controller: widget.scrollCtr,
                    itemCount: _mediaList.isEmpty ? _mediaList.length : 1,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 1.h,
                      crossAxisSpacing: 1.w,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return _mediaList[indexx];
                    }),
              ),
              Container(
                width: double.infinity,
                height: 40.h,
                color: Colors.white,
                child: Row(
                  children: [
                    SizedBox(width: 10.w),
                    Text(
                      'Recent',
                      style: TextStyle(
                          fontSize: 15.sp, fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: CircleAvatar(
                        radius: 15.r,
                        backgroundColor: Colors.grey.shade600,
                        child: Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white,
                          size: 20.w,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              GridView.builder(
                  shrinkWrap: true,
                  controller: widget.scrollCtr,
                  itemCount: _mediaList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 1.h,
                      crossAxisSpacing: 2.w),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          setState(() {
                            indexx = index;
                            _file = path[index];
                            print(_file);
                          });
                        },
                        child: _mediaList[index]);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
