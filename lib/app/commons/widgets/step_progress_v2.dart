import 'package:flutter/material.dart';
import 'package:melo_ui/melo_ui.dart';
import 'package:timelines/timelines.dart';

class StepProgressv2 extends StatelessWidget {
  const StepProgressv2(
      {super.key,
      required this.currentStep,
      required this.steps,
      this.width = double.infinity,
      this.height = 48});

  final double width;
  final double height;
  final List<StepTagv2> steps;
  final int currentStep;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: width,
            height: height / 2,
            child: Timeline.tileBuilder(
                scrollDirection: Axis.horizontal,
                builder: TimelineTileBuilder.connected(
                  itemCount: steps.length,
                  indicatorBuilder: (context, index) {},
                  contentsBuilder: (context, index) {
                    return Card(
                      shape: const CircleBorder(),
                      color: steps[index].variant == StepVariantV2.current
                          ? Theme.of(context).colorScheme.primary
                          : steps[index].variant == StepVariantV2.complete
                              ? Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.6)
                              : Colors.grey,
                      child: const SizedBox(
                        height: 15,
                        width: 15,
                      ),
                    );
                  },
                )),
          ),
          // Row(children: steps),
          SizedBox(
            height: height / 7,
          ),
        ],
      ),
    );
  }
}

class StepTagv2 extends StatelessWidget {
  const StepTagv2({super.key, required this.variant});

  final StepVariantV2 variant;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 4,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
          color: variant == StepVariantV2.current
              ? Theme.of(context).colorScheme.primary
              : variant == StepVariantV2.complete
                  ? Theme.of(context).colorScheme.primary.withOpacity(0.6)
                  : Colors.grey,
          borderRadius: BorderRadius.circular(16)),
    );
  }
}

enum StepVariantV2 {
  disabled,
  complete,
  current,
}
