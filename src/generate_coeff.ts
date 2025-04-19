const scaleCoefficients = (coeffs: number[], scaleBits: number = 11): number[] => {
    const scaleFactor = 1 << scaleBits; // 2^scaleBits
    return coeffs.map(c => Math.round(c * scaleFactor));
  };
  
  // Ejemplo de uso
  const originalCoeffs = [
    0.0000, 0.0002, 0.0005, 0.0011, 0.0020, 0.0031, 0.0046,
    0.0065, 0.0088, 0.0114, 0.0144, 0.0176, 0.0210, 0.0245,
    0.0279, 0.0312, 0.0341, 0.0366, 0.0386, 0.0400, 0.0407,
    0.0407, 0.0400, 0.0386, 0.0366, 0.0341, 0.0312, 0.0279,
    0.0245, 0.0210, 0.0176, 0.0144, 0.0114, 0.0088, 0.0065,
    0.0046, 0.0031, 0.0020, 0.0011, 0.0005, 0.0002, 0.0000
  ];
  
  const scaled = scaleCoefficients(originalCoeffs);
  
  console.log(scaled.join(', '));
  