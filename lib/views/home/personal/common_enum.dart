enum MoodTag {
  // Positive Moods
  happy(1),
  motivated(2),
  relaxed(3),

  // Neutral Moods
  thoughtful(4),
  curious(5),

  // Negative Moods
  sad(6),
  anxious(7),
  angry(8),
  lonely(9),

  content(10),

  unspecified(99);

  final int value;
  const MoodTag(this.value);
}

enum MoodState {
  happy(0),
  sad(1),
  neutral(2),
  anxious(3),
  angry(4),
  excited(5);

  final int value;
  const MoodState(this.value);
}

enum Weather {
  sunny(0),
  rainy(1),
  cloudy(2),
  snowy(3),
  windy(4);

  final int value;
  const Weather(this.value);
}
//  const enum MoodTag
// {
//     // Positive Moods
//     Happy = 1,       // Feeling cheerful or joyful
//     Motivated = 2,   // Feeling determined and driven
//     Relaxed = 3,     // Feeling calm and at ease

//     // Neutral Moods
//     Thoughtful = 4,  // Reflective or deep in thought
//     Curious = 5,     // Eager to learn or explore

//     // Negative Moods
//     Sad = 6,         // Feeling down or unhappy
//     Anxious = 7,     // Feeling worried or nervous
//     Angry = 8,       // Feeling annoyed or frustrated
//     Lonely = 9,      // Feeling isolated or alone

//     Content = 10,    // information

//     // Miscellaneous
//     Unspecified = 99 // When the mood is not explicitly set
// }
