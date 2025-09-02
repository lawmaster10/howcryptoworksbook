# Part I: Bitcoin Fundamentals

*This section establishes the foundational concepts of Bitcoin, exploring its revolutionary approach to digital money, consensus mechanisms, and the philosophical principles that underpin the world's first successful cryptocurrency.*

## Chapter 1: Bitcoin Core Concepts

### Genesis and Philosophy

Bitcoin's creation was a direct response to the 2008 global financial crisis. On January 3rd, 2009, its anonymous creator, Satoshi Nakamoto, embedded a newspaper headline into the very first block, known as the genesis block. The headline—*The Times*, "Chancellor on brink of second bailout for banks"—serves as a permanent critique of a traditional financial system dependent on centralized control.

This act highlights Bitcoin's mission: to be an alternative to the traditional banking system. Its philosophy is rooted in the cypherpunk belief in using strong cryptography to achieve individual sovereignty over one's finances. To accomplish this, Bitcoin operates as a peer-to-peer electronic cash system without trusted third parties. Its monetary policy is predictable and enforced by code, featuring a fixed, immutable supply cap of 21 million BTC. This creates digital scarcity, standing in stark contrast to fiat currencies that central banks can print at will.

### Consensus and Chain Selection

For a decentralized network to agree on the true history of transactions, it needs a robust consensus mechanism. Bitcoin uses **Nakamoto Consensus**, which is often simplified as the "longest chain rule" but is more accurately described as the "heaviest chain rule." The canonical chain is the one with the most accumulated computational work (chainwork) invested in it, not necessarily the one with the most blocks. (Difficulty relates to the target via difficulty ≈ target₀/target; chainwork sums per-block work across the chain.)

Think of finding a block as a lottery; chainwork is the total sum of "lottery tickets" (hashes) required to build the entire chain, a value calculated from the difficulty target (nBits) of each block. A shorter chain could have a higher cumulative difficulty, making it the valid one. This prevents an attacker from overwriting history with a long but easy-to-produce chain, as the sheer energy invested in the honest chain makes it prohibitively expensive to overcome.

### Mining and Proof-of-Work

Mining is the process that secures the network and creates new bitcoins through **Proof-of-Work**. Miners compete to solve a cryptographic puzzle by bundling transactions into a block and repeatedly hashing the block header using the double SHA-256 algorithm. The goal is to find a hash value below a specific target.

To do this, miners primarily vary a field in the header called the **nonce**, a 32-bit number offering about 4 billion guesses. When those are exhausted, miners can alter the **extranonce** within the coinbase transaction, which changes the block's Merkle root and provides a new range of hashes to test. To keep the average block time at approximately 10 minutes, the network performs a **difficulty retarget** every 2,016 blocks (about two weeks). If blocks are found too quickly, the difficulty increases; if too slowly, it decreases.

Most hashpower is coordinated through mining pools using specialized ASIC hardware. Pools distribute work via the **Stratum protocol** (v2 improves security and job negotiation). Stale blocks and short-lived chain reorganizations are normal; confidence increases with confirmation depth.

### Monetary Policy

Bitcoin has a predictable, algorithmic monetary policy with a fixed issuance schedule. The **block reward**, or subsidy, is cut in half every 210,000 blocks, an event known as the **"halving"** that occurs roughly every four years. The subsidy began at 50 BTC and has since been reduced to 25, 12.5, 6.25, and most recently to 3.125 BTC after the 2024 halving.

This mechanism makes Bitcoin a **disinflationary asset**, as its inflation rate trends toward zero. Around the year 2140, the subsidy will cease, and miners will be compensated solely by transaction fees. This predictable scarcity is a cornerstone of Bitcoin's value proposition as a store of value, though scarcity alone doesn't guarantee price appreciation—that requires sustained demand to accompany the diminishing supply.

Due to integer rounding in halvings, the terminal supply converges to ~20,999,999.9769 BTC. Over time, miner security budgets shift from subsidy to fees, making a healthy fee market important for long-term incentives.

---

## Chapter 2: Bitcoin Technical Architecture

### UTXO Model

Bitcoin uses an **Unspent Transaction Output (UTXO) model** rather than an account-based system like a traditional bank. Instead of a single balance, a user's wallet holds a collection of UTXOs, which are like individual digital coins of varying amounts. When a user sends bitcoin, their wallet selects UTXOs as inputs, consumes them, and creates new UTXOs as outputs—one for the recipient and another as "change" back to the sender.

