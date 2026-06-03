import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saki_app/features/calendar/presentation/screens/calendar_screen.dart';
import 'package:saki_app/features/calendar/presentation/widgets/scrapbook_calendar_widget.dart';
import 'package:saki_app/features/calendar/presentation/widgets/scrapbook_widgets.dart';

void main() {
  // Disable Google Fonts HTTP fetching in tests to avoid network errors
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  testWidgets('CalendarScreen loads, showing calendar grid and scrapbook cards', (WidgetTester tester) async {
    // Build CalendarScreen inside a MaterialApp and ProviderScope
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: CalendarScreen(),
        ),
      ),
    );
    // Wait for the async future provider to complete loading the mock events
    await tester.pumpAndSettle();

    // Verify that the screen elements render correctly
    expect(find.byType(CalendarScreen), findsOneWidget);
    expect(find.byType(ScrapbookCalendarWidget), findsOneWidget);

    // Check that we can find the core scrapbook sections
    expect(find.widgetWithText(ScrapbookCard, 'Plans'), findsOneWidget);
    expect(find.widgetWithText(ScrapbookCard, 'Analysis'), findsOneWidget);
    expect(find.widgetWithText(ScrapbookCard, 'Investment'), findsOneWidget);
    expect(find.widgetWithText(ScrapbookCard, 'Expenses'), findsOneWidget);

    // Check for the presence of the drawer open button (hamburger menu)
    expect(find.byIcon(Icons.menu), findsOneWidget);
  });
}
