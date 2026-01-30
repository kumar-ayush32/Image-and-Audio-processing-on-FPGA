# Image-and-Audio-processing-on-FPGA
# Real-Time Audio Filter on FPGA (Basys 3 + Pmod I2S2)

A real-time audio-processing system implemented in Verilog on the Basys 3 FPGA.  
It captures live audio through the Pmod I2S2, applies FIR-based Low-Pass, High-Pass, and Band-Pass filtering, and outputs the processed audio with minimal latency.

---

## 🚀 Features
- Real-time audio input and output using the I2S protocol  
- Fully synthesizable Verilog RTL design  
- FIR filters for LPF / HPF / BPF  
- Filter selection via Basys 3 switches  
- Clean, modular architecture  
- Low-latency audio pipeline

---

## 🛠 Hardware Used
- Basys 3 FPGA (Artix-7)  
- Pmod I2S2 audio module  
- Audio input (phone / laptop)  
- Headphones or speaker  

---

## 📐 System Architecture

Audio In → I2S Receiver → FIR Filter → I2S Transmitter → Audio Out

---

## 🔧 How It Works

### 1️⃣ I2S Interface  
The Pmod I2S2 provides BCLK, LRCLK, and serial audio data.  
Custom Verilog modules handle:  
- Serial-to-parallel conversion  
- Parallel-to-serial transmission  
- Stereo sample alignment  

### 2️⃣ FIR Filter  
- Implemented as a MAC-based pipeline  
- Coefficients loaded from .mem files  
- Supports LPF, HPF, and BPF  

### 3️⃣ Filter Selection  
- SW0 → Low-Pass  
- SW1 → High-Pass  
- SW2 → Band-Pass  

---

## ▶️ Running on Basys 3

1. Open Vivado and create a new RTL project.  
2. Add files from `/src`.  
3. Add the `basys3.xdc` constraint file.  
4. Connect Pmod I2S2 to JA.  
5. Synthesize → Implement → Generate Bitstream.  
6. Program the board.  
7. Connect audio input/output and toggle switches to change filters.

---

## 📊 FIR Filter Details
- Coefficients generated using MATLAB/Python  
- Higher-order filters can be added easily  
- Real-time processing with minimal delay  


---

## 📄 License
This project is released under the MIT License.

---

## ⭐ Acknowledgements
- Digilent documentation  
- DSP and FPGA learning resources  
- Open-source FPGA/Verilog communities
