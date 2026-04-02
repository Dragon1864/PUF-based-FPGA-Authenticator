#  FPGA-Based RO-PUF Authentication System

##  Overview

This project implements a **Ring Oscillator Physical Unclonable Function (RO-PUF)** on an FPGA to enable **hardware-based device authentication** and **secure firmware encryption**.

The system leverages inherent manufacturing variations to generate **unique, unclonable responses**, which are transformed into cryptographic keys.

---

##  Concept

A **PUF (Physical Unclonable Function)** produces a device-unique response for a given challenge due to microscopic variations in hardware.

These responses are:

* **Unique per device**
* **Unpredictable**
* **Hard to clone**

---

##  System Architecture

###  Manufacturer Side (Enrollment Phase)

```text
FPGA (RO-PUF)
     ↓
Collect CRPs → Store in CSV
     ↓
Apply Temporal Majority Voting
     ↓
Select Stable CRP(s)
     ↓
Response → BCH Encode → Generate Helper Data (ECC)
     ↓
Corrected Response → Hash (SHA-256)
     ↓
Generate Key
     ↓
Encrypt Firmware
     ↓
Store:
    - Selected Challenges
    - ECC (Helper Data)
    - Encrypted Firmware
```

---

###  Verifier Side (Authentication Phase)

```text
FPGA (RO-PUF)
     ↓
Apply SAME Challenges
     ↓
Apply SAME Majority Voting
     ↓
Generate Noisy Response
     ↓
Use BCH Decode + ECC → Recover Original Response
     ↓
Hash → Key
     ↓
Decrypt Firmware
     ↓
Verification:
     Match → AUTHENTIC DEVICE
     Mismatch → REJECTED
```

---

##  Project Structure

```text
├── manufacturer/
│   ├── generate_crp_csv.py [This is to generate the csv file]
│   ├── manufacturer_side.py [this python script uses the csv file and generates the device_data.json, firmware_encrypted.bin]
│   ├── device_data.json [This file is generated after python code is executed]
│   └── firmware_encrypted.bin [This file is generated after python code is executed].
│
├── verifier/
│   └──  verifier.py [The verification python script is present here]
│
├── design_files/
│   ├── ROPUF/
│   ├── PUF_secured_LED_blinking.v     [Top module]
│   ├── blinking_led.v
│   ├── pulse_on_change.v
│   ├── RO_PUF_8_8.v
│   ├── ro_puf_8_8_top.v
│   └── RO_PUF_DRIVER_own.v
│
├── data/
│   └── crp_list_global_voting.csv
│
└── README.md
```

---

##  Key Features

*  Hardware-rooted security using RO-PUF
*  Temporal Majority Voting for stabilization
*  CRP selection for entropy optimization
*  BCH Error Correction (Fuzzy Extractor concept)
*  SHA-256 based key derivation
*  Firmware encryption & secure verification
*  Implemented on PYNQ-Z2 FPGA

---

## Methodology

### 1. CRP Collection

* Multiple PUF responses are collected
* Stored in CSV format

### 2. Temporal Majority Voting

* Each bit is stabilized using repeated measurements
* Improves reliability (~89%)

### 3. CRP Selection

* Balanced responses preferred
* Improves entropy

### 4. Error Correction (BCH)

* BCH encoding generates helper data (ECC)
* BCH decoding corrects noisy runtime responses
* Ensures stable key reconstruction

### 5. Key Generation

```python
key = SHA256(response)
```

### 6. Encryption

* Firmware encrypted using XOR with derived key

### 7. Verification

* Same process repeated
* Decrypted firmware compared with original

---

##  Getting Started

### Prerequisites

* PYNQ-Z2 FPGA
* Python 3

Install dependencies:

```bash
pip install numpy pandas bchlib pynq
```

---

###  Manufacturer (Enrollment)

```bash
python manufacturer_enroll.py
```

Outputs:

* device_data.json
* firmware_encrypted.bin

---

###  Verifier (Authentication)

```bash
python verifier.py
```

---

##  Important Notes

*  Enrollment and verification must use:

  * Same challenges
  * Same voting method
  * Same timing

*  PUF responses are noisy:

  * Majority voting required
  * BCH required for correction

*  Changes in environment (voltage/temp) may affect results

---

##  Limitations

* Limited entropy (8-bit base PUF)
* Environmental sensitivity
* Requires tuning of sampling

---

##  Future Improvements

* 32-bit / 64-bit PUF expansion
* Optimized BCH parameters
* AES encryption
* Multi-challenge authentication

---

##  Conclusion

```text
Hardware Uniqueness → Error Correction → Key → Secure Authentication
```

This project demonstrates a **complete PUF-based hardware security pipeline** using FPGA.