This model enhances privacy by encouraging the use of new addresses for change outputs and offers potential scalability benefits by allowing parallel transaction processing. Full nodes are responsible for tracking the entire network's **UTXO set**, which is the complete collection of all spendable outputs available for future transactions.

**Bitcoin Script** locks and unlocks UTXOs with a simple, stack-based language (e.g., P2PKH, P2WPKH, P2TR). **Timelocks** (nLockTime, nSequence/CSV) and CLTV enable contracts like Lightning channels, vaults, and escrow. [BIP65/68/112/113]

### Transaction Structure and Prioritization

A Bitcoin transaction consists of **inputs** (the UTXOs being spent) and **outputs** (the new UTXOs being created). Once broadcast, a transaction enters the **mempool**, a waiting area for unconfirmed transactions. Miners select transactions from the mempool to build the next block.

Because block space is limited, an economic, incentive-based **fee market** emerges for transaction ordering. Miners prioritize transactions based on the highest **fee rate**, measured in satoshis per vbyte (sats/vB; a satoshi is the smallest unit of bitcoin—1 BTC = 100,000,000 satoshis, often shortened to "sats"). A high fee rate makes a transaction more likely to be included in the next block, ensuring block space is allocated to those who value it most.

Users can fee-bump with **Child-Pays-for-Parent (CPFP)**. Ongoing policy work on package relay improves relay of related transactions to make fee-bumping more reliable.

### Address Types and Formats

Bitcoin addresses have evolved to improve efficiency and enable new features. The primary types include:

- **P2PKH (Legacy)**: start with `1`
- **P2SH**: start with `3` (multi-sig or nested SegWit: P2SH-P2WPKH/P2WSH)
- **Native SegWit (Bech32/Bech32m)**:
  - Bech32 `bc1q` (v0: P2WPKH/P2WSH)
  - Bech32m `bc1p` (v1: Taproot/P2TR)

Wallets standardize address derivation using BIP32/39/44 and output descriptors; avoid address reuse to protect privacy.

---

## Chapter 3: Bitcoin Upgrades and Scaling

### Segregated Witness (SegWit)

Activated in 2017, **Segregated Witness (SegWit)** was a landmark upgrade implemented as a backward-compatible soft fork. Its primary achievement was fixing **transaction malleability**, a bug that allowed a third party to alter a transaction's signature and change its ID (TXID) before confirmation.

SegWit solved this by removing the witness (signature) data from the part of the transaction used to calculate the TXID and moving it to a separate structure. This also introduced the concept of **block weight**, replacing the 1MB size limit with a 4,000,000 weight unit maximum. This change effectively increased block capacity and incentivized the adoption of SegWit addresses. Weight = base_bytes×4 + witness_bytes; vbytes = weight/4. Fee (sats) = fee_rate (sats/vB) × vbytes.

Weight discounts witness bytes by 75% (1 WU per witness byte vs 4 WU per non-witness byte). Fees are commonly quoted in **virtual bytes (vB)**, where 1 vB = 4 weight units.

### Soft Forks

A **soft fork** is a backward-compatible protocol upgrade that works by tightening the consensus rules. Because new rules are a subset of the old ones, non-upgraded nodes still see new blocks as valid; they simply don't enforce the stricter rules themselves. This allows the network to upgrade without splitting. An early example was the disabling of the OP_CAT opcode in 2010 to mitigate a potential denial-of-service vulnerability.

Common activation methods include **BIP9 version bits**, **Speedy Trial**, and **user-activated soft forks (UASF)**.

Even with backward compatibility, getting any soft fork into Bitcoin is intentionally hard. Many maintainers and long‑time contributors prioritize simplicity and protocol ossification, viewing change—even small, well‑scoped changes—as sources of implementation and game‑theoretic uncertainty. As a result, proposals undergo lengthy review, testing, and community consensus‑building, and nearly every soft‑fork discussion (including SegWit, Taproot, and newer covenant designs) has sparked controversy over activation methods, safety assumptions, and long‑term precedent.

### Replace-by-Fee and Standards

