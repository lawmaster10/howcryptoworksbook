# Chapter XIV: Quantum Resistance

## Section I: Quantum Computing

Regular computers work with bits, which are tiny switches that exist in one of two states: either 0 or 1\. Quantum computers, however, operate with something quite different called **qubits**. A qubit possesses a remarkable property: it can exist in a blend of both 0 and 1 simultaneously, carrying within it a kind of "maybe" state until the moment you observe it.

Breaking encryption with regular computers is like finding a needle in a haystack. You have to search through countless possibilities one by one, methodically checking each piece of straw. The haystack is so vast that it would take thousands of years to find the needle, making the task effectively impossible within any reasonable timeframe.

Breaking encryption with quantum computers is like using a magnet to find that needle. Suddenly, what seemed impossible becomes feasible. The quantum computer's ability to explore many possibilities simultaneously, combined with interference effects that amplify correct answers, acts like that magnet pulling the needle straight to you.

This is why cryptographers are developing **quantum-resistant encryption**. Think of it as changing the needle to aluminum. Now the magnet can't attract it anymore. These new encryption methods are designed so that even quantum computers lose their special advantage and must return to searching through the haystack piece by piece, just like their classical counterparts.

However, quantum computers don't make everything faster. They only provide major advantages for certain specific types of problems, like breaking certain codes and speeding up certain search operations.

### What's Vulnerable and What's Not

Today's encryption relies on mathematical problems that are easy to verify but practically impossible to solve backwards. For example, it's easy to multiply two huge numbers together, but extremely difficult to take that final number and figure out what the original two numbers were. This asymmetry is the foundation of most internet security today, with problems that would take regular computers billions of years to crack.

The quantum threat isn't uniformly devastating across all cryptographic systems. Public key encryption systems like RSA and ECC are most at risk. A quantum algorithm called **Shor's algorithm** can break them by exploiting the mathematical structure these systems rely on. These mathematical patterns have elegant properties that quantum algorithms can exploit.

Symmetric encryption like AES-256 remains secure with only minor key size adjustments. Hash functions remain viable too, though using longer outputs preserves security against quantum attacks. The key insight is that quantum-resistant approaches use mathematical problems that lack the elegant structure quantum computers can exploit. These alternative problems remain hard even for quantum computers, which is why cryptographers have spent years developing new standards based on them.

### What's At Stake

Today's digital world runs on encrypted communication in ways most people never think about. Every time someone checks their bank balance, sends a private message, makes an online purchase, or logs into their email, encryption protects that information.

Beyond personal data, encryption secures power grids, air traffic control systems, military communications, and the backbone of the internet itself. It enables secure voting systems, protects journalists' sources, and allows people to communicate safely under oppressive governments.

The "https" padlock in browsers, the security updates on phones, and even the chip in credit cards all depend on encryption that these machines could theoretically break.

### The Timeline Problem

One of the trickiest aspects is that we don't know exactly when quantum computers will become powerful enough to break current encryption. In October 2025, Google announced a significant milestone with their algorithm called "quantum echoes." The system outperformed classical methods on a benchmark measuring how disturbances spread through a quantum system. A related molecular-structure demonstration explored practical applications but did not establish the same advantage.

Current quantum computers cannot break the cryptography securing major blockchains. Google's breakthrough addressed a narrow scientific problem; attacking cryptographic keys requires large, fault-tolerant machines that have not yet been built.

Resource estimates are nevertheless falling. Gidney's 2025 work estimated that RSA-2048 could be broken in less than a week with fewer than 1 million physical qubits. This is a model of a future machine, not a demonstrated capability.

More directly relevant to blockchains, Google-led research in March 2026 estimated that 256-bit elliptic-curve cryptography could be attacked in minutes with fewer than 500,000 physical qubits assuming major advances in hardware and error correction. This remains an estimate for a machine that does not yet exist.

There is no defensible absolute earliest date for such a machine. Google's 2029 migration target reflects the time needed to replace vulnerable cryptography, not a prediction that quantum attacks will be practical that year. Progress in hardware and error correction could still accelerate or delay the threat.

