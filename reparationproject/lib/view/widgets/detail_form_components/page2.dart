import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:animated_checkmark/animated_checkmark.dart';
import 'package:get/get.dart';
import '../../../constants/constant.dart';

class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  int? tag;

  List<String> options = [
    '1st category'.tr,
    '2nd category'.tr,
    '3rd category'.tr,
    '4th category'.tr,
    '5th category'.tr,
  ];
  final feesController = PageController(
    initialPage: 15,
  );
  final durationController = PageController(initialPage: 15);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: defaultPadding*2,
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'Consultation types:',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade800),
            ),
          ),
          SizedBox(
            width: 350,
            child: ChipsChoice<int>.single(
              crossAxisAlignment: CrossAxisAlignment.start,
              value: tag,
              onChanged: (val) => setState(
                () => tag = val,
              ),
              choiceItems: C2Choice.listFrom<int, String>(
                source: options,
                value: (i, v) => i,
                label: (i, v) => v,
              ),
              padding: const EdgeInsets.fromLTRB(0, 5, 10, 5),
              choiceBuilder: (item, i) {
                return CustomChip(
                  label: item.label,
                  width: 80,
                  height: 90,
                  color: goldColor,
                  margin: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                  selected: item.selected,
                  onSelect: item.select!,
                );
              },
            ),
          ),
          SizedBox(
            height: defaultPadding * 2,
          ),
          Row(
            children: [
              Text(
                'appointment fees'.tr,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade800),
              ),
              SizedBox(
                width: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Container(
                  height: 45,
                  width: 80,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.3),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey.shade600)),
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height:30,
                        width:43,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white,),

                        child: PageView.builder(
                            controller: feesController,
                            scrollDirection: Axis.vertical,
                            itemCount: 41,
                            itemBuilder: (context, feesValue) {
                              return Center(
                                child: Text(
                                  '${feesValue * 50}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                              );
                            }),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        '\$',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
                ),
              ),
            ],
          ),
          SizedBox(
            height: defaultPadding * 2,
          ),
          Row(
            children: [
              Text(
                'appointment period'.tr,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade800),
              ),
              SizedBox(
                width: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Container(
                  height: 45,
                  width: 80,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.3),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey.shade600)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height:30,
                        width:35,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white,),

                        child: PageView.builder(
                          controller: durationController,
                          scrollDirection: Axis.vertical,
                          itemCount: 61,
                          itemBuilder: (context, durationValue) {
                            return Center(
                              child: Text(
                                '${durationValue}',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w400),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(width:4),
                      Text(
                        'Min',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomChip extends StatelessWidget {
  final String label;
  final Color? color;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final bool selected;
  final Function(bool selected) onSelect;

  const CustomChip({
    Key? key,
    required this.label,
    this.color,
    this.width,
    this.height,
    this.margin,
    this.selected = false,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedContainer(
      width: width,
      height: 65,
      margin: margin ?? const EdgeInsets.symmetric(vertical: 15, horizontal: 1),
      duration: const Duration(milliseconds: 300),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: selected
            ? (color ?? Colors.green)
            : theme.unselectedWidgetColor.withOpacity(.12),
        borderRadius: BorderRadius.all(Radius.circular(selected ? 20 : 10)),
        border: Border.all(
          color: selected
              ? (color ?? Colors.green)
              : theme.colorScheme.onSurface.withOpacity(.38),
          width: 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(selected ? 20 : 10)),
        onTap: () => onSelect(!selected),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            AnimatedCheckmark(
              active: selected,
              color: Colors.white,
              size: const Size.square(32),
              weight: 5,
              duration: const Duration(milliseconds: 400),
            ),
            Positioned(
              left: 9,
              right: 9,
              bottom: 7,
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: selected ? Colors.white : theme.colorScheme.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
