# Chapter XIV: Quantum Resistance

## Section I: Quantum Computing

Regular computers work with bits, which are tiny switches that exist in one of two states: either 0 or 1. Quantum computers, however, operate with something quite different called qubits. A qubit possesses a remarkable property: it can exist in a blend of both 0 and 1 simultaneously, carrying within it a kind of "maybe" state until the moment you observe it. 

Breaking encryption with regular computers is like finding a needle in a haystack. You have to search through countless possibilities one by one, methodically checking each piece of straw. The haystack is so vast that it would take thousands of years to find the needle, making the task effectively impossible within any reasonable timeframe.

Breaking encryption with quantum computers is like using a magnet to find that needle. Suddenly, what seemed impossible becomes feasible. The quantum computer's ability to explore many possibilities simultaneously, combined with interference effects that amplify correct answers, acts like that magnet pulling the needle straight to you.

This is why cryptographers are developing quantum-resistant encryption. Think of it as changing the needle to aluminum. Now the magnet can't attract it anymore. These new encryption methods are designed so that even quantum computers lose their special advantage and must return to searching through the haystack piece by piece, just like their classical counterparts.

However, quantum computers don't make everything faster. They only provide major advantages for certain specific types of problems, like breaking certain codes and searching through unsorted information with a quadratic speedup.

#### What's Vulnerable and What's Not

Today's encryption relies on mathematical problems that are easy to verify but practically impossible to solve backwards. For example, it's easy to multiply two huge numbers together, but extremely difficult to take that final number and figure out what the original two numbers were. This asymmetry is the foundation of most internet security today, with problems that would take regular computers billions of years to crack.

The quantum threat isn't uniformly devastating across all cryptographic systems. Public key encryption systems like RSA and ECC are most at risk; a quantum algorithm called Shor's algorithm can break them by exploiting the mathematical structure of problems like factoring large numbers and computing discrete logarithms. These mathematical patterns have elegant properties that quantum algorithms can exploit.

Symmetric encryption like AES-256 remains secure with only minor key size adjustments. Hash functions remain viable too, though using longer outputs like SHA-256 or SHA-384 preserves security against quantum attacks. The difference is that quantum-resistant approaches use mathematical problems that lack the structure quantum computers can exploit—problems like finding the shortest vector in a high-dimensional lattice, decoding random linear codes, or building security from collision-resistant hash functions. These problems remain hard even for quantum computers.

#### What's At Stake

Today's digital world runs on encrypted communication in ways most people never think about. Every time someone checks their bank balance, sends a private message, makes an online purchase, or logs into their email, encryption protects that information.

Beyond personal data, encryption secures power grids, air traffic control systems, military communications, and the backbone of the internet itself. It enables secure voting systems, protects journalists' sources, and allows people to communicate safely under oppressive governments.

The "https" padlock in browsers, the security updates on phones, and even the chip in credit cards all depend on encryption that these machines could theoretically break.

#### The Timeline Problem

One of the trickiest aspects is that we don't know exactly when quantum computers will become powerful enough to break current encryption. In October 2025, Google announced a significant milestone with their algorithm called "quantum echoes." The system successfully computed molecular structures in ways that classical supercomputers cannot, demonstrating what experts call "quantum advantage."

However, current systems can't threaten encryption. Google's breakthrough computed a narrow scientific problem, but breaking modern cryptography would require machines with hundreds of thousands to millions of stable qubits. Today's systems struggle to maintain even smaller numbers in the extremely controlled conditions they need.

The timeline remains uncertain. Google estimates real-world applications remain about five years away, while cryptanalytically relevant systems capable of breaking encryption will take considerably longer.

To put this in perspective, these cryptanalytically relevant quantum computers would need specific capabilities to crack encryption. Early estimates suggested it would take about 20 million quantum bits (called "qubits") and 8 hours to crack RSA-2048 encryption. Recent work by Gidney (2025) brings this estimate down to fewer than 1 million qubits and less than a week. These estimates assume nearly perfect quantum computers with almost no errors, something today's quantum computers are nowhere near achieving.