However, not everyone shares this conservative outlook. In November 2025, Ethereum founder Vitalik Buterin predicted that quantum computers capable of breaking Ethereum's underlying security model could arrive before the next US presidential election in 2028\.

There's also a "steal now, decrypt later" risk where bad actors could be collecting encrypted data today, planning to crack it once powerful quantum computers become available. This makes protecting long-term secrets especially important.

It's like knowing a big storm is coming but not sure if it's next week or next decade. The smart approach is to start preparing now rather than wait and see.

### The Cryptographic Solution

Cryptographers have been preparing for this "quantum transition" for over a decade. In 2024, the U.S. government approved the first set of new encryption standards designed to resist quantum computers. Think of it like upgrading from mechanical locks to smart locks throughout an entire city. It's a big project, but manageable with proper planning.

This effort is part of a global, coordinated response led by organizations like the U.S. National Institute of Standards and Technology (NIST). For nearly 10 years, NIST has been running a public competition to vet and select a portfolio of quantum-resistant cryptographic algorithms. The first set of these standards was finalized in 2024, providing a trusted foundation for the industry's transition.

These new standards include algorithms from different mathematical families. In August 2024, NIST finalized three initial standards based on two distinct approaches: **lattice-based cryptography**, which prioritizes efficiency, and **hash-based signatures**, which prioritize high security confidence through simpler mathematical assumptions. NIST continues evaluating additional approaches as well. Each offers different trade-offs between signature size, speed, and security assumptions. This diversity provides insurance: if one mathematical approach proves vulnerable, the ecosystem can shift to alternatives.

### Implementation Timeline

Major tech companies, governments, and security organizations are already testing and implementing these quantum-resistant systems. Rather than a catastrophic overnight change, we're looking at a gradual, managed transition over the coming decades.

Critical systems like banking infrastructure, government communications, and power grids will upgrade first, followed by consumer applications. Many organizations are building flexibility into their systems now: the ability to quickly swap out encryption methods like changing the batteries in a device. The goal is that most of these security upgrades can be delivered through regular software updates, though some will require hardware changes too.

However, blockchains face unique implementation challenges that centralized systems don't encounter. Traditional organizations can mandate upgrades across their infrastructure, pushing updates through internal IT departments. Blockchain networks, by contrast, must coordinate changes across thousands of independent node operators, wallet providers, and users, all without central authority to enforce compliance. This coordination challenge becomes even more complex when considering dormant wallets, potentially lost private keys, and the philosophical tensions around whether networks should force upgrades or risk leaving vulnerable assets exposed.

While quantum computers pose a real future threat to current encryption, the cybersecurity community is actively preparing solutions. The transition will be gradual and planned for traditional systems, not a sudden crisis, though blockchain networks face unique coordination challenges in implementing these new standards across decentralized systems.

## Section II: Blockchain Vulnerability Assessment

The coordination challenges described above are compounded by a feature unique to blockchains: permanent public records. Every signature ever published on-chain becomes a potential attack surface once quantum computers mature. Traditional financial systems can rotate their encryption keys behind closed doors, but blockchain addresses with exposed public keys remain vulnerable forever unless protocol-level changes intervene. This section examines which blockchain assets face the greatest quantum risk, why some addresses are more vulnerable than others, and what users can do to protect themselves while developers work on network-wide solutions.

### Technical Foundation

Most blockchain networks secure transactions using digital signatures (the cryptographic foundation explained in Chapter I for Bitcoin and Chapter V for custody practices) that rely on mathematical problems classical computers cannot solve efficiently. The quantum threat to these systems comes in two forms, and it helps to think of them through analogy.

Shor's algorithm is like a master locksmith who can reverse-engineer any lock's blueprint from its face (the public key) and cut a matching key directly. This is catastrophic for the signature schemes that Bitcoin, Ethereum, and Solana use today. Once quantum computers are powerful enough to run Shor's algorithm at scale, they can derive private keys from public keys, breaking the fundamental security assumption of blockchain wallets.

**Grover's algorithm** resembles a superhuman librarian who must still search through library stacks, but can do so far more efficiently, effectively halving the security strength of hash functions. This is less devastating because the defense is straightforward: use longer hashes. One algorithm breaks mathematical structure entirely; the other just accelerates brute-force search.

