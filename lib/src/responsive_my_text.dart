part of responsive_text;

class ResponsiveMyText extends StatefulWidget {
  final Key? textKey;
  final TypeMultiplier? typeMultiplier;
  final String? data;
  final TextSpan? textSpan;
  final TextStyle? style;
  static const double _defaultFontSize = 14;
  final StrutStyle? strutStyle;
  final double minFontSize;
  final double maxFontSize;
  final double stepGranularity;
  final List<double>? presetFontSizes;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final bool wrapWords;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final int? maxLines;

  const ResponsiveMyText(
    String this.data, {
    Key? key,
    this.textKey,
    this.style,
    this.strutStyle,
    this.minFontSize = 10,
    this.maxFontSize = double.infinity,
    this.stepGranularity = 1,
    this.presetFontSizes,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.wrapWords = true,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.typeMultiplier,
  })  : textSpan = null,
        super(key: key);

  const ResponsiveMyText.rich(
    TextSpan this.textSpan, {
    Key? key,
    this.textKey,
    this.style,
    this.strutStyle,
    this.minFontSize = 12,
    this.maxFontSize = double.infinity,
    this.stepGranularity = 1,
    this.presetFontSizes,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.wrapWords = true,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.typeMultiplier,
  })  : data = null,
        super(key: key);

  @override
  _AutoSizeTextState createState() => _AutoSizeTextState();
}

class _AutoSizeTextState extends State<ResponsiveMyText> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      final defaultTextStyle = DefaultTextStyle.of(context);

      var style = widget.style;
      if (widget.style == null || widget.style!.inherit) {
        style = defaultTextStyle.style.merge(widget.style);
      }
      if (style!.fontSize == null) {
        style = style.copyWith(fontSize: ResponsiveMyText._defaultFontSize);
      }

      final maxLines = widget.maxLines ?? defaultTextStyle.maxLines;

      _validateProperties(style, maxLines);

      final result =
          _calculateFontSize(size, style, maxLines, widget.typeMultiplier);

      return _buildText(result, style, maxLines);
    });
  }

  void _validateProperties(TextStyle style, int? maxLines) {
    assert(maxLines == null || maxLines > 0,
        'MaxLines must be greater than or equal to 1.');
    assert(widget.key == null || widget.key != widget.textKey,
        'Key and textKey must not be equal.');
    if (widget.presetFontSizes == null) {
      assert(
          widget.stepGranularity >= 0.1,
          'StepGranularity must be greater than or equal to 0.1. It is not a '
          'good idea to resize the font with a higher accuracy.');
      assert(widget.minFontSize >= 0,
          'MinFontSize must be greater than or equal to 0.');
      assert(widget.maxFontSize > 0, 'MaxFontSize has to be greater than 0.');
      assert(widget.minFontSize <= widget.maxFontSize,
          'MinFontSize must be smaller or equal than maxFontSize.');
      assert(widget.minFontSize / widget.stepGranularity % 1 == 0,
          'MinFontSize must be a multiple of stepGranularity.');
      if (widget.maxFontSize != double.infinity) {
        assert(widget.maxFontSize / widget.stepGranularity % 1 == 0,
            'MaxFontSize must be a multiple of stepGranularity.');
      }
    } else {
      assert(widget.presetFontSizes!.isNotEmpty,
          'PresetFontSizes must not be empty.');
      assert(
          widget.typeMultiplier == null, 'typeMultiplier must not be empty.');
    }
  }

  double _calculateFontSize(BoxConstraints size, TextStyle? style,
      int? maxLines, TypeMultiplier? typeMultiplier) {
    late double typeMultiplierSize = 0;

    typeMultiplierSize = _calculateTypeMultiplierSize(size, typeMultiplier);

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

  double _calculateTypeMultiplierSize(
      BoxConstraints size, TypeMultiplier? typeMultiplier) {
    double heightBlock = size.maxHeight / 100;
    double widthBlock = size.maxWidth / 100;
    switch (typeMultiplier) {
      case TypeMultiplier.headline1:
        return heightBlock * widthBlock * 4.0;
      case TypeMultiplier.headline2:
        return heightBlock * widthBlock * 3.6;
      case TypeMultiplier.headline3:
        return heightBlock * widthBlock * 3.2;
      case TypeMultiplier.headline4:
        return heightBlock * widthBlock * 2.8;
      case TypeMultiplier.headline5:
        return heightBlock * widthBlock * 2.8;
      case TypeMultiplier.headline6:
        return heightBlock * widthBlock * 2.8;
      case TypeMultiplier.bodyText1:
        return heightBlock * widthBlock * 2.9;
      case TypeMultiplier.bodyText2:
        return heightBlock * widthBlock * 2.7;
      case TypeMultiplier.bodyText3:
        return heightBlock * widthBlock * 2.5;
      case TypeMultiplier.bodyText4:
        return heightBlock * widthBlock * 2.3;
      case TypeMultiplier.bodyText5:
        return heightBlock * widthBlock * 2.1;
      case TypeMultiplier.bodyText6:
        return heightBlock * widthBlock * 1.9;
      case TypeMultiplier.subtitle1:
        return heightBlock * widthBlock * 1.8;
      case TypeMultiplier.subtitle2:
        return heightBlock * widthBlock * 1.7;
      case TypeMultiplier.subtitle3:
        return heightBlock * widthBlock * 1.6;
      case TypeMultiplier.subtitle4:
        return heightBlock * widthBlock * 1.5;
      case TypeMultiplier.subtitle5:
        return heightBlock * widthBlock * 1.4;
      case TypeMultiplier.subtitle6:
        return heightBlock * widthBlock * 1.3;
      case TypeMultiplier.caption:
        return heightBlock * widthBlock * 1.0;
      case TypeMultiplier.error:
        return heightBlock * widthBlock * 2.1;
      default:
        return heightBlock * widthBlock * 2.1;
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
