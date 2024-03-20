import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CustomNavBar extends StatefulWidget {
  final int index;
  final Function(int) onItemSelected;
  const CustomNavBar(
      {super.key, required this.index, required this.onItemSelected});

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomNavBarItem(
              index: 0,
              onItemSelected: () {
                widget.onItemSelected(0);
              },
              currentIndex: widget.index,
              icon: Icons.home_outlined,
              label: "Home"),
          CustomNavBarItem(
              index: 1,
              onItemSelected: () {
                widget.onItemSelected(1);
              },
              currentIndex: widget.index,
              icon: Icons.search,
              label: "Search"),
          CustomNavBarItem(
              index: 2,
              onItemSelected: () {
                widget.onItemSelected(2);
              },
              currentIndex: widget.index,
              icon: Icons.bookmark_outline,
              label: "Bookmark"),
          CustomNavBarItem(
              index: 3,
              onItemSelected: () {
                widget.onItemSelected(3);
              },
              currentIndex: widget.index,
              icon: Icons.settings_outlined,
              label: "Settings")
        ],
      ),
    );
  }
}

class CustomNavBarItem extends StatelessWidget {
  final int index;
  final int currentIndex;
  final String label;
  final IconData icon;
  final Function() onItemSelected;
  const CustomNavBarItem(
      {super.key,
      required this.index,
      required this.onItemSelected,
      required this.currentIndex,
      required this.icon,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onItemSelected,
        child: Row(
          children: [
            Animate(
              effects: const [FadeEffect()],
              child: Icon(
                icon,
                size: index == currentIndex ? 36 : 28,
                color: index == currentIndex
                    ? Colors.black
                    : Colors.grey.withOpacity(0.7),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            if (index == currentIndex)
              Animate(
                effects: const [FadeEffect()],
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: index == currentIndex
                          ? Colors.black
                          : Colors.grey.withOpacity(0.7),
                      fontWeight: index == currentIndex
                          ? FontWeight.bold
                          : FontWeight.normal),
                ),
              ),
          ],
        ));
  }
}