**Replace-by-Fee (RBF)** is a feature that allows users to increase the fee on an unconfirmed transaction. Defined in BIP-125, **opt-in RBF** lets a sender mark a transaction as replaceable, giving them the option to rebroadcast it with a higher fee to ensure faster confirmation during network congestion.

Another network feature is the **OP_RETURN opcode**, which allows users to embed a small amount of arbitrary data in a transaction. Bitcoin Core v30 removes the historical 80-byte relay cap; default policy allows OP_RETURN outputs up to nearly 4 MB, though peers/miners may set tighter limits. This is policy, not consensus, and behavior can vary by node and over time.

Policy differs across nodes/miners; some run full-RBF, so replacement behavior can vary by peer and over time.

### Taproot and Advanced Features

The **Taproot upgrade**, activated in 2021, significantly improved privacy, efficiency, and smart contract capabilities. It combines two key technologies:

1. **Schnorr Signatures**: These allow for key and signature aggregation through schemes like MuSig2, enabling complex multi-party transactions to be represented by a single signature on-chain.

2. **Merkleized Abstract Syntax Trees (MAST)**: This allows complex spending conditions to be structured in a way that only the condition that is met needs to be revealed.

Together, these features make complex transactions indistinguishable from simple payments, providing a major boost to privacy and scalability.

On a related note, public companies have increasingly adopted Bitcoin as a treasury asset, led by MicroStrategy (MSTR), which holds the most BTC of any publicly traded firm.

Taproot supports **key-path** (single-sig) and **script-path** spends under **Tapscript**, and introduced **SIGHASH_DEFAULT** for simpler signature hashing. [BIP340/341/342]

---

## Chapter 4: Bitcoin Layer 2 and Extensions

### Lightning Network

The **Lightning Network** is a Layer 2 protocol designed for instant, low-cost Bitcoin payments. It functions by creating off-chain payment channels between users. To open a channel, two parties lock funds in an on-chain 2-of-2 P2WSH multisig output (SegWit v0).

Once the channel is established, the parties can transact an unlimited number of times by updating their channel's balance sheet off-chain. All state changes require mutual agreement and are secured by cryptography. When they are finished, they can close the channel by broadcasting the final state to the Bitcoin blockchain. The network can also route payments across multiple interconnected channels.

Lightning uses **HTLCs** and **onion routing** for private, trust-minimized payments; **watchtowers** help penalize cheating. Channel liquidity is directional (inbound vs outbound) and affects routing success; rebalancing and swap services help manage liquidity for reliable routing.

---

## Chapter 5: Bitcoin Network Operations and Security Model

### Roles at a Glance

**Users/wallets** create and sign transactions, then broadcast them to the network (you can do this without running your own node). **Full nodes** independently validate and relay transactions and blocks, enforcing consensus rules for themselves (running a node is not the same as mining). **Miners** assemble validated transactions into candidate blocks and perform Proof‑of‑Work to win block production (miners typically run a full node, but mining is the energy‑intensive block creation role).

### Node Types and Network Topology

The Bitcoin network is a decentralized system composed of different participants:

- **Full nodes** form the network's backbone, storing the complete blockchain and independently validating all transactions and blocks against consensus rules.
- **Pruned nodes** offer the same validation security but discard old block data to save disk space.
- **SPV (Simplified Payment Verification) clients**, common in mobile wallets, download only block headers and trust full nodes for transaction validation.

To maintain its decentralized topology, the network relies on **DNS seeds** and peer-to-peer exchange for discovering other nodes.

### Block Propagation and Network Synchronization

When a new node joins, it performs an **Initial Block Download (IBD)** to sync the entire blockchain from its peers. To ensure new blocks propagate quickly and efficiently, the network uses optimized protocols like **Compact Block Relay**, which minimizes bandwidth by only sending information that nodes don't already have. Nodes also engage in **mempool synchronization** to share unconfirmed transactions. The network is resilient to partitions (temporary splits), which self-heal once connectivity is restored.

Additional efforts like **FIBRE** (fast relay) and **Erlay** (proposed mempool gossip reduction) improve propagation latency and bandwidth efficiency.

### Attack Vectors and Economic Security

Bitcoin's security is economic and probabilistic. The most cited threat is a **51% attack**, where an entity controlling a majority of the network's hashpower could attempt to rewrite history. However, the immense cost of acquiring and running this hardware, combined with the fact that a successful attack would devalue the asset, makes it economically irrational.

