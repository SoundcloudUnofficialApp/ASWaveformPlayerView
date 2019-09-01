# ASWaveformPlayerView

[![Swift5 compatible][Swift5Badge]][Swift5Link]
[![SPM compatible][SPMBadge]][SPMLink]

[Swift5Badge]: https://img.shields.io/badge/swift-5-orange.svg?style=flat
[Swift5Link]: https://developer.apple.com/swift/

[SPMBadge]: https://img.shields.io/badge/SPM-compatible-brightgreen.svg
[SPMLink]: https://github.com/apple/swift-package-manager

## Example

Check example project inside

## Requirements
Swift 5

## Description

<p align="center">
<img src="https://i.imgur.com/f4mPtwJ.png" alt="ASWaveformPlayerView"/>
</p>

A UIView subclass that displays waveform of a provided local audio file.

This view has 2 gesture recognizers attached:
1) `UITapGestureRecognizer` - Play - Pause associated with a view audio file.
2) `UIPanGestureRecognizer` - Seek audio file to specified position.

There are 3 public properties:

* `normalColor` - default color of waveform, fills section of waveform that is yet to be played.
* `progressColor` - already played section of waveform has this color.
* `allowSpacing` - inserts a little spacing between bars in waveform.

## Usage

Example:

```swift
      let waveform = try ASWaveformPlayerView(audioURL: audioURL, // URL to local a audio file
                                              sampleCount: 1024, // higher numbers makes waveform more detailed
                                              amplificationFactor: 500) // constant that affects height of each 'bar' in waveform

      waveform.normalColor = .lightGray
      waveform.progressColor = .orange
      //with high sampleCount passed to init method to avoid artifacts set this to false
      waveform.allowSpacing = false
```

## Author

Alexey Savchenko, alexey.savchenko.home@gmail.com

## License

ASWaveformPlayerView is available under the MIT license. See the LICENSE file for more info.