### Public Key Exposure Models

Think of it like this: a Bitcoin address is like a safe whose combination (the public key) isn't revealed until someone opens it. Once the safe is opened, anyone listening can record the combination. Today's eavesdroppers can't use that combination to break into safes, but when quantum "lockpicks" arrive, they can replay those recorded combinations to steal whatever remains inside.

This analogy captures a fundamental principle: quantum computers can break public keys, but they cannot easily break the cryptographic hashes of those keys. This distinction determines which funds are at risk.

### Why Legacy Bitcoin Addresses Are More Vulnerable

Legacy Bitcoin addresses face significantly higher quantum risk for two concrete reasons. First is direct public key exposure through P2PK outputs. Early Bitcoin (2009-2012) frequently used P2PK (Pay-to-Public-Key) outputs that publish the public key directly on the blockchain with no cryptographic protection.

The transaction literally says "here's the public key, anyone who can prove they control it can spend this." Over 1.5 million BTC remain locked in these completely exposed P2PK outputs, including Satoshi's early mining rewards. This is like having a safe with the combination written on the outside. Quantum computers won't need to break any locks; they can simply read the combination and walk in.

The second vulnerability comes from address reuse patterns. Early Bitcoin users commonly reused the same address for multiple transactions, a practice that was later discouraged. Each time someone spends from an address, they expose its public key on the blockchain. With address reuse, the first spend reveals the public key, and any remaining balance tied to that key becomes fair game for a future quantum attacker. Many legacy users accumulated large balances on a single address over time, then only spent portions, leaving substantial "change" outputs sitting behind already-exposed public keys. In the public-key-exposure model, those change outputs are effectively pre-targeted for quantum harvest.

### Current Standards

Bitcoin address formats like P2PKH (Pay-to-Public-Key-Hash, available since 2009) and native SegWit (both covered in Chapter I) store a hash of the public key on the blockchain. The actual public key stays hidden until you spend your Bitcoin. When combined with the modern practice of using each address only once, this provides much stronger protection against quantum computers.

Unspent funds in these modern address formats are much more quantum-resilient because the public keys remain hidden. A quantum attacker would first need to crack the hash layer itself, which is much harder than attacking exposed public keys directly.

Using each address only once also reduces long-term risk. The public key is only revealed when you spend the funds. This leaves a window for an attacker to recover the key and redirect the spend before confirmation. The March 2026 estimate of roughly nine minutes on a hypothetical future quantum computer shows why single-use addresses are not a complete defense. Once the funds have moved to a fresh key, the old exposed key no longer controls them.

However, Taproot addresses (introduced in Chapter I) present a different exposure pattern. Every Taproot output embeds a tweaked public key from the moment it is created, whether it is later spent through the key path or script path. This places it in the exposed-key category. While Taproot currently holds a relatively small share of Bitcoin's total supply, users should be aware that these addresses don't provide the same quantum protection as hash-based alternatives.

Ethereum's account model (Chapter II) creates different exposure patterns. Every transaction from an EOA exposes a recoverable public key, but accounts that have never sent transactions remain protected. However, once an Ethereum address sends its first transaction, the public key is permanently exposed for any future deposits to that same address.

Smart contract wallets offer a possible upgrade path. Their authentication rules live in code, so an upgradeable wallet could adopt quantum-resistant signatures without changing its address. The obstacles are practical: the wallet must support that upgrade, and verifying the new signatures on Ethereum must become affordable. Flexibility today is not quantum protection today.

Multi-signature wallets (covered in Chapter V) present complex migration challenges, typically requiring all signers to coordinate simultaneous upgrades to post-quantum schemes. Social recovery mechanisms might provide alternative migration paths, though these require careful design to maintain security assumptions.

### Dormant and Potentially Lost Wallets

Dormant addresses with exposed public keys represent significant systemic risk to the broader ecosystem. These include early adopter addresses where the owners may have lost their private keys but already exposed their public keys through past spending activity. They also include abandoned mining addresses from Bitcoin's early era, particularly those used for early block rewards that were subsequently spent, exposing their public keys to future quantum harvest.