Security is achieved through **confirmation depth**; each subsequent block exponentially increases the work required to alter a transaction. This leads to **probabilistic finality**, where after a certain number of confirmations (e.g., six), a transaction is considered irreversible. The system is designed so that economic incentives strongly reward miners for honest behavior.

Other threats include **eclipse attacks** (peer isolation) and **selfish mining**; diversity of peers, network-level protections, and monitoring help mitigate these risks.

### Key Management and Wallet Security

The foundational principle of self-custody is **"Not your keys, not your coins."** Securely managing private keys is paramount:

- **Hierarchical Deterministic (HD) wallets** generate a nearly infinite number of addresses from a single backup seed phrase.
- **Multi-signature wallets** require multiple keys to authorize a transaction, distributing trust and securing funds.
- **Hardware wallets** provide the highest level of security by keeping private keys completely offline, isolated from internet-connected devices.

### Privacy Model and Chain Analysis

Bitcoin is **pseudonymous**, not anonymous. While addresses are not directly linked to real-world identities, transaction graph analysis can be used to cluster addresses and track the flow of funds. This risk is significantly increased by address reuse. Furthermore, **KYC/AML** (Know Your Customer/Anti-Money Laundering) regulations at exchanges create links between on-chain activity and real-world identities, creating privacy gaps.

Common privacy practices include avoiding address reuse, using coin control, and optionally leveraging **CoinJoin-style tools** to reduce heuristic linking.

### Network Economics and Fee Markets

The competition for Bitcoin's limited block space creates a **fee market**. During periods of high demand, users bid for inclusion in the next block, driving up transaction fees. This market mechanism is crucial for the network's long-term sustainability, as fee revenue is expected to replace the diminishing block subsidy as the primary incentive for miners. Mining economics are a dynamic balance between electricity costs, hardware efficiency, and the value of block rewards and fees. For transaction prioritization, fee rates, and fee-bumping mechanics, see Chapter 3 "Transaction Structure and Prioritization."

### Network Resilience and Antifragility

Bitcoin is designed to be **antifragile**—it grows stronger from stress and attacks. Its resilience stems from several factors:

- Geographic distribution of nodes and miners resists localized disruptions.
- **Protocol ossification**, or resistance to change, enhances stability and predictability.
- Its design assumes an adversarial environment, built to function despite malicious actors.

The network has survived numerous technical, political, and economic challenges, demonstrating its robust and self-healing nature.

### Bitcoin Inscriptions and Ordinals

**Ordinal Theory** is a social convention that assigns a unique serial number to every satoshi, allowing individual sats to be tracked and transferred. **Inscriptions** use this method to embed arbitrary data, like images or text, into the witness portion of a Bitcoin transaction.

This process became practical thanks to two soft forks: SegWit, which provided a block space discount for witness data, and Taproot, which enabled more flexible and larger script paths.

**BRC-20 tokens** are an experimental standard built on this technology, using JSON text inscriptions to signal "deploy," "mint," and "transfer" functions. An important limitation is that BRC-20s have no native token logic in consensus. Their state is not enforced by the Bitcoin protocol itself but is tracked by off-chain indexers that interpret the inscribed data.

Relay and mining policies for large inscriptions can vary, affecting inclusion and propagation.

## Key Takeaways
- Bitcoin targets self-sovereign money with a fixed 21M cap and disinflationary issuance via halvings.
- Consensus follows the heaviest-work chain; PoW security relies on economic cost and confirmation depth.
- The UTXO model, Script, and timelocks enable simple contracts; fee markets prioritize by sats/vB.
- SegWit fixed malleability and introduced block weight; Taproot (Schnorr + MAST) boosts privacy/efficiency.
- Lightning enables instant, low-fee payments through off-chain channels secured by on-chain enforcement.
- Security is probabilistic; threats include 51% and eclipse attacks, mitigated by decentralization and incentives.
- Address evolution (P2PKH → SegWit → Taproot) improves efficiency; avoid reuse to preserve privacy.
- Fees will increasingly replace subsidy; a healthy fee market is critical for long-term miner incentives.
- Ordinals/inscriptions use witness space; BRC-20s are indexer-defined, not enforced by consensus.
