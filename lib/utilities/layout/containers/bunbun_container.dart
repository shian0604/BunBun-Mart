import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/models/size_configs.dart';
import 'package:flutter/material.dart';

class BunBunContainer extends StatelessWidget {
  final Widget? child;
  const BunBunContainer({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    BunSizeConfig.init(context);

    return Container(
      width: BunSizeConfig.screenWidth,
      height: 70.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        gradient: LinearGradient(
          colors: [BunColors.navy, BunColors.gray, BunColors.beige],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),

        image: DecorationImage(
          image: AssetImage('assets/screentone/tone.jpg'),
          fit: BoxFit.cover,
          alignment: Alignment.bottomCenter,
          repeat: ImageRepeat.noRepeat,
          opacity: 0.03,
        ),
      ),

      child: child,
    );
  }
}

class BunCustomHeader extends StatelessWidget {
  final Widget? child;
  final double height;
  const BunCustomHeader({super.key, this.child, required this.height});

  @override
  Widget build(BuildContext context) {
    BunSizeConfig.init(context);

    return Container(
      width: BunSizeConfig.screenWidth,
      height: height,
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        gradient: LinearGradient(
          colors: [BunColors.navy, BunColors.gray, BunColors.beige],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),

        image: DecorationImage(
          image: AssetImage('assets/screentone/tone.jpg'),
          fit: BoxFit.cover,
          alignment: Alignment.bottomCenter,
          repeat: ImageRepeat.noRepeat,
          opacity: 0.03,
        ),
      ),

      child: child,
    );
  }
}

class BunSmallContainer extends StatelessWidget {
  final Widget? child;
  final double height;
  final double? width;
  final Color color;
  const BunSmallContainer({
    super.key,
    this.child,
    required this.height,
    this.width,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    BunSizeConfig.init(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: color,
      ),

      child: child,
    );
  }
}

class BunPageContainer extends StatelessWidget {
  final Widget? child;
  final Color color;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? radius;
  const BunPageContainer({
    super.key,
    this.child,
    required this.color,
    this.padding,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    BunSizeConfig.init(context);

    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: BunSizeConfig.screenHeight,
      ),
      child: Container(
        width: BunSizeConfig.screenWidth,
        padding: padding,
        decoration: BoxDecoration(
          color: color,
          borderRadius: radius ?? BorderRadius.circular(20.0),
        ),
      
        child: child,
      ),
    );
  }
}

class BunColorContainer extends StatefulWidget {
  final Widget? child;
  final double height;
  final double width;
  final Color color;
  const BunColorContainer({
    super.key,
    this.child,
    required this.color,
    required this.height,
    required this.width,
  });

  @override
  State<BunColorContainer> createState() => _BunColorContainerState();
}

class _BunColorContainerState extends State<BunColorContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: widget.color,
      ),

      child: widget.child,
    );
  }
}

class BunSizeContainer extends StatefulWidget {
  final Widget? child;
  final double height;
  final double width;
  final Color color;
  const BunSizeContainer({
    super.key,
    this.child,
    required this.color,
    required this.height,
    required this.width,
  });

  @override
  State<BunSizeContainer> createState() => _BunSizeContainerState();
}

class _BunSizeContainerState extends State<BunSizeContainer> {
  @override
  Widget build(BuildContext context) {
    BunSizeConfig.init(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: widget.color,
      ),

      child: widget.child,
    );
  }
}

class ButtonContainer extends StatefulWidget {
  final Widget? child;
  final double height;
  final double width;
  final Color color;
  final VoidCallback? onTap;
  const ButtonContainer({
    super.key,
    this.child,
    required this.color,
    required this.height,
    required this.width,
    this.onTap,
  });

  @override
  State<ButtonContainer> createState() => _ButtonContainerState();
}

class _ButtonContainerState extends State<ButtonContainer> {
  @override
  Widget build(BuildContext context) {
    BunSizeConfig.init(context);

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: widget.color,
        ),
      
        child: widget.child,
      ),
    );
  }
}
