part of responsive_text;

class FlutterResponsiveText extends StatefulWidget {
  final Key? textKey;
  final TextType? typeMultiplier;
  final String? data;
  final TextSpan? textSpan;
  final TextStyle? style;
  static const double _defaultFontSize = 14;
  final StrutStyle? strutStyle;
  final double minFontSize;
  final double maxFontSize;
  final List<double>? presetFontSizes;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final int? maxLines;

  const FlutterResponsiveText(
    String this.data, {
    Key? key,
    this.textKey,
    this.style,
    this.strutStyle,
    this.minFontSize = 10,
    this.maxFontSize = 40,
    this.presetFontSizes,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.typeMultiplier,
  })  : textSpan = null,
        super(key: key);

  const FlutterResponsiveText.rich(
    TextSpan this.textSpan, {
    Key? key,
    this.textKey,
    this.style,
    this.strutStyle,
    this.minFontSize = 10,
    this.maxFontSize = 40,
    this.presetFontSizes,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.typeMultiplier,
  })  : data = null,
        super(key: key);

  @override
  _AutoSizeTextState createState() => _AutoSizeTextState();
}

class _AutoSizeTextState extends State<FlutterResponsiveText> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      final defaultTextStyle = DefaultTextStyle.of(context);

      var style = widget.style;
      if (widget.style == null || widget.style!.inherit) {
        style = defaultTextStyle.style.merge(widget.style);
      }
      if (style!.fontSize == null) {
        style = style.copyWith(fontSize: FlutterResponsiveText._defaultFontSize);
      }

      final maxLines = widget.maxLines ?? defaultTextStyle.maxLines;

      _validateProperties(style, maxLines);

      final result = _calculateFontSize(size, style, maxLines);

      final TextStyle styleUpdated = _updateMyStyle(style);

      return _buildText(result, styleUpdated, maxLines);
    });
  }

  void _validateProperties(TextStyle style, int? maxLines) {
    assert(maxLines == null || maxLines > 0,
        'MaxLines must be greater than or equal to 1.');
    assert(widget.key == null || widget.key != widget.textKey,
        'Key and textKey must not be equal.');
    if (widget.presetFontSizes == null) {
      assert(widget.minFontSize >= 0,
          'MinFontSize must be greater than or equal to 0.');
      assert(widget.maxFontSize > 0, 'MaxFontSize has to be greater than 0.');
      assert(widget.minFontSize <= widget.maxFontSize,
          'MinFontSize must be smaller or equal than maxFontSize.');
    } else {
      assert(widget.presetFontSizes!.isNotEmpty,
          'PresetFontSizes must not be empty.');
      assert(
          widget.typeMultiplier == null, 'typeMultiplier must not be empty.');
    }
  }

  double _calculateFontSize(
      BoxConstraints size, TextStyle? style, int? maxLines) {
    late double typeMultiplierSize = 0;

    typeMultiplierSize = _calculateTypeMultiplierSize(size);

    late double screenWidth = 0;
    late double screenHeight = 0;
    late double _blockWidth = 0;
    late double _blockHeight = 0;

    screenWidth = size.maxWidth;
    screenHeight = size.maxHeight;

    _blockWidth = screenWidth / 100;
    _blockHeight = screenHeight / 100;

    return _blockWidth + _blockHeight * typeMultiplierSize;
  }

  double _calculateTypeMultiplierSize(BoxConstraints size) {
    double heightBlock = size.maxHeight / 100;
    double widthBlock = size.maxWidth / 100;
    switch (widget.typeMultiplier) {
      case TextType.headline1:
        return heightBlock * widthBlock * 4.0;
      case TextType.headline2:
        return heightBlock * widthBlock * 3.6;
      case TextType.headline3:
        return heightBlock * widthBlock * 3.2;
      case TextType.headline4:
        return heightBlock * widthBlock * 2.8;
      case TextType.headline5:
        return heightBlock * widthBlock * 2.8;
      case TextType.headline6:
        return heightBlock * widthBlock * 2.8;
      case TextType.bodyText1:
        return heightBlock * widthBlock * 2.9;
      case TextType.bodyText2:
        return heightBlock * widthBlock * 2.7;
      case TextType.bodyText3:
        return heightBlock * widthBlock * 2.5;
      case TextType.bodyText4:
        return heightBlock * widthBlock * 2.3;
      case TextType.bodyText5:
        return heightBlock * widthBlock * 2.1;
      case TextType.bodyText6:
        return heightBlock * widthBlock * 1.9;
      case TextType.subtitle1:
        return heightBlock * widthBlock * 1.8;
      case TextType.subtitle2:
        return heightBlock * widthBlock * 1.7;
      case TextType.subtitle3:
        return heightBlock * widthBlock * 1.6;
      case TextType.subtitle4:
        return heightBlock * widthBlock * 1.5;
      case TextType.subtitle5:
        return heightBlock * widthBlock * 1.4;
      case TextType.subtitle6:
        return heightBlock * widthBlock * 1.3;
      case TextType.caption:
        return heightBlock * widthBlock * 1.0;
      case TextType.error:
        return heightBlock * widthBlock * 2.1;
      default:
        return heightBlock * widthBlock * 2.1;
    }
  }

  TextStyle _updateMyStyle(TextStyle style) {
    switch (widget.typeMultiplier) {
      case TextType.headline1:
        return style.copyWith(fontWeight: FontWeight.w900);
      case TextType.headline2:
        return style.copyWith(fontWeight: FontWeight.w800);
      case TextType.headline3:
        return style.copyWith(fontWeight: FontWeight.w700);
      case TextType.headline4:
        return style.copyWith(fontWeight: FontWeight.w700);
      case TextType.headline5:
        return style.copyWith(fontWeight: FontWeight.w600);
      case TextType.headline6:
        return style.copyWith(fontWeight: FontWeight.w600);
      case TextType.bodyText1:
        return style.copyWith(fontWeight: FontWeight.w700);
      case TextType.bodyText2:
        return style.copyWith(fontWeight: FontWeight.w600);
      case TextType.bodyText3:
        return style.copyWith(fontWeight: FontWeight.w500);
      case TextType.bodyText4:
        return style.copyWith(fontWeight: FontWeight.w500);
      case TextType.bodyText5:
        return style.copyWith(fontWeight: FontWeight.w400);
      case TextType.bodyText6:
        return style.copyWith(fontWeight: FontWeight.w400);
      case TextType.subtitle1:
        return style.copyWith(fontWeight: FontWeight.w500);
      case TextType.subtitle2:
        return style.copyWith(fontWeight: FontWeight.w500);
      case TextType.subtitle3:
        return style.copyWith(fontWeight: FontWeight.w400);
      case TextType.subtitle4:
        return style.copyWith(fontWeight: FontWeight.w300);
      case TextType.subtitle5:
        return style.copyWith(fontWeight: FontWeight.w300);
      case TextType.subtitle6:
        return style.copyWith(fontWeight: FontWeight.w200);
      case TextType.caption:
        return style.copyWith(fontWeight: FontWeight.w100);
      case TextType.error:
        return style.copyWith(fontWeight: FontWeight.w400);
      default:
        return style.copyWith(fontWeight: FontWeight.w500);
    }
  }

  Widget _buildText(double fontSize, TextStyle style, int? maxLines) {
    if (widget.data != null) {
      return Text(
        widget.data!,
        key: widget.textKey,
        style: style.copyWith(fontSize: fontSize),
        strutStyle: widget.strutStyle,
        textAlign: widget.textAlign,
        textDirection: widget.textDirection,
        locale: widget.locale,
        softWrap: widget.softWrap,
        overflow: widget.overflow,
        textScaleFactor: 1,
        maxLines: maxLines,
      );
    } else {
      return Text.rich(
        widget.textSpan!,
        key: widget.textKey,
        style: style,
        strutStyle: widget.strutStyle,
        textAlign: widget.textAlign,
        textDirection: widget.textDirection,
        locale: widget.locale,
        softWrap: widget.softWrap,
        overflow: widget.overflow,
        textScaleFactor: fontSize / style.fontSize!,
        maxLines: maxLines,
      );
    }
  }
}
