import bchlib
import hashlib
import pandas as pd
import json

# -------------------------------
# 1. Load CSV
# -------------------------------
df = pd.read_csv("add_your_csv.csv") # Use the CSV file you have generated.

# -------------------------------
# 2. Select TOP 4 CRPs (balanced)
# -------------------------------
scored = []

for idx, row in df.iterrows():
    response_bin = str(row["response"]).strip().zfill(8)
    ones = response_bin.count('1')
    score = 8 - abs(ones - 4)   # balanced bits

    scored.append((score, idx))

scored.sort(reverse=True)

selected_indices = [idx for (_, idx) in scored[:4]]

selected_crps = []
responses = []

print("=== Selected CRPs ===")

for i, idx in enumerate(selected_indices):
    row = df.iloc[idx]

    challenge_bin = str(row["challenge"]).zfill(8)
    response_bin = str(row["response"]).zfill(8)
    response_int = int(response_bin, 2)

    print(f"CRP {i+1}: C={challenge_bin} R={response_bin}")

    selected_crps.append({
        "challenge": challenge_bin
    })

    responses.append(response_int)

# -------------------------------
# 3. Form 32-bit response
# -------------------------------
data = bytearray(responses)

print("\nFinal Response:", list(data))

# -------------------------------
# 4. BCH setup (FIXED)
# -------------------------------
bch = bchlib.BCH(4, m=8)   #strong enough 4 bit error correction

ecc = bch.encode(data)

print("ECC length:", len(ecc))

# -------------------------------
# 5. Key generation
# -------------------------------
key = hashlib.sha256(data).digest()

print("Key (partial):", key.hex()[:16], "...")

# -------------------------------
# 6. Encrypt firmware
# -------------------------------
firmware = b"This_is_my_PYNQ"

def xor_encrypt(data, key):
    return bytes([d ^ key[i % len(key)] for i, d in enumerate(data)]) # XOR based encryption

encrypted = xor_encrypt(firmware, key)

# -------------------------------
# 7. Store device data
# -------------------------------
device_data = {
    "crps": selected_crps,       # challenges
    "response": list(data),      # stable response from CSV
    "ecc": list(ecc)
}

with open("device_data.json", "w") as f: #device_data.json stores the PUF-based identity data for device authentication.
    json.dump(device_data, f)

with open("firmware_encrypted.bin", "wb") as f: #writing the encrypted firmware.
    f.write(encrypted)

# -------------------------------
# 8. Done
# -------------------------------
print("\n✔ Enrollment Complete")
print("Files generated:")
print("- device_data.json")
print("- firmware_encrypted.bin")
