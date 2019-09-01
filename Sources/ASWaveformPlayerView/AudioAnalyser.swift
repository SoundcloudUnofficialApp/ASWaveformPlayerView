
import Foundation
import AVFoundation
import Accelerate

public class AudioAnalyzer {
    
    public func analyzeAudioFile(_ url: URL) throws -> [Float] {
        
        let file = try AVAudioFile(forReading: url)
        
        let format = AVAudioFormat(commonFormat: .pcmFormatFloat32,
                                   sampleRate: file.fileFormat.sampleRate,
                                   channels: file.fileFormat.channelCount,
                                   interleaved: false)
        
        let pcmBuffer = AVAudioPCMBuffer(pcmFormat: format!, frameCapacity: UInt32(file.length))
        
        try file.read(into: pcmBuffer!)
        
        let rawFloatData = Array(UnsafeBufferPointer(start: pcmBuffer?.floatChannelData?[0],
                                                     count: Int(pcmBuffer!.frameLength)))
        
        var resultVector = [Float](repeating: 0.0, count: rawFloatData.count)
        
        vDSP_vabs(rawFloatData,
                  1,
                  &resultVector,
                  1,
                  vDSP_Length(rawFloatData.count))
        
        return resultVector
        
    }
    
    public func amplify(_ inputArray: [Float],
                        by amplificationFactor: Float) -> [Float] {
        
        let amplificationVector = [Float](repeating: amplificationFactor, count: inputArray.count)
        
        var resultVector = [Float](repeating: 0.0, count: inputArray.count)
        
        vDSP_vmul(inputArray,
                  1,
                  amplificationVector,
                  1,
                  &resultVector,
                  1,
                  vDSP_Length(inputArray.count))
        
        return resultVector
        
    }
    
    public func resample(_ inputArray: [Float],
                         to targetSize: Int) -> [Float] {
        
        let stride = vDSP_Stride(inputArray.count / targetSize)
        
        let filterVector = [Float](repeating: 0.002, count: stride)
        
        var resultVector = [Float](repeating:0.0, count: targetSize)
        
        vDSP_desamp(inputArray,
                    stride,
                    filterVector,
                    &resultVector,
                    vDSP_Length(resultVector.count),
                    vDSP_Length(filterVector.count))
        
        return resultVector
    }
}
