from pynq import Overlay
from pynq.lib import AxiGPIO
import time
import csv

# 1. Load and program the FPGA
overlay = Overlay("YOUR_BITSTREAM_FILE.bit")   #Add your bitstream file name here.
overlay.download()

# 2. Hook up GPIO
chal_axi = overlay.axi_gpio_0
resp_axi = overlay.axi_gpio_1

chal_out = chal_axi.channel1
resp_in  = resp_axi.channel1

def send_challenge(challenge_val: int) -> int:
    chal_out.write(challenge_val, 0xFF)
    time.sleep(0.005)
    return resp_in.read()


# 3. Multiple sweeps (for MAJORITY VOTING) 
num_sweeps = 7  # You may change this to any odd value of your preference
all_sweeps = []

print(f"Starting {num_sweeps} full iterations of 0 to 255...")

for sweep in range(num_sweeps):
    print(f"  Running sweep {sweep + 1}/{num_sweeps}...")
    current_sweep_data = []
    
    for c in range(256):
        resp_int = send_challenge(c)
        current_sweep_data.append(format(resp_int, '08b'))
        
    all_sweeps.append(current_sweep_data)
    time.sleep(0.5)

# 4. Majority Voting
print("\nProcessing Majority Voting...")
final_crp_list = []

for c in range(256):
    bin_c = format(c, '08b')
    
    responses_for_c = [all_sweeps[s][c] for s in range(num_sweeps)]
    
    stable_response = ""
    
    for bit_index in range(8):
        count_ones = sum(1 for r in responses_for_c if r[bit_index] == '1')
        
        if count_ones > (num_sweeps // 2):
            stable_response += '1'
        else:
            stable_response += '0'
            
    final_crp_list.append((bin_c, stable_response))

# 5. Save CSV
with open("crp_list.csv", "w", newline="") as f:  # Change the csv file name of your preference
    writer = csv.writer(f)
    writer.writerow(["challenge", "response"])
    writer.writerows(final_crp_list)

# 6. Preview
print("\nFirst 10 CRPs (Global Majority Voted):")
for pair in final_crp_list[:10]:
    print(f"  {pair[0]} -> {pair[1]}")

print(f"\nTotal CRPs processed: {len(final_crp_list)}")
print("Saved to crp_list_global_voting.csv")