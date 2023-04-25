
import 'package:flutter/material.dart';

import '../../../constants/constant.dart';

class PForm extends StatefulWidget {
  final List<Widget> pages;
  final List<PTitle> title;
  PFormController? controller;
  double? height;
  Color? activeColor, disableColor;

  PForm(
      {Key? key,
      required this.pages,
      required this.title,
      this.controller,
      this.activeColor = goldColor,
      this.disableColor = Colors.grey,this.height=380})
      : super(key: key);

  @override
  State<PForm> createState() => _PFormState();
}

class _PFormState extends State<PForm> with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;
  late List<Animation<double>> _animationsOpavity;
  late List<bool> activeColor;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      widget.pages.length,
      (index) => AnimationController(
          vsync: this, duration: Duration(milliseconds: 200), lowerBound: 0),
    );
    _animations = _controllers
        .map((_controller) =>
            Tween<double>(begin: .05, end: 1).animate(_controller))
        .toList();

    _animationsOpavity = _controllers
        .map((_controller) =>
            Tween<double>(begin: 0, end: 1).animate(_controller))
        .toList();

    activeColor = List.generate(widget.pages.length, (index) => false);

    if (widget.controller != null) {
      widget.controller?.addListener(() {
        controllerColor(widget.controller?.currentPage);
      });
    }
  }

  controllerColor(int index) {
    for (var i = 0; i < activeColor.length; i++) {
      if (index == i) {
        if (!_controllers[i].isCompleted) _controllers[index].animateTo(1);
      } else {
        if (_controllers[i].isCompleted) _controllers[i].reverse();
      }
    }
    for (var i = 0; i <= index; i++) {
      activeColor[i] = true;
    }
    for (var i = index + 1; i < activeColor.length; i++) {
      activeColor[i] = false;
    }
    setState(() {});
  }

  void dispose() {
    super.dispose();
    _controllers.forEach(
      (c) {
        c.dispose();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widget.pages.map((e) {
          int index = widget.pages.indexOf(e);
          return Stack(
            children: [
              if (index != widget.pages.length - 1)
                Container(
                  margin: EdgeInsets.only(left: 2, top: 37),
                  child: SizeTransition(
                    sizeFactor: _animations[index],
                    child: Container(
                      margin: EdgeInsets.only(left: 15, right: 20),
                      width: 3,
                      height: widget.height,
                      color: activeColor[index + 1]
                          ? widget.activeColor?.withOpacity(.8)
                          : widget.disableColor,
                    ),
                  ),
                ),
              Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          controllerColor(index);
                        },
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: activeColor[index]
                                ? widget.activeColor?.withOpacity(0.8)
                                : widget.disableColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      widget.title[index].copyWith(
                        activeColor: activeColor[index]
                            ? widget.activeColor
                            : Colors.black,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: 50),
                      Expanded(
                        child: FadeTransition(
                            opacity: _animationsOpavity[index],
                            child: SizeTransition(
                              sizeFactor: _animations[index],
                              child: e,
                            )),
                      ),
                    ],
                  )
                ],
              )
            ],
          );
        }).toList(),
      ),
    );
  }
}

class PTitle extends StatelessWidget {
  String? title, subTitle;
  Color? activeColor;

  PTitle({Key? key, this.activeColor, @required this.title, this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (activeColor == null) activeColor = Colors.black;
    return Column(
      children: [
        Text(
          title!,
          style: TextStyle(
              fontSize: 15, color: activeColor, fontFamily: 'headLine'),
        ),
        if (subTitle != null) Text(subTitle!),
      ],
    );
  }

  copyWith({String? title, subTitle, Color? activeColor}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? this.title!,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: activeColor ?? this.activeColor,
          ),
        ),
        Text(subTitle ?? this.subTitle ?? '',
            style: TextStyle(color: Colors.black54)),
      ],
    );
  }
}

class PFormController extends ChangeNotifier {
  PFormController(this.length);

  int _page = -1;
  final int? length;

  nextPage() {
    if (_page < length! - 1) _page++;
    notifyListeners();
  }

  get currentPage => _page;

  set jumpToPage(int p) {
    _page = p;
    notifyListeners();
  }

  prevPage() {
    if (_page > 0) _page--;
    notifyListeners();
  }
}