The fundamental challenge lies in distinguishing between genuinely lost funds and dormant but recoverable wallets. Quantum attackers could potentially recover funds from addresses presumed permanently lost: imagine the market chaos if millions of "lost" Bitcoin suddenly became recoverable, creating unexpected supply shocks and complex ownership disputes that could destabilize the entire ecosystem.

This creates a high-stakes scenario often described as a "**quantum rush**." Should a powerful quantum computer emerge suddenly, it would trigger a frantic race. Malicious actors would rush to crack susceptible addresses and steal exposed funds, while network developers and the community would race to deploy emergency forks to freeze or migrate those same assets. The outcome of such an event would depend heavily on who acts first, introducing a stark game-theoretic dynamic into the security model.

At current valuations, those at-risk BTC represent over $100 billion in exposed value, effectively creating a massive bounty for whoever achieves quantum supremacy first. This transforms quantum computing development from purely scientific pursuit into strategic competition. Nation-states and well-funded private entities now have a concrete financial incentive, beyond military or intelligence applications, to accelerate their quantum programs: whoever breaks the threshold first gains the ability to seize billions in abandoned or lost Bitcoin before the network can coordinate defensive forks. The race extends beyond who builds the computer to who can extract maximum value before the window closes.

### Best Practices

To protect against future quantum computing threats, users should adopt careful key management practices. For Ethereum, avoid keeping large amounts of funds in an address after its first transaction, since any on-chain signature reveals the public key to potential quantum attacks. Instead, migrate to a fresh, unused address or preferably a smart contract wallet that can be upgraded to post-quantum cryptographic schemes.

Bitcoin users should similarly avoid address reuse by spending entire UTXOs to fresh addresses, ensuring no value remains tied to previously exposed public keys. While multisig and multi-party computation solutions offer enhanced security today, they don't eliminate quantum risk if the underlying signature scheme remains vulnerable. Their primary value lies in providing an upgrade path to post-quantum algorithms when they become available.

### The Protocol-Level Challenge

While individual users can adopt protective practices, the exposure patterns detailed above reveal a fundamental limitation: personal key management cannot protect the ecosystem as a whole. The massive amount of Bitcoin sitting in exposed legacy outputs, the countless reused addresses from Bitcoin's early days, and Ethereum's account model exposure all require coordinated protocol-level responses.

No amount of individual vigilance can secure funds whose public keys are already permanently visible on-chain, nor can it prevent the systemic chaos of a potential quantum rush. This reality has driven blockchain developers to move beyond user education toward concrete technical proposals for network-wide quantum resistance. The question is no longer whether blockchains need protocol changes, but rather how to implement them without breaking existing functionality or creating unacceptable economic disruption.

## Section III: Quantum-Resistance Transition

Having established the threat landscape and vulnerability patterns, we now turn to how major blockchain networks are responding. Each network faces unique architectural constraints and governance challenges that shape their migration strategies. Bitcoin must balance immutability with security upgrades, while Ethereum leverages its more flexible upgrade culture. The technical solutions exist, but implementing them requires navigating complex social coordination problems that test the limits of decentralized governance.

### Bitcoin's Approach

The Bitcoin developer community is actively working on concrete plans to protect the network against future quantum threats, with several serious proposals now under review. The vulnerable legacy outputs discussed in Section II, including coins from Bitcoin's earliest days, represent a disproportionately large amount of value concentrated in a small number of exposed transactions.

One prominent draft, **BIP-360**, proposes Pay-to-Merkle-Root (P2MR). It removes Taproot's exposed key-path spending option while keeping a script-based path. That would deny attackers a permanently visible public key to work on, but it would not stop a fast attack once spending reveals a vulnerable key. Post-quantum signatures would still be needed. P2MR has not been activated.

The core challenge is also social and economic: should Bitcoin force users to migrate, or make it optional? Draft BIP-361 proposes phased restrictions after quantum-resistant outputs become available, with legacy spends eventually requiring quantum-safe rescue proofs after roughly five years. Which old outputs could be rescued remains unresolved, and the proposal is not activated. More aggressive deadlines risk stranding dormant funds, while voluntary migration leaves exposed coins available to a future quantum attacker.

