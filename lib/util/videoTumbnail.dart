import 'package:video_compress/video_compress.dart';

_compressVideo(String videoPath) async {
  final compressvideo = await VideoCompress.compressVideo(
    videoPath,
    quality: VideoQuality.MediumQuality,
  );
  return compressvideo!.file;
}
