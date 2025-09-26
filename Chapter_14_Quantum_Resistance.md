# Chapter XIV: Quantum Resistance

## Section I: Quantum Computing

### How Quantum Computers Are Different

Think of regular computers like a light switch - it's either on (1) or off (0). Every calculation happens by flipping millions of these tiny switches very quickly, but they can only be in one state at a time.

Quantum computers are like magical light switches that can be both on AND off at the same time. Even stranger, these switches can be entangled, showing strong correlations even over long distances (though this doesn't allow faster-than-light messaging).

This means quantum computers can explore many possible solutions simultaneously instead of checking them one by one. Imagine trying to escape a maze - a regular computer would try each path one at a time, while a quantum computer could explore all paths at once. The real trick is quantum interference, which amplifies the good paths and cancels out the bad ones to find the exit faster.

However, quantum computers don't make everything faster - they only provide major advantages for certain specific types of problems, like breaking codes and searching through unsorted information with a quadratic speedup.

#### The Encryption Challenge

Today's encryption is like an incredibly complex padlock that would take regular computers billions of years to pick. We rely on math problems that are easy to verify but practically impossible to solve backwards.

For example, it's easy to multiply two huge numbers together, but extremely difficult to take that final number and figure out what the original two numbers were. This is the foundation of most internet security today.

Quantum computers could potentially solve these "impossible" math problems much faster, which means we need entirely new types of digital locks.

The good news is that not all encryption is equally vulnerable. Public key encryption systems like RSA and ECC, which are the kind used when you first connect to a website, are most at risk because a quantum algorithm called Shor's algorithm can break them on a sufficiently powerful quantum computer. 

However, symmetric encryption, which is used for the actual data transfer, isn't broken by quantum computers - we may just need larger symmetric keys like AES-256 for long-term data protection. Hash functions remain viable too, using longer hash outputs like SHA-256 or SHA-384 preserves security against quantum attacks.

#### What's At Stake

Our digital world runs on encrypted communication in ways most people never think about. Every time you check your bank balance, send a private message, make an online purchase, or log into your email, encryption protects that information.

Beyond personal data, encryption secures power grids, air traffic control systems, military communications, and the backbone of the internet itself. It enables secure voting systems, protects journalists' sources, and allows people to communicate safely under oppressive governments.

The "https" padlock in your browser, the security updates on your phone, and even the chip in your credit card - all depend on encryption that quantum computers could theoretically break.

#### The Timeline Problem

One of the trickiest aspects is that we don't know exactly when quantum computers will become powerful enough to break current encryption. Today's quantum computers are impressive but still quite limited - they can't even come close to breaking the encryption we use every day.

Breaking real-world encryption requires machines far more advanced than what exists today - what experts call "cryptanalytically relevant" quantum computers. Experts estimate this could happen anywhere from 5 to 30+ years from now, but nobody knows for sure.

There's also a "steal now, decrypt later" risk where bad actors could be collecting encrypted data today, planning to crack it once powerful quantum computers become available. This makes protecting long-term secrets especially important.

It's like knowing a big storm is coming but not sure if it's next week or next decade - the smart approach is to start preparing now rather than wait and see.

#### The Solution is Already Underway

Cryptographers have been preparing for this "quantum transition" for over a decade. In 2024, the U.S. government approved the first set of new encryption standards designed to resist quantum computers. Think of it like upgrading from mechanical locks to smart locks throughout an entire city. It's a big project, but manageable with proper planning.

This effort is part of a global, coordinated response led by organizations like the U.S. **National Institute of Standards and Technology (NIST)**. For over half a decade, NIST has been running a public competition to vet and select a portfolio of quantum-resistant cryptographic algorithms. The first set of these standards, including CRYSTALS-Dilithium for signatures, was finalized in 2024, providing a trusted foundation for the industry's transition.

Major tech companies, governments, and security organizations are already testing and implementing these quantum-resistant systems. Rather than a catastrophic overnight change, we're looking at a gradual, managed transition over the coming decades.

Critical systems like banking infrastructure, government communications, and power grids will upgrade first, followed by consumer applications.

Many organizations are building flexibility into their systems now - the ability to quickly swap out encryption methods like changing the batteries in a device. The goal is that most of these security upgrades can be delivered through regular software updates, though some will require hardware changes too.

While quantum computers pose a real future threat to current encryption, the cybersecurity community is actively preparing solutions. The transition will be gradual and planned, not a sudden crisis.

### Blockchain Cryptographic Landscape

Most blockchain networks rely heavily on elliptic-curve signatures for security. Bitcoin and Ethereum use **ECDSA over secp256k1**, while Solana employs **EdDSA over ed25519**. These signature schemes derive their security from the **Elliptic Curve Discrete Logarithm Problem (ECDLP)**, which presents an insurmountable challenge for classical computers but becomes trivial for Shor's algorithm running on a sufficiently powerful quantum computer.

**Hash functions** like SHA-256 and Keccak-256 offer greater resistance to quantum attack but aren't immune. Grover's algorithm effectively halves their security strength, reducing SHA-256's 256-bit security to 128 bits. While 128-bit security remains computationally infeasible today, it necessitates larger hash outputs for equivalent protection in a post-quantum world.

It's crucial to understand the different attack vectors: Grover's algorithm provides quadratic speedup for preimage and second-preimage attacks, while the best-known quantum collision attack (BHT) scales around 2^(n/3), offering a different and generally weaker advantage than Grover's preimage capabilities.

To illustrate the threat landscape: Shor's algorithm is like a master locksmith who can reverse-engineer any lock's blueprint from its face (your public key) and cut a matching key directly, catastrophic for RSA and ECDSA once the tools mature. Grover's algorithm resembles a superhuman librarian who must still search through library stacks, but can do so far more efficiently, turning a 256-bit search space into an effectively 128-bit one. One breaks mathematical structure entirely; the other dramatically accelerates brute-force search.

#### Timeline and Emerging Standards

Estimates when quantum computers break encryption keep changing. Scientists used to think it would take about 20 million quantum bits (called "qubits") and 8 hours to crack RSA-2048 encryption—the security standard that protects most of our online data today. Now they believe it might only need fewer than 1 million qubits and less than a week. These estimates assume we'll have nearly perfect quantum computers with almost no errors. Today's quantum computers are nowhere near that reliable.

Realistically, we're looking at the early 2030s at the absolute earliest. More likely, it'll be sometime between the mid-2030s and 2040s. It could even take longer if engineers hit unexpected roadblocks or faster if breakthroughs happen quicker because of unforeseen AI progress.

This timeline creates pressure across the entire blockchain ecosystem. Migration to quantum-resistant cryptography demands extensive coordination among all network participants, a challenge that extends far beyond simple algorithm swapping to encompass wallet software, infrastructure, governance mechanisms, and user education.

---

## Section II: Blockchain Vulnerability Assessment

### Public Key Exposure Models

To understand quantum vulnerability, we need to establish one fundamental principle: quantum computers can break public keys, but they cannot easily break the cryptographic hashes of those keys. This distinction is crucial because it determines which funds are at risk.

Think of it like this: a Bitcoin address is like a safe whose combination (the public key) isn't revealed until you open it. Once you open the safe, anyone listening can record your combination. Today's eavesdroppers can't use that combination to break into safes, but when quantum "lockpicks" arrive, they can replay those recorded combinations to steal whatever remains inside.

### Why Legacy Bitcoin Addresses Are More Vulnerable

Legacy Bitcoin addresses face significantly higher quantum risk for two concrete reasons. First is direct public key exposure through P2PK outputs. Early Bitcoin (2009-2012) frequently used P2PK (Pay-to-Public-Key) outputs that publish the public key directly on the blockchain with no cryptographic protection.

The transaction literally says "here's the public key, anyone who can prove they control it can spend this." On-chain analysis estimates that about 1.5–1.9 million BTC remain locked in these completely exposed P2PK outputs, including Satoshi's early mining rewards. This is like having a safe with the combination written on the outside. Quantum computers won't need to break any locks; they can simply read the combination and walk in.

The second vulnerability comes from address reuse patterns. Early Bitcoin users commonly reused the same address for multiple transactions, a practice that was later discouraged. Each time you spend from an address, you expose its public key on the blockchain. With address reuse, the first transaction reveals the public key while subsequent transactions leave remaining funds vulnerable to quantum attack. Legacy users often accumulated large balances on single addresses over time, then only spent portions, leaving substantial "change" vulnerable after the first spend.

### Current Standards

Newer Bitcoin addresses use P2PKH (Pay-to-Public-Key-Hash) and P2WPKH formats that only store the hash of the public key on-chain. The actual public key remains hidden until spending. Combined with modern single-use address practices, this creates much stronger quantum resistance. Unspent modern addresses keep their public keys never exposed and thus remain quantum-resistant. Single-use spending patterns expose the public key only after funds are moved, leaving no remaining balance to attack.

Ethereum's account model creates different exposure patterns. Every transaction from an EOA exposes a recoverable public key, but accounts that have never sent transactions remain protected. However, once an Ethereum address sends its first transaction, the public key is permanently exposed for any future deposits to that same address.

While individual address management presents clear challenges, smart contract wallets may offer enhanced protection through proxy patterns and upgradeable implementations, potentially enabling migration to quantum-resistant signature schemes without changing the wallet address. However, this protection depends entirely on specific implementation details and available upgrade mechanisms.

Multi-signature wallets present complex migration challenges, typically requiring all signers to coordinate simultaneous upgrades to quantum-resistant schemes. Social recovery mechanisms might provide alternative migration paths, though these require careful design to maintain security assumptions.

### Dormant and Potentially Lost Wallets

Building on these exposure patterns, we can now categorize the specific types of vulnerable assets across the ecosystem. **Dormant addresses** with exposed public keys represent significant systemic risk to the broader ecosystem.

The vulnerable landscape includes **early adopter addresses** with potentially lost private keys but exposed public keys from past spending activity, and **abandoned mining addresses** from Bitcoin's early era, particularly those used for early block rewards that were subsequently spent, exposing their public keys to future quantum harvest.

The fundamental challenge lies in distinguishing between **genuinely lost funds** and **dormant but recoverable** wallets. Quantum attackers could potentially recover funds from addresses presumed permanently lost: imagine the market chaos if millions of "lost" Bitcoin suddenly became recoverable, creating unexpected supply shocks and complex ownership disputes that could destabilize the entire ecosystem.

This creates a high-stakes scenario often described as a "**quantum rush**." Should a powerful quantum computer emerge suddenly, it would trigger a frantic race. Malicious actors would rush to crack vulnerable addresses and steal exposed funds, while network developers and the community would race to deploy emergency forks to freeze or migrate those same assets. The outcome of such an event would depend heavily on who acts first, introducing a stark game-theoretic dynamic into the security model.

### Best Practices

To protect against future quantum computing threats, users should adopt careful key management practices. For Ethereum, avoid keeping large amount of funds in an address after its first transaction, since any on-chain signature reveals your public key to potential quantum attacks, instead, migrate to a fresh, unused address or preferably a smart contract wallet that can be upgraded to post-quantum cryptographic schemes.

Bitcoin users should similarly avoid address reuse by spending entire UTXOs to fresh addresses, ensuring no value remains tied to previously exposed public keys. While multisig and multi-party computation (MPC) solutions offer enhanced security today, they don't eliminate quantum risk if they still rely on secp256k1 cryptography once public keys are revealed; their primary value lies in providing an upgrade path to quantum-resistant algorithms when they become available.

---

## Section III: Quantum-Resistance Transition

### Bitcoin's Approach

The Bitcoin developer community is actively working on concrete plans to protect the network against future quantum computers, with several serious proposals now under review. This effort addresses a significant threat that particularly affects early Bitcoin outputs known as P2PK (Pay-to-Public-Key), where public keys are already visible on the blockchain, making them prime targets for quantum attack. While P2PK outputs represent only about 0.025% of all Bitcoin transactions by count, they control approximately 10% of all Bitcoin (estimated to be about 1.5–1.9 million BTC) with many dating back to Bitcoin's earliest days and attributed to Satoshi's mining activities.

The most prominent technical solution is **BIP-360**, which introduces a new "Pay-to-Quantum-Resistant-Hash" address type that would allow wallets to use post-quantum signatures like hash-based or lattice-based cryptography. This represents a soft-fork approach that could be gradually adopted without breaking existing functionality. Additionally, developers are exploring ways to leverage Taproot's existing structure by disabling key-path spends and adding quantum-resistant signature checks to tapscript.

The community is grappling with fundamental questions about implementation approach: should Bitcoin force users to migrate away from quantum-vulnerable ECDSA signatures, or make it optional? Proposed solutions range from doing nothing (allowing quantum computers to potentially steal vulnerable coins) to implementing consensus changes that would freeze or burn quantum-vulnerable outputs before they can be compromised. Jameson Lopp has outlined a multi-year deprecation plan that would eventually phase out vulnerable outputs, while others like Agustín Cruz have proposed more aggressive "QRAMP" protocols with hard deadlines, though these face pushback due to concerns about potentially making funds unspendable.

Some proposals suggest deadline-based migration systems where users would need to move their coins to quantum-resistant addresses within a specified timeframe, while others explore commitment schemes that would allow current holders to prove ownership and migrate safely. There's ongoing debate about whether to specifically target Satoshi-era coins for special treatment, though this raises concerns about violating Bitcoin's principle against freezing funds.

Ultimately, for truly lost or abandoned coins, including potentially Satoshi's dormant holdings, developers face a binary choice in the quantum era: either these coins will be stolen by whoever possesses quantum computing capabilities first, or they will be permanently burned through protective consensus changes. While Satoshi himself suggested in 2010 that users could migrate to stronger cryptographic schemes, this solution only works for those who still have access to their private keys.

While the technical groundwork is solid, no consensus has emerged on implementation timelines or enforcement mechanisms. No concrete protocol changes have been implemented yet, but the Bitcoin development community continues to balance the need for quantum protection against the social and economic costs of forced upgrades, with Bitcoin Optech tracking the ongoing debates and proposals as they evolve from early concepts toward potential consensus rules. The discussion reflects the community's proactive approach to preserving Bitcoin's security and integrity in a post-quantum world.

### Ethereum's Approach

Ethereum is actively preparing for the quantum computing threat through serious, concrete discussions and draft proposals. The community recognizes that current cryptographic primitives, like the secp256k1 ECDSA signatures used by user accounts and BLS signatures used by validators, would be vulnerable to quantum attacks using Shor's algorithm.

The migration strategy centers on a multi-pronged, staged approach rather than a single protocol-wide switch. For user transactions, **EIP-7932** proposes supporting multiple signature algorithms to enable post-quantum schemes while maintaining backward compatibility with existing accounts. Account Abstraction is serving as a key on-ramp, allowing smart wallets to implement quantum-resistant signatures (like Dilithium, Falcon, or SPHINCS+) without requiring immediate protocol changes. The Ethereum Foundation is actively funding research into post-quantum multi-signature schemes to address the larger signature sizes that come with quantum-resistant algorithms.

Beyond user accounts, Ethereum is planning broader architectural shifts toward quantum-resistant foundations. The long-term vision involves moving away from pairing-based cryptography (like KZG commitments used in data availability) toward hash-based and STARK-style constructions, which only face Grover's algorithm's more manageable quadratic speedup rather than Shor's exponential advantage. An emergency "recovery fork" plan has also been developed to quickly freeze vulnerable accounts and provide migration paths if quantum breakthroughs happen suddenly.

This is no longer just theoretical planning. There are draft EIPs in active discussion, Ethereum Foundation grants funding post-quantum research, and working prototypes using Account Abstraction for quantum-resistant signatures. While these new algorithms offer security against quantum computers, they come with significant practical trade-offs. 

One of the largest challenges is the increase in **data size and computational cost**. A current ECDSA signature is approximately 64 bytes, whereas a quantum-resistant signature from CRYSTALS-Dilithium can be over 2,400 bytes, and a SPHINCS+ signature can be over 17,000 bytes. This dramatic increase in size directly impacts the blockchain by leading to larger transactions, increased storage requirements (**blockchain bloat**), and higher transaction fees. Slower verification times can also affect block processing and network throughput, presenting a major engineering hurdle for protocol developers.