Realistically, we're looking at the early 2030s at the absolute earliest. More likely, it'll be sometime between the mid-2030s and 2040s. It could even take longer if engineers hit unexpected roadblocks or faster if breakthroughs happen quicker because of unforeseen AI progress.

There's also a "steal now, decrypt later" risk where bad actors could be collecting encrypted data today, planning to crack it once powerful quantum computers become available. This makes protecting long-term secrets especially important.

It's like knowing a big storm is coming but not sure if it's next week or next decade. The smart approach is to start preparing now rather than wait and see.

#### The Cryptographic Solution

Cryptographers have been preparing for this "quantum transition" for over a decade. In 2024, the U.S. government approved the first set of new encryption standards designed to resist quantum computers. Think of it like upgrading from mechanical locks to smart locks throughout an entire city. It's a big project, but manageable with proper planning.

This effort is part of a global, coordinated response led by organizations like the U.S. **National Institute of Standards and Technology (NIST)**. For nearly 10 years, NIST has been running a public competition to vet and select a portfolio of quantum-resistant cryptographic algorithms. The first set of these standards was finalized in 2024, providing a trusted foundation for the industry's transition.

These new standards include algorithms from different mathematical families. In August 2024, NIST finalized three standards: **ML-KEM** for key encapsulation, **ML-DSA** for lattice-based digital signatures, and **SLH-DSA** for hash-based signatures. NIST is also drafting **Falcon** as **FN-DSA** in the upcoming standard. Lattice-based algorithms prioritize efficiency, while hash-based signatures prioritize high security confidence through simpler mathematical assumptions. NIST continues evaluating code-based and other approaches as additional options. Each offers different trade-offs between signature size, speed, and security assumptions. This diversity provides insurance: if one mathematical approach proves vulnerable, the ecosystem can shift to alternatives.

#### Implementation Timeline

Major tech companies, governments, and security organizations are already testing and implementing these quantum-resistant systems. Rather than a catastrophic overnight change, we're looking at a gradual, managed transition over the coming decades.

Critical systems like banking infrastructure, government communications, and power grids will upgrade first, followed by consumer applications. Many organizations are building flexibility into their systems now: the ability to quickly swap out encryption methods like changing the batteries in a device. The goal is that most of these security upgrades can be delivered through regular software updates, though some will require hardware changes too.

However, blockchains face unique implementation challenges that centralized systems don't encounter. Traditional organizations can mandate upgrades across their infrastructure, pushing updates through internal IT departments. Blockchain networks, by contrast, must coordinate changes across thousands of independent node operators, wallet providers, and users, all without central authority to enforce compliance. This coordination challenge becomes even more complex when considering dormant wallets, potentially lost private keys, and the philosophical tensions around whether networks should force upgrades or risk leaving vulnerable assets exposed.

While quantum computers pose a real future threat to current encryption, the cybersecurity community is actively preparing solutions. The transition will be gradual and planned for traditional systems, not a sudden crisis, though blockchain networks face unique coordination challenges in implementing these new standards across decentralized systems.

## Section II: Blockchain Vulnerability Assessment

Blockchains face a uniquely difficult challenge in the quantum era. Unlike traditional systems where organizations can mandate centralized upgrades to post-quantum cryptography, blockchain networks operate through distributed consensus among thousands of independent nodes. The very features that make blockchains secure today (immutability, transparency, and decentralization) become obstacles when coordinating a cryptographic migration.

The challenge intensifies because blockchain transactions create permanent public records. Every signature ever published on-chain becomes a potential attack surface once quantum computers mature. Traditional financial systems can rotate their encryption keys behind closed doors, but blockchain addresses with exposed public keys remain vulnerable forever unless protocol-level changes intervene. This section examines which blockchain assets face the greatest quantum risk, why some addresses are more vulnerable than others, and what users can do to protect themselves while developers work on network-wide solutions.

### Technical Foundation

