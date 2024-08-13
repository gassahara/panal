import matplotlib.pyplot as plt
import matplotlib.patches as patches

# Create figure and axis
fig, ax = plt.subplots(figsize=(14, 10))

# Adding elements to the diagram
# Step 1: Public Key on the billboard
ax.text(0.1, 0.9, 'Public Key (RSA)', fontsize=12, ha='center', bbox=dict(boxstyle="round,pad=0.3", edgecolor="black", facecolor="lightgrey"))

# Step 2: Encrypted Private Key on the billboard
ax.text(0.1, 0.7, 'Encrypted Private Key (RSA)', fontsize=12, ha='center', bbox=dict(boxstyle="round,pad=0.3", edgecolor="black", facecolor="lightgrey"))

# Step 3: Encrypted Private Key is decrypted with Vault's RSA key
ax.text(0.4, 0.7, 'Decrypt with Vault RSA Key', fontsize=12, ha='center', bbox=dict(boxstyle="round,pad=0.3", edgecolor="black", facecolor="lightblue"))

# Step 4: Vault's RSA Key is decrypted with User's AES Key
ax.text(0.4, 0.5, 'Decrypt with User AES Key', fontsize=12, ha='center', bbox=dict(boxstyle="round,pad=0.3", edgecolor="black", facecolor="lightblue"))

# Step 5: Messages are encrypted with the Public Key of the Mailbox
ax.text(0.7, 0.9, 'Message Encrypted (Public Key of Mailbox)', fontsize=12, ha='center', bbox=dict(boxstyle="round,pad=0.3", edgecolor="black", facecolor="lightgreen"))

# Step 6: Decryption of messages if Private Key of the Mailbox is available
ax.text(0.9, 0.9, 'Decrypt Message (Private Key of Mailbox)', fontsize=12, ha='center', bbox=dict(boxstyle="round,pad=0.3", edgecolor="black", facecolor="lightyellow"))

# Arrows to show flow
ax.annotate('', xy=(0.2, 0.7), xytext=(0.2, 0.9), arrowprops=dict(arrowstyle="->", lw=2))
ax.annotate('', xy=(0.4, 0.5), xytext=(0.4, 0.7), arrowprops=dict(arrowstyle="->", lw=2))
ax.annotate('', xy=(0.7, 0.9), xytext=(0.6, 0.9), arrowprops=dict(arrowstyle="->", lw=2))
ax.annotate('', xy=(0.9, 0.9), xytext=(0.8, 0.9), arrowprops=dict(arrowstyle="->", lw=2))

# Interlocutors and mailboxes
ax.text(0.7, 0.7, 'Interlocutors\n(each with a mailbox)', fontsize=12, ha='center', bbox=dict(boxstyle="round,pad=0.3", edgecolor="black", facecolor="lightgreen"))

# Hiding axes
ax.axis('off')

plt.show()
