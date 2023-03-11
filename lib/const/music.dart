import 'package:just_audio/just_audio.dart';

class Music {
  static final Music _music = Music._internal();

  factory Music() => _music;

  Music._internal();

  bool isPlayMusic = true;

  String urlMusic = "audio/music/music.mp3";
  AudioPlayer player = AudioPlayer();
  void backgroundMusic() {
    isPlayMusic ? playMusic() : stopMusic();
  }

  void playMusic() async {
    await player.setAsset(urlMusic);
    await player.play();
    await player.setLoopMode(LoopMode.one);
  }

  void stopMusic() async {
    await player.stop();
  }
}

final music = Music();
