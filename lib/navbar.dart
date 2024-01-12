import 'package:flutter/material.dart';
import 'package:schluckspecht_app/Contact.dart';
import 'package:schluckspecht_app/Feed.dart';
import 'package:schluckspecht_app/History.dart';
import 'package:schluckspecht_app/themes.dart';

int globalpageindex =0;

const icononeunselected = Icon(Icons.contact_page_outlined);
const icononeselected = Icon(Icons.contact_page_rounded);
const icononelabel = 'Contact';

const icontwounselected = Icon(Icons.home_outlined);
const icontwoselected = Icon(Icons.home);
const icontwolabel = 'Home';

const iconthreeunselected = Icon(Icons.work_history_outlined);
const iconthreeselected = Icon(Icons.work_history);
const iconthreelabel = 'History';


class MobileNavbar extends StatefulWidget {
  const MobileNavbar({super.key});

  @override
  State<MobileNavbar> createState() => _MobileNavbarState();
}


class _MobileNavbarState extends State<MobileNavbar> {

  var currentpageindex = globalpageindex;

  @override
  Widget build(BuildContext context) {

    Widget page;
    switch (currentpageindex) {
      case 0:
        page = Feedpage();
        break;
      case 1:
        page = Contactpage();
        break;
      case 2:
        page = Historypage();
        break;
      default:
        throw UnimplementedError('no widget selected');
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text('Schluckspecht'),
      ),
      body: Center(
        child: page,
      ),
      bottomNavigationBar: NavigationBarTheme(
      data: NavigationBarThemeData(
        indicatorColor: accentColor.withOpacity(0.6),
      ),
      child: NavigationBar(
        backgroundColor: Colors.grey[100],
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        height: 70,
        selectedIndex: currentpageindex,

        onDestinationSelected: (int index) {
          setState(() {
            currentpageindex = index;
          });
        },
        destinations: const <NavigationDestination>[
          NavigationDestination(
            selectedIcon: icononeselected,
            icon: icononeunselected,
            label: icononelabel,
          ),
          NavigationDestination(
            selectedIcon: icontwoselected,
            icon: icontwounselected,
            label: icontwolabel,
          ),
          NavigationDestination(
            selectedIcon: iconthreeselected,
            icon: iconthreeunselected,
            label: iconthreelabel,
          ),
        ],
      ),
      ),
    );
  }
}


class TabletNavbar extends StatefulWidget {
  const TabletNavbar({super.key});

  @override
  State<TabletNavbar> createState() => _TabletNavbarState();
}


class _TabletNavbarState extends State<TabletNavbar> {

  var currentpageindex = globalpageindex;

  @override
  Widget build(BuildContext context) {

    Widget page;
    switch (currentpageindex) {
      case 0:
        page = Feedpage();
        break;
      case 1:
        page = Contactpage();
        break;
      case 2:
        page = Historypage();
        break;
      default:
        throw UnimplementedError('no widget selected');
    }

    return LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.background,
              title: const Text('Schluckspecht'),
            ),
            body: Row(
              children: [
                SafeArea(
                  child: NavigationRail(
                    backgroundColor: Colors.grey[100],
                    extended: constraints.maxWidth >= 750,
                    indicatorColor: accentColor.withOpacity(0.6),
                    selectedIndex: currentpageindex,
                    labelType: NavigationRailLabelType.selected,
                    onDestinationSelected: (int index) {
                      setState(() {
                        currentpageindex = index;
                      });
                    },
                    destinations: const [
                      NavigationRailDestination(
                        selectedIcon: icononeselected,
                        icon: icononeunselected,
                        label: Text(icononelabel),
                      ),
                      NavigationRailDestination(
                        selectedIcon: icontwoselected,
                        icon: icontwounselected,
                        label: Text(icontwolabel),
                      ),
                      NavigationRailDestination(
                        selectedIcon: iconthreeselected,
                        icon: iconthreeunselected,
                        label: Text(iconthreelabel),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Theme.of(context).colorScheme.background,
                    child: page,
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class DesktopNavbar extends StatefulWidget {
  const DesktopNavbar({super.key});

  @override
  State<DesktopNavbar> createState() => _DesktopNavbarState();
}


class _DesktopNavbarState extends State<DesktopNavbar> {

  var currentpageindex = globalpageindex;

  @override
  Widget build(BuildContext context) {

    Widget page;
    switch (currentpageindex) {
      case 0:
        page = Feedpage();
        break;
      case 1:
        page = Contactpage();
        break;
      case 2:
        page = Historypage();
        break;
      default:
        throw UnimplementedError('no widget selected');
    }

    return LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.background,
              title: const Text('Schluckspecht'),
            ),
            body: Row(
              children: [
                SafeArea(
                  child: NavigationRail(
                    backgroundColor: Colors.grey[100],
                    indicatorColor: accentColor.withOpacity(0.6),
                    selectedIndex: currentpageindex,
                    extended: constraints.maxWidth >= 750,
                    onDestinationSelected: (int index) {
                      setState(() {
                        currentpageindex = index;
                      });
                    },
                    destinations: const [
                      NavigationRailDestination(
                        selectedIcon: icononeselected,
                        icon: icononeunselected,
                        label: Text(icononelabel),
                      ),
                      NavigationRailDestination(
                        selectedIcon: icontwoselected,
                        icon: icontwounselected,
                        label: Text(icontwolabel),
                      ),
                      NavigationRailDestination(
                        selectedIcon: iconthreeselected,
                        icon: iconthreeunselected,
                        label: Text(iconthreelabel),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Theme.of(context).colorScheme.background,
                    child: page,
                  ),
                ),
              ],
            ),
          );
        });
  }
}