The debate intensifies when considering what should happen to dormant holdings that can't or won't be moved before quantum computers arrive. Some propose permanently burning the at-risk assets to prevent quantum seizure. Others suggest doing nothing and allowing quantum-equipped actors to claim abandoned coins, treating it as a kind of digital salvage. A third approach would allow vulnerable coins to be claimed but impose transaction limits that slow the drainage process, creating competition among would-be claimants and driving fees to miners rather than letting the value be easily extracted.

Each option faces significant philosophical resistance within the Bitcoin community. The ethos strongly opposes burning holdings that are rightfully owned, even if the owner is presumed dead or absent. The principle of immutable property rights runs deep in Bitcoin culture; many view Satoshi-era holdings as legitimately belonging to their original owners, and any protocol change that makes them unspendable, whether through burning or redistribution, violates the fundamental promise that "your keys, your coins" means permanent ownership. This creates a painful tension: protecting the network from quantum attack may require violating the very property rights that make Bitcoin valuable in the first place.

Ultimately, for truly lost or abandoned assets where private keys are genuinely gone, developers face this difficult choice: either these funds will be stolen by whoever possesses quantum computing capabilities first, or they will become unspendable through protective consensus changes. While Satoshi himself discussed in 2010 the need to adopt a new cryptographically sound system in response to a cryptographic break, this solution only works for those who still control their private keys. No consensus has emerged on timelines or enforcement, but Bitcoin Optech continues tracking these debates as they evolve from early concepts toward potential consensus rules.

### Ethereum's Approach

Unlike Bitcoin's philosophical tensions around property rights and coin burning, Ethereum faces primarily technical engineering trade-offs. The community's more flexible upgrade culture allows for iterative solutions, though the practical obstacles remain substantial. The signature schemes currently used by both user accounts and validators would be susceptible to the attacks discussed earlier.

The Ethereum Foundation's September 2026 roadmap targets post-quantum security across execution, consensus, and data availability by December 2029, with a minimal fallback path if the full design takes longer. Account Abstraction is a key route for migrating user signatures, including proposals for native support. These are development targets and proposals, not protections already deployed across Ethereum.

However, these new algorithms come with significant practical trade-offs. The most immediate challenge is the dramatic increase in data size. A current Ethereum signature is just 65 bytes. Falcon-512 signatures are about 666 bytes, already ten times as large. Other quantum-resistant schemes require tens of thousands of bytes.

These size increases directly impact blockchain operation in multiple ways. Transactions become larger, leading to increased storage requirements and blockchain bloat. Higher transaction fees follow naturally from the increased data that must be processed and stored. Slower verification times can also affect block processing and network throughput, presenting a major engineering hurdle for protocol developers who must balance security against usability.

Beyond user accounts, researchers are exploring alternatives for Ethereum's broader architectural foundations. The cryptographic techniques used for data availability, like KZG commitments discussed in Chapter II, also need quantum-resistant replacements. Hash-based and STARK-style constructions are promising candidates because they only face Grover's more manageable speedup rather than Shor's devastating advantage. The roadmap must coordinate these replacements with validator signatures and account migration; emergency recovery proposals remain a fallback rather than a substitute for that work.

### Solana’s Approach

Solana faces a more immediate exposure concern: most Solana account addresses directly reveal the public key from the moment they are created, unlike Bitcoin or Ethereum where the public key can remain hidden until a transaction is made. This means every Solana address is already visible to potential future quantum attackers. Following a December 2025 testnet prototype, Anza and Firedancer reported Falcon signature implementations in April 2026. The proposed migration starts with new quantum-resistant wallets before addressing existing accounts; it is not yet a network-wide mainnet upgrade.

The implementation work focuses on testing how quantum-resistant signatures would affect throughput, compute costs, and fees if adopted broadly. Meanwhile, Solana's ecosystem has experimented with opt-in wallet-level protections using hash-based one-time signatures for users who want extra security now. This approach is useful as a stopgap, but does not complete the planned network-wide migration.
