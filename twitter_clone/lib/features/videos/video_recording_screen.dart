import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:saver_gallery/saver_gallery.dart';
import 'package:twitter_clone/constants/gaps.dart';
import 'package:twitter_clone/constants/sizes.dart';
import 'package:twitter_clone/features/videos/video_preview_screen.dart';

class VideoRecordingScreen extends StatefulWidget {
  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  bool _hasPermissions = false;
  bool _isSefieMode = false;

  late CameraController _cameraController;
  late FlashMode _flashMode;

  Future<void> _initPermissions() async {
    final cameraPermission = await Permission.camera.request();
    final microphonePermission = await Permission.microphone.request();

    final cameraDenied =
        cameraPermission == PermissionStatus.denied ||
        cameraPermission == PermissionStatus.permanentlyDenied;
    final microphoneDenied =
        microphonePermission == PermissionStatus.denied ||
        microphonePermission == PermissionStatus.permanentlyDenied;

    if (!cameraDenied && !microphoneDenied) {
      _hasPermissions = true;
      await _initCamera();
      setState(() {});
    }
  }

  Future<void> _initCamera() async {
    try {
      final cameras = await availableCameras();
      print(cameras);

      if (cameras.isEmpty) return;

      _cameraController = CameraController(
        _isSefieMode ? cameras[3] : cameras[0],
        ResolutionPreset.ultraHigh,
        enableAudio: true,
      );

      await _cameraController.initialize();
      await _cameraController.prepareForVideoRecording(); // only for ios
      _flashMode = _cameraController.value.flashMode;

      setState(() {});
    } catch (e) {
      print('Camera initialization error: $e');
    }
  }

  Future<void> _toggleSefieMode() async {
    _isSefieMode = !_isSefieMode;
    await _initCamera();
    setState(() {});
  }

  Future<void> _setFlashMode(FlashMode flashMode) async {
    _flashMode = flashMode;
    await _cameraController.setFlashMode(_flashMode);
    setState(() {});
  }

  Future<void> _toggleFlashMode() async {
    if (_flashMode == FlashMode.off) {
      await _setFlashMode(FlashMode.auto);
    } else if (_flashMode == FlashMode.auto) {
      await _setFlashMode(FlashMode.torch);
    } else {
      await _setFlashMode(FlashMode.off);
    }
  }

  Future<void> _takePhoto() async {
    if (!_cameraController.value.isInitialized) return;

    final image = await _cameraController.takePicture();
    SaverGallery.saveFile(
      filePath: image.path,
      fileName: image.path.split('/').last,
      androidRelativePath: "Pictures",
      skipIfExists: true,
    );

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(image: image, isPicked: false),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initPermissions();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!_hasPermissions || !_cameraController.value.isInitialized) return;

    if (state == AppLifecycleState.inactive) {
      _cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initCamera();
    }
  }

  Future<void> _onPickImagePressed() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null || !mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(image: image, isPicked: true),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: !_hasPermissions || !_cameraController.value.isInitialized
            ? SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Requesting permissions...",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Sizes.size20,
                      ),
                    ),
                    Gaps.v20,
                    CircularProgressIndicator(color: Colors.white),
                  ],
                ),
              )
            : Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: CameraPreview(_cameraController),
                  ),
                  Positioned(
                    top: Sizes.size20,
                    right: Sizes.size20,
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: _onPickImagePressed,
                          icon: FaIcon(FontAwesomeIcons.image),
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: Sizes.size40,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Expanded(
                          child: IconButton(
                            color: _flashMode == FlashMode.off
                                ? Colors.white
                                : Colors.amber.shade200,
                            onPressed: _toggleFlashMode,
                            icon: Icon(
                              _flashMode == FlashMode.off
                                  ? Icons.flash_off_rounded
                                  : _flashMode == FlashMode.auto
                                  ? Icons.flash_auto_rounded
                                  : Icons.flashlight_on_rounded,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _takePhoto(),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: 94,
                                height: 94,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: Sizes.size4,
                                  value: 1.0,
                                ),
                              ),
                              Container(
                                width: Sizes.size80,
                                height: Sizes.size80,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: IconButton(
                            onPressed: _toggleSefieMode,
                            icon: Icon(Icons.cameraswitch, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
