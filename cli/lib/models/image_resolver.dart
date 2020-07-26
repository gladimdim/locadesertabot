import 'dart:math';

import 'package:gladstoriesengine/gladstoriesengine.dart';

class BackgroundImage {
  factory BackgroundImage() => _bgImage;
  static final BackgroundImage _bgImage = BackgroundImage._internal();

  BackgroundImage._internal();

  static Map<ImageType, RandomImage> _images = {
    ImageType.BOAT: RandomImage(ImageType.BOAT),
    ImageType.STEPPE: RandomImage(ImageType.RIVER), // shadowed
    ImageType.FOREST: RandomImage(ImageType.FOREST),
    ImageType.BULRUSH: RandomImage(ImageType.BULRUSH),
    ImageType.RIVER: RandomImage(ImageType.RIVER),
    ImageType.LANDING: RandomImage(ImageType.LANDING),
    ImageType.CAMP: RandomImage(ImageType.CAMP),
    ImageType.COSSACKS: RandomImage(ImageType.CAMP), // shadowed
  };

  static ImageType imageTypeFromCurrentTags(List<String> variables) {
    var images = variables.where((variable) {
      var tagName = variable.split(" ")[0];
      return tagName == 'image';
    }).toList();

    var random = Random();

    var tagToTake = images[random.nextInt(images.length)];

    return BackgroundImage.variableToImageType(tagToTake);
  }

  static ImageType variableToImageType(String variable) {
    var imageType = variable.split(" ")[1];
    return imageTypeFromString(imageType);
  }

  static void nextRandomForType(ImageType type) {
    return _images[type].nextRandom();
  }

  static void resetRandomForType(ImageType type) {
    return _images[type].resetUsedRandomNumbers();
  }

  static RandomImage getRandomImageForType(ImageType type) {
    return _images[type];
  }
}

class RandomImage implements HistoryImage {
  Random _random = Random();
  int _currentRandom;
  int _max;
  List<int> _usedRandomNumbers;
  final ImageType type;

  Map<ImageType, String> _imagePrefix = {
    ImageType.BULRUSH: "bulrush",
    ImageType.FOREST: "forest",
    ImageType.STEPPE: "steppe",
    ImageType.BOAT: "boat",
    ImageType.RIVER: "river",
    ImageType.LANDING: 'landing',
    ImageType.CAMP: "camp",
    ImageType.COSSACKS: "cossacks",
  };

  RandomImage(this.type) {
    switch (type) {
      case ImageType.BOAT:
        _max = 18;
        break;
      case ImageType.FOREST:
        _max = 10;
        break;
      case ImageType.BULRUSH:
        _max = 12;
        break;
      case ImageType.RIVER:
        _max = 21;
        break;
      case ImageType.LANDING:
        _max = 8;
        break;
      case ImageType.CAMP:
        _max = 15;
        break;
      default:
        throw "Not implemented";
        break;
    }

    _currentRandom = _random.nextInt(_max);
    _usedRandomNumbers = [_currentRandom];
  }

  List<String> getAllAvailableImages() {
    var counter = -1;
    List<String> list = [];
    while (++counter < _max) {
      list.add(
        "https://locadeserta.com/game/assets/images/background/${_imagePrefix[type]}/${counter.toString()}.jpg",
      );
      list.add(
        "https://locadeserta.com/game/assets/images/background/${_imagePrefix[type]}/c_${counter.toString()}.jpg",
      );
    }

    return list;
  }

  String getImagePath() {
    return "https://locadeserta.com/game/assets/images/background/${_imagePrefix[type]}/${_currentRandom.toString()}.jpg";
  }

  String getImagePathColored() {
    return "https://locadeserta.com/game/assets/images/background/${_imagePrefix[type]}/c_${_currentRandom.toString()}.jpg";
  }

  void nextRandom() {
    if (_usedRandomNumbers.length == _max) {
      _usedRandomNumbers = [];
    }
    var temp = _random.nextInt(_max);
    if (_usedRandomNumbers.indexOf(temp) >= 0) {
      nextRandom();
      return;
    } else {
      _currentRandom = temp;
    }
    _usedRandomNumbers.add(_currentRandom);
  }

  void resetUsedRandomNumbers() {
    _usedRandomNumbers = [];
  }
}

List<String> getImagesForType(String blackWhiteImagePath) {
  var split = blackWhiteImagePath.split("/");
  split.last = "c_${split.last}";
  return [
    blackWhiteImagePath,
    split.join("/"),
  ];
}
