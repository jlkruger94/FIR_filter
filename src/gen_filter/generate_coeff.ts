/**
 *   FIR Filter - Filtro Rechaza Banda
 *   =================================
 *
 *   Este módulo VHDL implementa un filtro FIR rechaza banda (`notch`)
 *
 *
 *   Parámetros del filtro
 *   ---------------------
 *   - Tipo             : FIR Rechaza Banda (Notch)
 *   - Orden            : 64 (65 coeficientes)
 *   - Fs (reloj)       : 12.5 MHz
 *   - Banda de rechazo : 500 kHz a 700 kHz
 *   - Formato coef.    : Q1.11 (escalado ×2048)
 *   - Ancho datos      : 12 bits
 *
 *
 *   Cómo regenerar el filtro con otros parámetros
 *   ---------------------------------------------
 *   1. Instalar dependencias:
 *   npm install -g ts-node typescript
 *
 *   2. Editar los parámetros en `generate_coeff.ts`:
 *   - Frecuencia de muestreo (fsample)
 *   - Banda de rechazo (fstop1, fstop2)
 *   - Orden (numTaps)
 *
 *   3. Ejecutar:
 *   ts-node generate_coeff.ts
 * 
 * 
 * 
 * 
 * 
 */


import {writeFileSync}  from "fs";

// generate_notch.ts
const fs = 2_000_000; // Frecuencia de muestreo
const fc1 = 1_000;   // Límite inferior de la banda de rechazo
const fc2 = 2_000_000;   // Límite superior de la banda de rechazo
const N = 32;          // Orden del filtro (N+1 taps)
const SCALE = 2048;    // Escalado para Q1.11

function sinc(x: number): number {
  return x === 0 ? 1 : Math.sin(Math.PI * x) / (Math.PI * x);
}

function hamming(n: number, N: number): number {
  return 0.54 - 0.46 * Math.cos((2 * Math.PI * n) / (N - 1));
}

// Filtro pasa bajas con fc2 (más alta)
function lowpass(fc: number, N: number): number[] {
  const fc_norm = fc / fs;
  const mid = N / 2;
  return Array.from({ length: N + 1 }, (_, n) =>
    2 * fc_norm * sinc(2 * fc_norm * (n - mid)) * hamming(n, N)
  );
}

// Filtro pasa altas con fc1 (más baja) → complemento de pasa bajas
function highpass(fc: number, N: number): number[] {
  const lp = lowpass(fc, N);
  return lp.map((v, i) => (i === N / 2 ? 1 - v : -v));
}

// Filtro notch = highpass(fc1) + lowpass(fc2)
function bandstop(fc1: number, fc2: number, N: number): number[] {
  const hp = highpass(fc1, N);
  const lp = lowpass(fc2, N);
  return hp.map((v, i) => v + lp[i]);
}

const coeffs = bandstop(fc1, fc2, N).map(c =>
  Math.round(c * SCALE)
);

// 🖨️ Imprimir para VHDL
let buffer : string = 'constant rom : integer_array := (';
console.log("const h : coef_array_t := (");
coeffs.forEach((v, i) => {
  const comma = i < coeffs.length - 1 ? ',' : '';
  //console.log(`    to_signed(${v}, DATA_W)${comma}`);
  console.log(`    ${v}${comma}`);
  //buffer += `to_signed(${v}, DATA_W)${comma}\n`;
  buffer += `${v}${comma}\n`;
});
console.log(");");
console.log('Tamaño del array: '+coeffs.length);

buffer+= ');';
writeFileSync('./coef.vhd',buffer);
