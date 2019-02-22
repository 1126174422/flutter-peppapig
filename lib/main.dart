import 'dart:ui';
import 'dart:ui' as ui show TextStyle;

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Peppapig',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Peppapig'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var width = 50.0;
  var height;
  var lastScale = 1.0;
  @override
  void initState() {
    super.initState();
    width = 50.0;
    height = getHeight(width);
  }

  double getHeight(double width) {
    return 558.0 * width / 360;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: GestureDetector(
          onDoubleTap: () {
            setState(() {
              width = 1.2 * width;
              height = getHeight(width);
            });
          },
          onScaleStart: (s) {
            lastScale = 1.0;
          },
          onScaleUpdate: (scale) {
            setState(() {
              //print(scale.scale);
              width = (scale.scale / lastScale) * width;
              height = getHeight(width);
              lastScale = scale.scale;
            });
          },
          child: CustomPaint(
            size: Size(width, height),
            painter: PeppaPaint(width),
          ),
        ),
      ),
    );
  }
}

class PeppaPaint extends CustomPainter {
  double width;

  PeppaPaint(double width) {
    this.width = width;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var width = size.width;
    var height = size.height;
    var k = width / 360; //对应标准尺寸下的比例尺
    var paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill //填充
      ..color = Color(0x77cdb175); //背景为纸黄色
    canvas.drawRect(Offset.zero & size, paint);
    paint
      ..style = PaintingStyle.stroke //线
      ..color = Colors.pink[200]
      ..strokeWidth = 3.0 * k;
    canvas.rotate(-0.25);
    //画鼻子
    canvas.drawOval(
        Rect.fromLTRB(width * 0.7, height * 0.2, width * 0.8, height * 0.30),
        paint);
    paint.style = PaintingStyle.fill; //填充
    canvas.drawCircle(Offset(width * 0.725, height * 0.25), 5 * k, paint);
    canvas.drawCircle(Offset(width * 0.775, height * 0.25), 5 * k, paint);
    //画脸部轮廓
    var path = new Path();
    paint.style = PaintingStyle.stroke; //
    path.moveTo(width * 0.75, height * 0.2);
    path.cubicTo(-width * 0.2, height * 0.05, width * 0.25, height * 0.63,
        width * 0.6, height * 0.35);
    canvas.drawPath(path, paint);
    path = new Path();
    path.moveTo(width * 0.6, height * 0.35);
    path.conicTo(width * 0.7, height * 0.33, width * 0.75, height * 0.3, 1);
    canvas.drawPath(path, paint);
    canvas.rotate(0.25);

    //画耳朵
    path = new Path();
    path.moveTo(width * 0.5, height * 0.1);
    path.cubicTo(width * 0.42, height * 0.01, width * 0.58, height * 0.01,
        width * 0.55, height * 0.09);
    canvas.drawPath(path, paint);
    path = new Path();
    path.moveTo(width * 0.41, height * 0.12);
    path.cubicTo(width * 0.31, height * 0.035, width * 0.46, height * 0.035,
        width * 0.46, height * 0.105);
    canvas.drawPath(path, paint);
    //画小酒窝
    paint.style = PaintingStyle.fill; //填充
    canvas.drawCircle(Offset(width * 0.40, height * 0.23), 18 * k, paint);
    //画眼睛
    paint.style = PaintingStyle.stroke; //线
    canvas.drawCircle(Offset(width * 0.60, height * 0.13), 9 * k, paint);
    canvas.drawCircle(Offset(width * 0.50, height * 0.15), 9 * k, paint);
    //眼珠
    paint.style = PaintingStyle.fill; //线
    paint.color = Colors.black;
    canvas.drawCircle(Offset(width * 0.59, height * 0.133), 4 * k, paint);
    canvas.drawCircle(Offset(width * 0.49, height * 0.153), 4 * k, paint);
    //画嘴
    path = new Path();
    paint.style = PaintingStyle.stroke; //线
    paint.color = Colors.pink;
    path.moveTo(width * 0.45, height * 0.28);
    path.conicTo(width * 0.55, height * 0.33, width * 0.62, height * 0.25, 1);
    canvas.drawPath(path, paint);
    //画身体
    path = new Path();
    paint.color = Colors.pink[200];
    path.moveTo(width * 0.37, height * 0.327);
    path.conicTo(width * 0.25, height * 0.42, width * 0.25, height * 0.6, 1);
    canvas.drawPath(path, paint);
    path = new Path();
    paint.color = Colors.pink[200];
    path.moveTo(width * 0.62, height * 0.325);
    path.conicTo(width * 0.72, height * 0.42, width * 0.75, height * 0.6, 1);
    canvas.drawPath(path, paint);
    canvas.drawArc(
        Rect.fromCircle(
            center: Offset(width * 0.284, height * 0.6), radius: 12 * k),
        1.57,
        1.58,
        false,
        paint);

    canvas.drawArc(
        Rect.fromCircle(
            center: Offset(width * 0.7165, height * 0.6), radius: 12 * k),
        0,
        1.58,
        false,
        paint);
    canvas.drawLine(Offset(width * 0.284, height * 0.6 + (12 * k)),
        Offset(width * 0.7165, height * 0.6 + (12 * k)), paint);
    //画右手
    path = new Path();
    path.moveTo(width * 0.68, height * 0.4);
    path.conicTo(width * 0.75, height * 0.44, width * 0.80, height * 0.48, 1);
    canvas.drawPath(path, paint);
    path = new Path();
    path.moveTo(width * 0.78, height * 0.466);
    path.conicTo(width * 0.80, height * 0.463, width * 0.81, height * 0.46, 1);
    canvas.drawPath(path, paint);
    path = new Path();
    path.moveTo(width * 0.78, height * 0.466);
    path.conicTo(width * 0.78, height * 0.47, width * 0.769, height * 0.486, 1);
    canvas.drawPath(path, paint);
    paint.style = PaintingStyle.fill;
    canvas.drawCircle(Offset(width * 0.80, height * 0.48), 1.5 * k, paint);
    canvas.drawCircle(Offset(width * 0.81, height * 0.46), 1.5 * k, paint);
    canvas.drawCircle(Offset(width * 0.769, height * 0.486), 1.5 * k, paint);

    //画左手
    paint.style = PaintingStyle.stroke;
    path = new Path();
    path.moveTo(width * 0.303, height * 0.4);
    path.conicTo(width * 0.23, height * 0.44, width * 0.18, height * 0.48, 1);
    canvas.drawPath(path, paint);
    path = new Path();
    path.moveTo(width * 0.203, height * 0.466);
    path.conicTo(width * 0.18, height * 0.463, width * 0.17, height * 0.46, 1);
    canvas.drawPath(path, paint);
    path = new Path();
    path.moveTo(width * 0.20, height * 0.466);
    path.conicTo(width * 0.203, height * 0.47, width * 0.21, height * 0.486, 1);
    canvas.drawPath(path, paint);
    paint.style = PaintingStyle.fill;
    canvas.drawCircle(Offset(width * 0.18, height * 0.48), 1.5 * k, paint);
    canvas.drawCircle(Offset(width * 0.17, height * 0.46), 1.5 * k, paint);
    canvas.drawCircle(Offset(width * 0.21, height * 0.486), 1.5 * k, paint);
    //画尾巴
    paint.style = PaintingStyle.stroke;
    path = new Path();
    path.moveTo(width * 0.225, height * 0.568);
    path.cubicTo(width * 0.18, height * 0.56, width * 0.21, height * 0.60,
        width * 0.25, height * 0.585);
    canvas.drawPath(path, paint);
    path = new Path();
    path.moveTo(width * 0.225, height * 0.568);
    path.cubicTo(width * 0.24, height * 0.57, width * 0.21, height * 0.60,
        width * 0.18, height * 0.585);
    canvas.drawPath(path, paint);
    //画脚
    path = new Path();
    path.moveTo(width * 0.42, height * 0.6 + (12 * k));
    path.conicTo(width * 0.41, height * 0.65, width * 0.42, height * 0.69, 1);
    canvas.drawPath(path, paint);
    path = new Path();
    path.moveTo(width * 0.58, height * 0.6 + (12 * k));
    path.conicTo(width * 0.57, height * 0.65, width * 0.58, height * 0.69, 1);
    canvas.drawPath(path, paint);
    paint.color = Colors.teal[800];
    paint.style = PaintingStyle.fill;
    canvas.drawOval(
        Rect.fromLTRB(
            width * 0.41, height * 0.685, width * 0.45, height * 0.70),
        paint);
    canvas.drawOval(
        Rect.fromLTRB(
            width * 0.57, height * 0.685, width * 0.61, height * 0.70),
        paint);
    //画文字
    ParagraphBuilder pb = ParagraphBuilder(ParagraphStyle(
      textAlign: TextAlign.center,
      fontWeight: FontWeight.w800,
      fontStyle: FontStyle.italic,
      fontSize: 35.0 * k,
    ));
    pb.pushStyle(ui.TextStyle(color: Colors.green));
    pb.addText('peppapig');

    ParagraphConstraints pc = ParagraphConstraints(width: width);
//这里需要先layout, 后面才能获取到文字高度
    Paragraph paragraph = pb.build()..layout(pc);
//文字居中显示
    Offset offset = Offset(
        width / 2 - paragraph.width / 2, height * 0.71 + paragraph.height / 2);
    canvas.drawParagraph(paragraph, offset); /**/
  }

  //正确利用此回调可以避免重绘开销
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    //控件尺寸变化时重绘
    return true;
  }
}
