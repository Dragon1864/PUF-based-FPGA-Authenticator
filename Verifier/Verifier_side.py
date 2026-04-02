import bchlib
import hashlib
import json
import time
from pynq import Overlay
from pynq.lib import AxiGPIO

# -------------------------------
# 1. Load FPGA
# -------------------------------
overlay = Overlay("ro_puf_8_8.bit") # add your PUF bitstream files

chal_axi = AxiGPIO(overlay.ip_dict['axi_gpio_0'])
resp_axi = AxiGPIO(overlay.ip_dict['axi_gpio_1'])
en_axi = AxiGPIO(overlay.ip_dict['axi_gpio_2'])

chal_out = chal_axi.channel1
resp_in  = resp_axi.channel1
en_out  = en_axi.channel1

en_out.write(0,0x01)        # Initialy the Blinking LEDs are OFF.

# -------------------------------
# 2. Load stored data
# -------------------------------
with open("device_data.json", "r") as f: # add the deice_data.json which was derived from manufacturer side code
    device_data = json.load(f)

crps = device_data["crps"]
expected_response = device_data["response"]
ecc = bytearray(device_data["ecc"])

with open("firmware_encrypted.bin", "rb") as f: # add the firmware_encrypted file generated from manufacturer side code
    encrypted = f.read()

expected_firmware = b"This_is_my_PYNQ"

# -------------------------------
# 3. BCH setup
# -------------------------------
bch = bchlib.BCH(4, m=8) 

# -------------------------------
# 4. Read PUF using SAME CRPs
# -------------------------------
def read_puf_from_crps(crps):
    responses = []

    for item in crps:
        chal = int(item["challenge"], 2)

        chal_out.write(chal, 0xFF)
        time.sleep(0.005)

        r = resp_in.read() & 0xFF
        responses.append(r)

    return bytearray(responses)

# -------------------------------
# 5. Read noisy data
# -------------------------------
print("\n=== Verifier Started ===")

noisy_data = read_puf_from_crps(crps)
print("Noisy:", list(noisy_data))

# -------------------------------
# 6. BCH correction
# -------------------------------
nerr = bch.decode(noisy_data, ecc)

if nerr < 0:
    print("BCH Decode Failed")
    exit()

bch.correct(noisy_data, ecc)

print("Recovered:", list(noisy_data))
print("Expected :", expected_response)

# -------------------------------
# 7. STRICT MATCH CHECK
# -------------------------------
if list(noisy_data) != expected_response:
    print("\nWRONG DEVICE")
    exit()

print("\n✔ PUF MATCHED")

# -------------------------------
# 8. Key generation
# -------------------------------
key = hashlib.sha256(noisy_data).digest()

# -------------------------------
# 9. Decrypt firmware
# -------------------------------
def xor_decrypt(data, key):
    return bytes([d ^ key[i % len(key)] for i, d in enumerate(data)])

decrypted = xor_decrypt(encrypted, key)

# -------------------------------
# 10. Final verification
# -------------------------------
if decrypted == expected_firmware:
    print("\nDEVICE VERIFIED SUCCESSFULLY")
    en_out.write(1,0x01)            # Make the LED blink only if it is the authentic device
else:
    print("\nDECRYPTION FAILED")
    en_out.write(0,0x01)
