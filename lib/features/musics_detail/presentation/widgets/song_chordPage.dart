import 'package:flutter/material.dart';
import 'package:flutter_chord/flutter_chord.dart';

class SongChordPage extends StatefulWidget {
  const SongChordPage({super.key});

  @override
  State<SongChordPage> createState() => _SongChordPageState();
}

class _SongChordPageState extends State<SongChordPage> {
  int transpose = 0;

  final String lyrics = '''
[C]Give me Freedom, [F]Give me fire
[Am]Give me reason, [G]Take me higher

[C]See the world in [F]different colors
[Am]Feel the rhythm [G]of our hearts

[F]We can fly [G]together
[Am]Forever and [C]ever
''';

  @override
  Widget build(BuildContext context) {
    const background = Color(0xFF101114);
    const cardColor = Color(0xFF1C1E23);
    const primary = Color(0xFF37D99A);

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Now Playing',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Song information
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Container(
                    width: 75,
                    height: 75,
                    decoration: BoxDecoration(
                      color: primary.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.music_note,
                      color: primary,
                      size: 38,
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Give Me Freedom',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'My Favorite Artist',
                          style: TextStyle(color: Colors.white54),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Original Key: C',
                          style: TextStyle(
                            color: primary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.favorite,
                    color: primary,
                  ),
                ],
              ),
            ),

            // Transpose controls
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Text(
                    'CHORDS',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      setState(() => transpose--);
                    },
                    icon: const Icon(
                      Icons.remove_circle_outline,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Transpose: $transpose',
                      style: const TextStyle(color: primary),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() => transpose++);
                    },
                    icon: const Icon(
                      Icons.add_circle_outline,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Lyrics and chords
            Expanded(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SingleChildScrollView(
                  child: LyricsRenderer(
                    lyrics: lyrics,
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      height: 2,
                    ),
                    chordStyle: const TextStyle(
                      color: primary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    widgetPadding: 20,
                    transposeIncrement: transpose,
                    scrollSpeed: 0,
                    onTapChord: (chord) {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: cardColor,
                        builder: (context) => SizedBox(
                          height: 200,
                          child: Center(
                            child: Text(
                              'Selected chord: $chord',
                              style: const TextStyle(
                                color: primary,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Bottom controls
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.skip_previous,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  Container(
                    width: 58,
                    height: 58,
                    decoration: const BoxDecoration(
                      color: primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.play_arrow,
                      color: Colors.black,
                      size: 35,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.skip_next,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
