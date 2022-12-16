import 'package:just_audio/just_audio.dart';

class Music {
  static final Music _music = Music._internal();

  factory Music() => _music;

  Music._internal();

  AudioPlayer? player;
  bool isPlay = true;
  String url = "audio/soundd.mp3";

  void musicOnOff() {
    isPlay ? playMusic() : stopMusic();
  }

  void playMusic() {
    player = AudioPlayer();
    player?.setAsset(url);
    if (!music.player!.playing) {
      player?.play();
      player?.setLoopMode(LoopMode.one);
    }
  }

  void stopMusic() async {
    player?.setAsset(url);
    player?.stop();
  }
}

final music = Music();