Most blockchain networks rely heavily on elliptic-curve signatures for security. Bitcoin and Ethereum use **ECDSA over secp256k1**, while Solana employs **EdDSA over ed25519**. These signature schemes derive their security from the **Elliptic Curve Discrete Logarithm Problem (ECDLP)**, which presents an insurmountable challenge for classical computers but becomes trivial for Shor's algorithm running on a sufficiently powerful quantum computer.

It's crucial to understand the different attack vectors: Grover's algorithm provides quadratic speedup for preimage and second-preimage attacks on hash functions, while the best-known quantum collision attack (**BHT**) scales around 2^(n/3), offering a different and generally weaker advantage than Grover's preimage capabilities. While 128-bit security remains computationally infeasible today, it necessitates larger hash outputs for equivalent protection in a post-quantum world.

To illustrate the threat landscape: Shor's algorithm is like a master locksmith who can reverse-engineer any lock's blueprint from its face (the public key) and cut a matching key directly, catastrophic for RSA and ECDSA once the tools mature. Grover's algorithm resembles a superhuman librarian who must still search through library stacks, but can do so far more efficiently, turning a 256-bit search space into an effectively 128-bit one. One breaks mathematical structure entirely; the other dramatically accelerates brute-force search.

### Public Key Exposure Models

Think of it like this: a Bitcoin address is like a safe whose combination (the public key) isn't revealed until someone opens it. Once the safe is opened, anyone listening can record the combination. Today's eavesdroppers can't use that combination to break into safes, but when quantum "lockpicks" arrive, they can replay those recorded combinations to steal whatever remains inside.

This analogy captures a fundamental principle: quantum computers can break public keys, but they cannot easily break the cryptographic hashes of those keys. This distinction determines which funds are at risk.

### Why Legacy Bitcoin Addresses Are More Vulnerable

Legacy Bitcoin addresses face significantly higher quantum risk for two concrete reasons. First is direct public key exposure through **P2PK** outputs. Early Bitcoin (2009-2012) frequently used P2PK (Pay-to-Public-Key) outputs that publish the public key directly on the blockchain with no cryptographic protection.

