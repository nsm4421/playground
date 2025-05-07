part of 'custom_size.dart';

abstract class CustomWidth {
  static SizedBox get tiny => SizedBox(width: CustomSpacing.tiny);
  static SizedBox get sm => SizedBox(width: CustomSpacing.sm);
  static SizedBox get md => SizedBox(width: CustomSpacing.md);
  static SizedBox get lg => SizedBox(width: CustomSpacing.lg);
  static SizedBox get xl => SizedBox(width: CustomSpacing.xl);
  static SizedBox get xxl => SizedBox(width: CustomSpacing.xxl);
  static SizedBox get xxxl => SizedBox(width: CustomSpacing.xxxl);
}

abstract class CustomHeight {
  static SizedBox get tiny => SizedBox(height: CustomSpacing.tiny);
  static SizedBox get sm => SizedBox(height: CustomSpacing.sm);
  static SizedBox get md => SizedBox(height: CustomSpacing.md);
  static SizedBox get lg => SizedBox(height: CustomSpacing.lg);
  static SizedBox get xl => SizedBox(height: CustomSpacing.xl);
  static SizedBox get xxl => SizedBox(height: CustomSpacing.xxl);
  static SizedBox get xxxl => SizedBox(height: CustomSpacing.xxxl);
}
