part of 'index.page.dart';

class OutlineHighlight extends CustomPainter {
  final bool isSelected;

  OutlineHighlight({required this.isSelected});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isSelected ? Colors.red : Colors.blue // 색깔
      ..strokeWidth = isSelected ? 4 : 2 // 굵기
      ..style = PaintingStyle.stroke; // 바깥 라인만 그리기

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
