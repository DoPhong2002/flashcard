import 'package:just_audio/just_audio.dart';

class Music {
  static final Music _music = Music._internal();

  factory Music() => _music;

  Music._internal();

  AudioPlayer? player;

  bool isPlayMusic = true;
  bool isPlaySound = true;

  String urlMusic = "audio/nhac.mp3";
  String urlSound = "audio/soundd.mp3";

  void backgroundMusic() {
    isPlayMusic ? playMusic() : stopMusic();
  }

  void btnSound() {
    isPlaySound ? playSound() : stopMusic();
  }

  void playMusic() {
    player = AudioPlayer();
    player?.setAsset(urlMusic);
    if (!music.player!.playing) {
      player?.play();
      player?.setLoopMode(LoopMode.one);
    }
  }

  void playSound() {
    player = AudioPlayer();
    player?.setAsset(urlSound);
    player?.play();
  }

  void stopMusic() async {
    // player?.setAsset(urlMusic);
    player?.stop();
  }
}

final music = Music();
