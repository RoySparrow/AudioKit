// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/
// This file was auto-autogenerated by scripts and templates at http://github.com/AudioKit/AudioKitDevTools/

import AVFoundation
import CAudioKit

/// Dynamic range compressor from Faust
public class DynamicRangeCompressor: Node, AudioUnitContainer, Toggleable {

    public static let ComponentDescription = AudioComponentDescription(effect: "cpsr")

    public typealias AudioUnitType = InternalAU

    public private(set) var internalAU: AudioUnitType?

    // MARK: - Parameters

    public static let ratioDef = NodeParameterDef(
        identifier: "ratio",
        name: "Ratio to compress with, a value > 1 will compress",
        address: akGetParameterAddress("DynamicRangeCompressorParameterRatio"),
        range: 0.01 ... 100.0,
        unit: .hertz,
        flags: .default)

    /// Ratio to compress with, a value > 1 will compress
    @Parameter public var ratio: AUValue

    public static let thresholdDef = NodeParameterDef(
        identifier: "threshold",
        name: "Threshold (in dB) 0 = max",
        address: akGetParameterAddress("DynamicRangeCompressorParameterThreshold"),
        range: -100.0 ... 0.0,
        unit: .generic,
        flags: .default)

    /// Threshold (in dB) 0 = max
    @Parameter public var threshold: AUValue

    public static let attackDurationDef = NodeParameterDef(
        identifier: "attackDuration",
        name: "Attack duration",
        address: akGetParameterAddress("DynamicRangeCompressorParameterAttackDuration"),
        range: 0.0 ... 1.0,
        unit: .seconds,
        flags: .default)

    /// Attack duration
    @Parameter public var attackDuration: AUValue

    public static let releaseDurationDef = NodeParameterDef(
        identifier: "releaseDuration",
        name: "Release duration",
        address: akGetParameterAddress("DynamicRangeCompressorParameterReleaseDuration"),
        range: 0.0 ... 1.0,
        unit: .seconds,
        flags: .default)

    /// Release Duration
    @Parameter public var releaseDuration: AUValue

    // MARK: - Audio Unit

    public class InternalAU: AudioUnitBase {

        public override func getParameterDefs() -> [NodeParameterDef] {
            [DynamicRangeCompressor.ratioDef,
             DynamicRangeCompressor.thresholdDef,
             DynamicRangeCompressor.attackDurationDef,
             DynamicRangeCompressor.releaseDurationDef]
        }

        public override func createDSP() -> DSPRef {
            akCreateDSP("DynamicRangeCompressorDSP")
        }
    }

    // MARK: - Initialization

    /// Initialize this compressor node
    ///
    /// - Parameters:
    ///   - input: Input node to process
    ///   - ratio: Ratio to compress with, a value > 1 will compress
    ///   - threshold: Threshold (in dB) 0 = max
    ///   - attackDuration: Attack duration
    ///   - releaseDuration: Release Duration
    ///
    public init(
        _ input: Node,
        ratio: AUValue = 1,
        threshold: AUValue = 0.0,
        attackDuration: AUValue = 0.1,
        releaseDuration: AUValue = 0.1
        ) {
        super.init(avAudioNode: AVAudioNode())

        instantiateAudioUnit { avAudioUnit in
            self.avAudioUnit = avAudioUnit
            self.avAudioNode = avAudioUnit

            guard let audioUnit = avAudioUnit.auAudioUnit as? AudioUnitType else {
                fatalError("Couldn't create audio unit")
            }
            self.internalAU = audioUnit

            self.ratio = ratio
            self.threshold = threshold
            self.attackDuration = attackDuration
            self.releaseDuration = releaseDuration
        }
        connections.append(input)
    }
}