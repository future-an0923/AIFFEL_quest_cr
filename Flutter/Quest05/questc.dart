// 화면 구성
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String result = "";
  TextEditingController urlController =
      TextEditingController(); // URL을 입력 받는 컨트롤러

  Future<void> fetchData() async {
    try {
      final enteredUrl = urlController.text; // 입력된 URL 가져오기
      final response = await http.get(
        Uri.parse(enteredUrl + "sample"), // 입력된 URL 사용
        headers: {
          'Content-Type': 'application/json',
          'ngrok-skip-browser-warning': '69420',
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          result =
              "predicted_label: ${data['predicted_label']}\nprediction_score: ${data['prediction_score']}";
          print(result);
        });
      } else {
        setState(() {
          result = "Failed to fetch data. Status Code: ${response.statusCode}";
          print(result);
        });
      }
    } catch (e) {
      setState(() {
        result = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jellyfish Classfier"),
        centerTitle: true,
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.alarm)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: ResizeImage(
                AssetImage('images/jellyfish.png'),
                width: 300,
                height: 300,
              ),
            ),
            TextField(
              controller: urlController, // URL 입력을 위한 TextField
              decoration: InputDecoration(labelText: "URL 입력"), // 입력 필드의 라벨
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: fetchData, child: Text("예측 결과")),
                ElevatedButton(onPressed: fetchData, child: Text("예측 확률")),
              ],
            ),
            SizedBox(height: 20),
            Text(result, style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}

// vgg16_prediction_model.py

// import tensorflow as tf
// from tensorflow.keras.applications.vgg16 import preprocess_input
// from tensorflow.keras.preprocessing import image
// from tensorflow.keras.applications.imagenet_utils import decode_predictions
// from PIL import Image
// import numpy as np
// import os

// def load_model():
//     model_path = os.path.expanduser('./vgg16.h5')
//     if not os.path.exists(model_path):
//         raise FileNotFoundError(f"Model file not found: {model_path}")
//     model = tf.keras.models.load_model(model_path)
//     return model

// async def prediction_model(model):
//     img_path = os.path.expanduser('./jellyfish/jellyfish.jpg') // 이미지를 바꿔줌
//     if not os.path.exists(img_path):
//         raise FileNotFoundError(f"Image file not found: {img_path}")
    
//     img = Image.open(img_path)
//     target_size = 224
//     img = img.resize((target_size, target_size))

//     np_img = image.img_to_array(img)
//     img_batch = np.expand_dims(np_img, axis=0)
//     pre_processed = preprocess_input(img_batch)
    
//     y_preds = model.predict(pre_processed)
//     np.set_printoptions(suppress=True, precision=5)
//     result = decode_predictions(y_preds, top=1)
//     result = {"predicted_label": str(result[0][0][1]), "prediction_score": str(result[0][0][2])}
//     return result

// 회고:
// 변종현 : 의욕이 많은 분과 작업을 해서 많은 도움을 받았다.
// 안진용 : 여러 시도들을 했지만 따로 분리하지 못하고 종현님께서 앱을 맡아주셔서 수월했다.
