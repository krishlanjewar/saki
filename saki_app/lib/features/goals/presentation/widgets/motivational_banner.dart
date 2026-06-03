import 'package:flutter/material.dart';

/// A banner that shows a motivational quote that changes each day.
class MotivationalBanner extends StatelessWidget {
  const MotivationalBanner({super.key});

  static const _quotes = [
    ('Small steps every day lead to big results.', 'Anonymous'),
    ('Discipline is the bridge between goals and accomplishment.', 'Jim Rohn'),
    ('The secret of getting ahead is getting started.', 'Mark Twain'),
    ('You don\'t have to be great to start, but you have to start to be great.', 'Zig Ziglar'),
    ('It always seems impossible until it\'s done.', 'Nelson Mandela'),
    ('Push yourself, because no one else is going to do it for you.', 'Unknown'),
    ('Great things never come from comfort zones.', 'Unknown'),
    ('Dream it. Wish it. Do it.', 'Unknown'),
    ('Success doesn\'t just find you. You have to go out and get it.', 'Unknown'),
    ('The harder you work for something, the greater you\'ll feel when you achieve it.', 'Unknown'),
    ('Don\'t stop when you\'re tired. Stop when you\'re done.', 'Unknown'),
    ('Wake up with determination. Go to bed with satisfaction.', 'Unknown'),
    ('Do something today that your future self will thank you for.', 'Sean Patrick Flanery'),
    ('Little things make big days.', 'Unknown'),
    ('It\'s going to be hard, but hard is not impossible.', 'Unknown'),
    ('Don\'t wait for opportunity. Create it.', 'Unknown'),
    ('Sometimes we\'re tested not to show our weaknesses, but our strengths.', 'Unknown'),
    ('The key to success is to focus on goals, not obstacles.', 'Unknown'),
    ('Dream bigger. Do bigger.', 'Unknown'),
    ('Don\'t be afraid to give up the good to go for the great.', 'John D. Rockefeller'),
    ('No pain, no gain. Shut up and train.', 'Unknown'),
    ('Your limitation—it\'s only your imagination.', 'Unknown'),
    ('Sometimes later becomes never. Do it now.', 'Unknown'),
    ('Great things take time. Trust the process.', 'Unknown'),
    ('You are capable of amazing things.', 'Unknown'),
    ('Be stronger than your excuses.', 'Unknown'),
    ('One day or day one. You decide.', 'Unknown'),
    ('Keep going. Everything you need will come to you at the perfect time.', 'Unknown'),
    ('You\'ve got what it takes, but it will take everything you\'ve got.', 'Unknown'),
    ('Be the person your dog thinks you are.', 'Unknown'),
  ];

  @override
  Widget build(BuildContext context) {
    final index = DateTime.now().day % _quotes.length;
    final (quote, author) = _quotes[index];

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6C63FF), Color(0xFF9C88FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6C63FF).withAlpha(60),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '✨ Daily Inspiration',
            style: TextStyle(
              fontSize: 11,
              color: Colors.white70,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '"$quote"',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w600,
              height: 1.5,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '— $author',
            style: const TextStyle(
              fontSize: 11,
              color: Colors.white60,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