The transaction literally says "here's the public key, anyone who can prove they control it can spend this." Over 1.5 million BTC (roughly 8.7% of Bitcoin's total supply, yet only 0.025% of UTXOs) remain locked in these completely exposed P2PK outputs, including Satoshi's early mining rewards. This is like having a safe with the combination written on the outside. Quantum computers won't need to break any locks; they can simply read the combination and walk in.

The second vulnerability comes from address reuse patterns. Early Bitcoin users commonly reused the same address for multiple transactions, a practice that was later discouraged. Each time someone spends from an address, they expose its public key on the blockchain. With address reuse, the first transaction reveals the public key while subsequent transactions leave remaining funds vulnerable to quantum attack. Legacy users often accumulated large balances on single addresses over time, then only spent portions, leaving substantial "change" vulnerable after the first spend.

### Current Standards

Newer Bitcoin addresses use **P2PKH** (Pay-to-Public-Key-Hash) and **P2WPKH** formats that only store the hash of the public key on-chain. The actual public key remains hidden until spending. Combined with modern single-use address practices, this creates much stronger quantum resistance. Unspent modern P2PKH and P2WPKH addresses keep their public keys never exposed and thus remain quantum-safe. Single-use spending patterns expose the public key only after funds are moved, leaving no remaining balance to attack.

However, **P2TR (Taproot)** addresses present a different exposure pattern. Taproot key-path spends embed a public key directly in the output, placing them in the "exposed-key" category similar to P2PK. While Taproot currently holds a relatively small share of Bitcoin's total supply, users should be aware that these addresses don't provide the same quantum protection as P2PKH or P2WPKH.

Ethereum's account model creates different exposure patterns. Every transaction from an **EOA** exposes a recoverable public key, but accounts that have never sent transactions remain protected. However, once an Ethereum address sends its first transaction, the public key is permanently exposed for any future deposits to that same address.

While individual address management presents clear challenges, smart contract wallets may offer enhanced protection through proxy patterns and upgradeable implementations, potentially enabling migration to quantum-safe signature schemes without changing the wallet address. However, this protection depends entirely on specific implementation details and available upgrade mechanisms.

Multi-signature wallets present complex migration challenges, typically requiring all signers to coordinate simultaneous upgrades to post-quantum schemes. Social recovery mechanisms might provide alternative migration paths, though these require careful design to maintain security assumptions.

### Dormant and Potentially Lost Wallets

Building on these exposure patterns, we can now categorize the specific types of vulnerable assets across the ecosystem. **Dormant addresses** with exposed public keys represent significant systemic risk to the broader ecosystem.

The vulnerable landscape includes early adopter addresses with potentially lost private keys but exposed public keys from past spending activity, and abandoned mining addresses from Bitcoin's early era, particularly those used for early block rewards that were subsequently spent, exposing their public keys to future quantum harvest.

The fundamental challenge lies in distinguishing between genuinely lost funds and dormant but recoverable wallets. Quantum attackers could potentially recover funds from addresses presumed permanently lost: imagine the market chaos if millions of "lost" Bitcoin suddenly became recoverable, creating unexpected supply shocks and complex ownership disputes that could destabilize the entire ecosystem.

This creates a high-stakes scenario often described as a "**quantum rush**." Should a powerful quantum computer emerge suddenly, it would trigger a frantic race. Malicious actors would rush to crack susceptible addresses and steal exposed funds, while network developers and the community would race to deploy emergency forks to freeze or migrate those same assets. The outcome of such an event would depend heavily on who acts first, introducing a stark game-theoretic dynamic into the security model.

At current valuations, those at-risk BTC represent over $100 billion in exposed value, effectively creating a massive bounty for whoever achieves quantum supremacy first. This transforms quantum computing development from purely scientific pursuit into strategic competition. Nation-states and well-funded private entities now have a concrete financial incentive, beyond military or intelligence applications, to accelerate their quantum programs: whoever breaks the threshold first gains the ability to seize billions in abandoned or lost Bitcoin before the network can coordinate defensive forks. The race isn't just about who builds the computer, but who can extract maximum value before the window closes.

### Best Practices

To protect against future quantum computing threats, users should adopt careful key management practices. For Ethereum, avoid keeping large amounts of funds in an address after its first transaction, since any on-chain signature reveals the public key to potential quantum attacks. Instead, migrate to a fresh, unused address or preferably a smart contract wallet that can be upgraded to post-quantum cryptographic schemes.

Bitcoin users should similarly avoid address reuse by spending entire **UTXOs** to fresh addresses, ensuring no value remains tied to previously exposed public keys. While multisig and multi-party computation (**MPC**) solutions offer enhanced security today, they don't eliminate quantum risk if they still rely on secp256k1 cryptography once public keys are revealed; their primary value lies in providing an upgrade path to post-quantum algorithms when they become available.

### The Protocol-Level Challenge

While individual users can adopt protective practices, the exposure patterns detailed above reveal a fundamental limitation: personal key management cannot protect the ecosystem as a whole. The over 1.5 million BTC sitting in exposed P2PK outputs, the countless reused addresses from Bitcoin's early days, and Ethereum's account model exposure all require coordinated protocol-level responses. 

No amount of individual vigilance can secure funds whose public keys are already permanently visible on-chain, nor can it prevent the systemic chaos of a potential quantum rush. This reality has driven blockchain developers to move beyond user education toward concrete technical proposals for network-wide quantum resistance. The question is no longer whether blockchains need protocol changes, but rather how to implement them without breaking existing functionality or creating unacceptable economic disruption.

## Section III: Quantum-Resistance Transition

Having established the threat landscape and vulnerability patterns, we now turn to how major blockchain networks are responding. Each network faces unique architectural constraints and governance challenges that shape their migration strategies. Bitcoin must balance immutability with security upgrades, while Ethereum leverages its more flexible upgrade culture. The technical solutions exist, but implementing them requires navigating complex social coordination problems that test the limits of decentralized governance.

### Bitcoin's Approach

The Bitcoin developer community is actively working on concrete plans to protect the network against future quantum threats, with several serious proposals now under review. As detailed in Section II, over 1.5 million BTC remain locked in exposed P2PK outputs, including Satoshi's early mining rewards, representing a disproportionately large amount of Bitcoin concentrated in a small number of vulnerable transactions.

The technical solutions under consideration are sophisticated, building on Bitcoin's existing upgrade mechanisms. **BIP-360 (P2QRH)** represents a soft-fork that introduces a new "Pay-to-Quantum-Resistant-Hash" address type. The latest draft makes P2QRH a taproot-style, script-spend-only output, disabling key-spends to prevent quantum vulnerabilities. Post-quantum signature opcodes will be specified in a separate future BIP, not inside BIP-360 itself.

This represents a gradual approach that could be adopted without breaking existing functionality. Additionally, developers are exploring ways to leverage **Taproot's** existing structure by disabling key-path spends and adding quantum-resistant signature checks to tapscript.

However, the core challenge isn't technical but social and economic: should Bitcoin force users to migrate, or make it optional? Proposed solutions span a wide spectrum. Jameson Lopp has outlined a multi-year deprecation plan that would gradually phase out at-risk outputs, while Agustín Cruz's more aggressive "QRAMP" protocol proposes hard deadlines for the upgrade, though this faces pushback over potentially making dormant funds unspendable. Other proposals explore commitment schemes allowing current holders to prove ownership and move assets safely, or deadline-based systems with grace periods.

The debate intensifies when considering what should happen to dormant holdings that can't or won't be moved before quantum computers arrive. Three main approaches are under discussion: **(1) permanently burning** the at-risk assets to prevent quantum seizure, **(2) doing nothing** and allowing quantum-equipped actors to claim them, or **(3) recycling** the funds back into the block reward subsidy to extend miner incentives beyond the original supply schedule.

Each option faces significant philosophical resistance within the Bitcoin community. The ethos strongly opposes burning or recycling holdings that are rightfully owned, even if the owner is presumed dead or absent. The principle of immutable property rights runs deep in Bitcoin culture; many view Satoshi's early holdings as legitimately his, and any protocol change that makes them unspendable, whether through burning or redistribution, violates the fundamental promise that "your keys, your coins" means permanent ownership. This creates a painful tension: protecting the network from quantum attack may require violating the very property rights that make Bitcoin valuable in the first place.

Ultimately, for truly lost or abandoned assets where private keys are genuinely gone, developers face this difficult choice: either these funds will be stolen by whoever possesses quantum computing capabilities first, or they will become unspendable through protective consensus changes. While Satoshi himself suggested in 2010 that users could upgrade to stronger cryptographic schemes, this solution only works for those who still control their private keys. No consensus has emerged on timelines or enforcement, but Bitcoin Optech continues tracking these debates as they evolve from early concepts toward potential consensus rules.

### Ethereum's Approach

Unlike Bitcoin's philosophical tensions around property rights and coin burning, Ethereum faces primarily technical scaling challenges. The community's more flexible upgrade culture allows for iterative solutions, though the practical obstacles remain substantial. Current cryptographic primitives, like the secp256k1 ECDSA signatures used by user accounts and **BLS** signatures used by validators, would be susceptible to the attacks discussed earlier.

The upgrade strategy centers on a multi-pronged, staged approach rather than a single protocol-wide switch. For user transactions, **EIP-7932** proposes supporting multiple signature algorithms to enable post-quantum schemes while maintaining backward compatibility with existing accounts. **Account Abstraction** is serving as a key on-ramp, allowing smart wallets to implement these quantum-safe signatures without requiring immediate protocol changes. The Ethereum Foundation is actively funding research into post-quantum multi-signature schemes to address the larger signature sizes that come with quantum-resistant algorithms.

However, as discussed earlier in Section I's cryptographic overview, these new algorithms come with significant practical trade-offs. The most immediate challenge is the dramatic increase in data size. A current ECDSA signature is approximately 64 bytes, providing a compact baseline for comparison. CRYSTALS-Dilithium signatures are around 2,400 bytes, roughly 37 times larger than current signatures. SPHINCS+ signatures are even more substantial: approximately 7,900 at 128-bit security ('s' variant), around 16,200 at 192-bit security, and can exceed 29,000 at higher security levels. This represents a 123x to 450x size increase over current signatures.

These size increases directly impact blockchain operation in multiple ways. Transactions become larger, leading to increased storage requirements and **blockchain bloat**. Higher transaction fees follow naturally from the increased data that must be processed and stored. Slower verification times can also affect block processing and network throughput, presenting a major engineering hurdle for protocol developers who must balance security against usability.

Beyond user accounts, Ethereum is planning broader architectural shifts toward quantum-safe foundations. The long-term vision involves moving away from pairing-based cryptography (like **KZG** commitments used in data availability) toward hash-based and STARK-style constructions, which only face Grover's algorithm's more manageable quadratic speedup rather than Shor's exponential advantage. An articulated proposal exists for an emergency recovery fork to quickly freeze exposed accounts and provide migration paths if quantum breakthroughs happen suddenly. There are draft EIPs in active discussion, Ethereum Foundation grants funding post-quantum research, and working prototypes using Account Abstraction for quantum-safe signatures.

## Section IV: Key Takeaways

**Quantum computers exploit mathematical structure, not computational power.** Classical computers must search through encryption possibilities one by one, while quantum computers use interference effects to amplify correct answers for specific problem types. This advantage only works when the underlying math has exploitable patterns, which is why public key systems like ECDSA collapse under quantum attack while hash functions remain viable with modest adjustments. The threat is selective rather than universal. Organizations relying on vulnerable cryptographic foundations face complete exposure once quantum computers mature, while those built on quantum-resistant primitives maintain their security guarantees.

**Blockchain immutability transforms defensive advantage into coordination trap.** Traditional systems upgrade encryption behind closed doors through centralized mandates, but blockchains must coordinate changes across thousands of independent operators without central authority. Every signature ever published becomes a permanent attack surface, and transparency means attackers can identify targets years in advance. The very features that make blockchains trustworthy create obstacles when migrating cryptography. Networks face an impossible tradeoff between preserving decentralization and executing timely security upgrades, with slow-moving governance potentially leaving billions in exposed assets vulnerable.

**Public key exposure, not transaction history, determines quantum vulnerability.** Unspent addresses that never revealed their public keys remain protected by cryptographic hashes, which quantum computers struggle to break. Once an address spends funds and exposes its public key on-chain, any remaining balance becomes attackable. Early blockchain practices like address reuse and direct public key embedding created vast exposure surfaces, while modern single-use patterns and hash-protected addresses minimize risk. Users who understand this distinction can protect themselves today, but legacy holdings and dormant wallets with exposed keys create systemic threats no individual action can resolve.

**Dormant exposed funds create a quantum rush game theory problem.** Distinguishing between lost private keys and merely inactive wallets becomes impossible from outside, yet both face the same quantum threat if their public keys are visible. The first actor with sufficient quantum capability can seize these assets before networks coordinate defensive responses, turning quantum computing development into a strategic race with concrete financial incentives. This creates sudden supply shocks and ownership disputes that destabilize entire networks. The scenario forces communities to choose between violating property rights through preemptive fund freezes or accepting theft by quantum-equipped attackers.

**Technical solutions exist but require breaking sacred social contracts.** Developers can implement quantum-resistant algorithms and create migration paths through soft forks and account abstraction frameworks. The barrier is philosophical rather than technical, particularly for networks like Bitcoin where forced migrations conflict with immutability principles. Protecting the network may require making dormant funds unspendable, burning exposed assets, or recycling them into mining rewards, each option violating core community values around permanent ownership. Networks must navigate this tension between security pragmatism and foundational promises, with no consensus emerging on acceptable tradeoffs.