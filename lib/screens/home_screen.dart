import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tflite/tflite.dart';
import 'package:image/image.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
import '../main.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:learning_selfie_segmentation/learning_selfie_segmentation.dart';


class HomeScreen extends StatefulWidget {
  static const String id = 'Home_screen';
  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomeScreen> {
  CameraController? cameraController;
  CameraImage? cameraImage;
  List? recognitionsList;



  initCamera() {
    cameraController = CameraController(cameras![0], ResolutionPreset.medium);
    cameraController!.initialize().then((value) {
      setState(() {


        cameraController!.startImageStream((image) => {
        cameraImage = image,
      // pre processing of img
        // convert img from yuv to rgb
         const shift = (0xFF << 24);
            Future<Image> convertYUV420toImageColor(CameraImage image)
        async {
          try {
            final int width = image.width;
            final int height = image.height;
            final int uvRowStride = image.planes[1].bytesPerRow;
            final int? uvPixelStride = image.planes[1].bytesPerPixel;

            print("uvRowStride: " + uvRowStride.toString());
            print("uvPixelStride: " + uvPixelStride.toString());

            // imgLib -> Image package from https://pub.dartlang.org/packages/image
            var img = imglib.Image(width, height); // Create Image buffer

            // Fill image buffer with plane[0] from YUV420_888
            for (int x = 0; x < width; x++) {
              for (int y = 0; y < height; y++) {
                final int uvIndex = uvPixelStride! * (x / 2).floor() +
                    uvRowStride * (y / 2).floor();
                final int index = y * width + x;

                final yp = image.planes[0].bytes[index];
                final up = image.planes[1].bytes[uvIndex];
                final vp = image.planes[2].bytes[uvIndex];
                // Calculate pixel color
                int r = (yp + vp * 1436 / 1024 - 179).round().clamp(0, 255);
                int g = (yp - up * 46549 / 131072 + 44 - vp * 93604 / 131072 +
                    91).round().clamp(0, 255);
                int b = (yp + up * 1814 / 1024 - 227).round().clamp(0, 255);
                // color: 0x FF  FF  FF  FF
                //           A   B   G   R
                img.data[index] = shift | (b << 16) | (g << 8) | r;
              }
            }

            imglib.PngEncoder pngEncoder = new imglib.PngEncoder(
                level: 0, filter: 0);
            List<int> png = pngEncoder.encodeImage(img);
            var muteYUVProcessing = false;
            return Image.memory(png);
          } catch (e) {
            print(">>>>>>>>>>>> ERROR:" + e.toString());
          }
          return null;
        }
        // convert from rgb to gray
        getGrayscale(String src) async {
          ByteData imageData = await rootBundle.load(src);

          imgLib.Image image = imgLib.grayscale(
              imgLib.decodePng(Uint8List.view(imageData.buffer)));

          return imgLib.encodePng(image);
        }

        // re size the model
        ImageProcessor imageProcessor = ImageProcessorBuilder()
            .add(ResizeOp(224, 224, ResizeMethod.NEAREST_NEIGHBOUR))
            .build();

// Create a TensorImage object from a File
        TensorImage tensorImage = TensorImage.fromFile(imageFile);

// Preprocess the image.
// The image for imageFile will be resized to (224, 224)
        tensorImage = imageProcessor.process(tensorImage);
// pre process the image  normalization
        Image normalize(
            Image src,
            int minValue,
            int maxValue
        )
        Image normalize(Image src, int minValue, int maxValue) {
          final A = minValue < maxValue ? minValue : maxValue;
          final B = minValue < maxValue ? maxValue : minValue;

          final mM = minMax(src);
          final m = mM[0];
          final M = mM[1];

          final fm = m.toDouble();
          final fM = M.toDouble();

          if (m == M) {
            return fill(src, minValue);
          }

          if (m != A || M != B) {
            final p = src.getBytes();
            for (var i = 0, len = p.length; i < len; i += 4) {
              p[i] = ((p[i] - fm) / (fM - fm) * (B - A) + A).toInt();
              p[i + 1] = ((p[i + 1] - fm) / (fM - fm) * (B - A) + A).toInt();
              p[i + 2] = ((p[i + 2] - fm) / (fM - fm) * (B - A) + A).toInt();
              p[i + 3] = ((p[i + 3] - fm) / (fM - fm) * (B - A) + A).toInt();
            }
          }

          return src;

        }
        // segmentation to extract object from back ground


        runModel(),

      });

      });
    });
  }

  runModel() async {
    recognitionsList = await Tflite.detectObjectOnFrame(
      bytesList: cameraImage!.planes.map((plane) {
        return plane.bytes;
      }).toList(),
      imageHeight: cameraImage!.height,
      imageWidth: cameraImage!.width,
      imageMean: 127.5,
      imageStd: 127.5,
      numResultsPerClass: 1,
      threshold: 0.4,
    ) as List<dynamic>;

    setState(() {
      cameraImage;
    });
  }

  Future loadModel() async {
    Tflite.close();
    await Tflite.loadModel(model: "assets/english.tflite", labels: " assets/ENG MODEL.txt");
  }

  @override
  void dispose() {
    super.dispose();

    cameraController!.stopImageStream();
    Tflite.close();
  }

  @override
  void initState() {
    super.initState();

    loadModel();
    initCamera();
  }

  List<Widget> displayBoxesAroundRecognizedObjects(Size screen) {
    if (recognitionsList == null) return [];

    double factorX = screen.width;
    double factorY = screen.height;

    Color colorPick = Colors.teal as Color;

    return recognitionsList!.map((result) {
      return Positioned(
        left: result["rect"]["x"] * factorX,
        top: result["rect"]["y"] * factorY,
        width: result["rect"]["w"] * factorX,
        height: result["rect"]["h"] * factorY,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(color: Colors.teal, width: 2.0),
          ),
          child: Text(
            "${result['detectedClass']} ${(result['confidenceInClass'] * 100).toStringAsFixed(0)}%",
            style: const TextStyle(
               backgroundColor: Colors.teal,
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Widget> list = [];

    list.add(
      Positioned(
        top: 0.0,
        left: 0.0,
        width: size.width,
        height: size.height - 100,
        child: SizedBox(
          height: size.height - 100,
          child: (!cameraController!.value.isInitialized)
              ? Container()
              : AspectRatio(
                  aspectRatio: cameraController!.value.aspectRatio,
                  child: CameraPreview(cameraController!),
                ),
        ),
      ),
    );

    if (cameraImage != null) {
      list.addAll(displayBoxesAroundRecognizedObjects(size));
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          margin: const EdgeInsets.only(top: 50),
          color: Colors.black,
          child: Stack(
            children: list,
          ),
        ),
      ),
    );
  }
}
