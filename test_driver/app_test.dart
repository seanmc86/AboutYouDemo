import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Main App', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.
    final drawerOpenFinder = find.byValueKey('opendrawer');
    final priceHighestFinder = find.byValueKey('priceup');
    final submitFilterFinder = find.byValueKey('submitfilters');
    final gridFinder = find.byValueKey('gridbuilder');

    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('submitting filters closes drawer', () async {
      await driver.tap(drawerOpenFinder);
      await driver.tap(priceHighestFinder);
      await driver.tap(submitFilterFinder);
      await driver.scroll(gridFinder, 0, 200, Duration(milliseconds: 500));
    });
  });
}