# Chapter I: Bitcoin Fundamentals

## Section I: Bitcoin Core Concepts

### Genesis and Philosophy

Bitcoin's creation was a direct response to the 2008 global financial crisis. On January 3rd, 2009, its anonymous creator, Satoshi Nakamoto, embedded a newspaper headline into the very first block, known as the genesis block. The headline—*The Times*, "Chancellor on brink of second bailout for banks"—serves as a permanent critique of a traditional financial system dependent on centralized control.

This act highlights Bitcoin's mission: to be an alternative to the traditional banking system. Its philosophy is rooted in the cypherpunk belief in using strong cryptography to achieve individual sovereignty over one's finances. To accomplish this, Bitcoin operates as a peer-to-peer electronic cash system without trusted third parties. Its monetary policy is predictable and enforced by code, featuring a fixed, immutable supply cap of 21 million BTC. This creates digital scarcity, standing in stark contrast to fiat currencies that central banks can print at will.

But creating a decentralized alternative to traditional banking raises a fundamental challenge: how do you get thousands of computers around the world to agree on who owns what, without a central authority to settle disputes?

### Consensus and Chain Selection 

Bitcoin solves this through a robust consensus mechanism. Bitcoin uses **Nakamoto Consensus**, which is often simplified as the "longest chain rule" but is more accurately described as the "heaviest chain rule." The canonical chain is the one with the most accumulated computational work invested in it, not necessarily the one with the most blocks.

Imagine two climbers racing to the summit on different routes. One takes 1,000 easy steps up a gentle trail; the other takes 600 steps up a steep face where each step is worth more points because it's harder. The judges don't count steps; they total points. That's chainwork: nodes sum per-block work (from each block's nBits) and choose the chain with the most total work—even if it has fewer blocks. This prevents an attacker from overwriting history with a long but easy-to-produce chain, as the sheer energy invested in the honest chain makes it prohibitively expensive to overcome.

**Full nodes enforce validity rules; hash rate does not.** Miners assemble blocks and add Proof-of-Work (PoW), but each node independently accepts a block only if it follows the node's rules (supply cap, signature/script validity, etc.). PoW provides Sybil-resistance and serves as a tie-breaker among chains that already pass validation on that node. Invalid blocks are rejected regardless of how much hash rate produced them.

### Mining and Proof-of-Work

What if you needed to prove you'd done a lot of work, but couldn't trust anyone to verify it? Bitcoin solves this through **Proof-of-Work**—a system where miners compete to solve cryptographic puzzles that require enormous computational effort but can be instantly verified by anyone.

Here's how it works: Miners bundle transactions into a block and repeatedly hash the block header using the double SHA-256 algorithm. They're searching for a hash value below a specific target—like rolling dice until you get a number lower than a certain threshold, except they're "rolling" trillions of times per second.

To do this, miners primarily vary a field in the header called the **nonce**, a 32-bit number offering about 4 billion guesses. When those are exhausted, miners can alter the **extranonce** within the coinbase transaction, which changes the block's Merkle root and provides a new range of hashes to test. To keep the average block time at approximately 10 minutes, the network performs a **difficulty retarget** every 2,016 blocks (about two weeks). If blocks are found too quickly, the difficulty increases; if too slowly, it decreases.

Most hashpower is coordinated through mining pools using specialized ASIC hardware. Pools distribute work via the **Stratum protocol** (v2 improves security and job negotiation). Stale blocks and short-lived chain reorganizations are normal; confidence increases with confirmation depth.

### Monetary Policy

Bitcoin has a predictable, algorithmic monetary policy with a fixed issuance schedule. The **block reward**, or subsidy, is cut in half every 210,000 blocks, an event known as the **"halving"** that occurs roughly every four years. The subsidy began at 50 BTC and has since been reduced to 25, 12.5, 6.25, and most recently to 3.125 BTC after the 2024 halving.

This mechanism makes Bitcoin a **disinflationary asset**, as its inflation rate trends toward zero. Around the year 2140, the subsidy will cease, and miners will be compensated solely by transaction fees. This predictable scarcity is a cornerstone of Bitcoin's value proposition as a store of value, though scarcity alone doesn't guarantee price appreciation—that requires sustained demand to accompany the diminishing supply.

Due to integer rounding in halvings, the terminal supply converges to ~20,999,999.9769 BTC. Over time, miner security budgets shift from subsidy to fees, making a healthy fee market important for long-term incentives.

## Section II: Bitcoin Technical Architecture

### UTXO Model

How do you track ownership in a system without accounts? Bitcoin takes a radically different approach from traditional banking by using an **Unspent Transaction Output (UTXO) model**.

Think of it like physical cash in your wallet. Instead of having a single account balance, you have individual bills of different denominations—a $20, two $5s, and some $1s. When you buy something for $7, you might use a $5 and two $1s, getting back change if needed.

Bitcoin works similarly. Instead of a single balance, your wallet holds a collection of UTXOs—individual digital "coins" of varying amounts. When you send bitcoin, your wallet selects UTXOs as inputs, consumes them entirely, and creates new UTXOs as outputs: one for the recipient and another as "change" back to you.

Full nodes are responsible for tracking the entire network's **UTXO set**, which is the complete collection of all spendable outputs available for future transactions.

**Bitcoin Script** is a simple programming language that locks and unlocks UTXOs using different address types. **Timelocks** allow transactions to be delayed until a specific time or block height, enabling more complex contracts like Lightning channels, vaults, and escrow arrangements.

### Transaction Structure and Prioritization

Once you understand how UTXOs work, the next question is: how do transactions actually get processed? A Bitcoin transaction consists of **inputs** (the UTXOs being spent) and **outputs** (the new UTXOs being created). Once broadcast, transactions enter the **mempool**—think of it as a waiting room for unconfirmed transactions.

Here's where economics comes into play. Since each block has limited space, miners must choose which transactions to include. They naturally prioritize transactions that pay the highest **fee rate**, measured in satoshis per virtual byte (sats/vB). A satoshi is the smallest unit of bitcoin—there are 100 million satoshis in one bitcoin.

This creates a **fee market** where users essentially bid for block space. Need your transaction confirmed quickly during network congestion? Pay a higher fee rate. Can wait? Pay less and wait for a quieter period.

---

## Section III: Bitcoin Upgrades and Scaling

### Understanding Fork Types

How do you upgrade a decentralized network where no one's in charge? Bitcoin has two main upgrade mechanisms that allow the protocol to evolve while maintaining consensus.

#### Soft Forks

**Soft forks** are backward-compatible protocol upgrades that tighten consensus rules without breaking the network. Think of it like adding a new traffic law—if the speed limit changes from 65 mph to 55 mph, older cars that don't know about the change can still drive on the road, they just might unknowingly break the new rule. Non-upgraded Bitcoin nodes still see new blocks as valid but don't enforce the stricter rules themselves, allowing the network to upgrade without splitting into incompatible versions. They require majority support to avoid chain splits, with examples including SegWit, Taproot, and the disabling of OP_CAT.

#### Hard Forks

**Hard forks** are incompatible upgrades that loosen or change consensus rules. All nodes must upgrade or they'll be left on a separate chain. Hard forks are extremely rare in Bitcoin due to coordination challenges and the risk of permanent network splits.

#### Activation Mechanisms

**Miner Activated Soft Forks (MASF)** rely on hash power signaling—miners indicate readiness by including version bits in block headers. Once a threshold (typically 95%) is reached, the soft fork activates. This was used for upgrades like SegWit (eventually) and most historical soft forks.

**User Activated Soft Forks (UASF)** represent an alternative where economic nodes coordinate a "flag day" to start enforcing tighter rules—potentially regardless of miner signaling. If enough economic nodes and service providers participate, miners face a simple incentive: follow the new rules to get paid, or mine a chain most users won't accept.

**Speedy Trial** combines both approaches with a shorter signaling window and lower activation threshold, followed by a mandatory activation date. This method was successfully used for Taproot activation in 2021.

#### The Challenge of Change

Despite backward compatibility, getting any soft fork into Bitcoin is intentionally difficult. Many developers prioritize **protocol ossification**—the idea that Bitcoin should become increasingly resistant to change as it matures. This conservative approach means proposals undergo years of review, testing, and community debate.

### Bitcoin's Major Upgrades

#### Early Soft Forks (2010-2012)

Bitcoin's earliest soft forks focused on security improvements. The **OP_CAT removal in 2010** disabled the OP_CAT opcode to prevent potential denial-of-service attacks. Various other opcode restrictions were implemented during this period to tighten script validation and improve overall security.

#### Segregated Witness - SegWit (2017)

The **SegWit activation saga** represents one of the most important case studies in Bitcoin's governance, demonstrating how protocol upgrades work—and sometimes don't work—in a truly decentralized system.

SegWit was a landmark upgrade that solved multiple critical issues. Before SegWit, Bitcoin had a critical bug: third parties could alter a transaction's signature and change its ID (TXID) before confirmation, without affecting the transaction's validity. This **transaction malleability** made it risky to build dependent transactions or second-layer protocols like Lightning.

SegWit moved signature data to a separate "witness" structure, making transaction IDs immutable once created. It also introduced **block weight**—a new measurement system with a 4,000,000 weight unit maximum instead of a simple 1MB limit. This effectively increased block capacity while incentivizing adoption of more efficient SegWit addresses. The weight system counts witness data as one-quarter for weight calculation (commonly described as a "75% discount"), creating a backwards-compatible blocksize increase.

To understand the political dynamics, it's helpful to think of pre-SegWit Bitcoin as **"Bitcoin 1.0"**—a system with a hard 1MB blocksize limit and transaction malleability issues. **SegWit represented "Bitcoin 1.1"**—mostly backwards compatible with Bitcoin 1.0, but fixing protocol bugs and enabling second-layer networks while providing a one-time capacity increase.

The original activation mechanism used BIP 9 with a 95% threshold: during any 2,016-block difficulty adjustment period within the window from November 15, 2016 to November 15, 2017 (UTC), if 95% or more of mined blocks signaled SegWit readiness, the upgrade would lock in. After a grace period, SegWit would activate and the network would accept the new transaction types.

However, some large miners withheld signaling, treating "SegWit Readiness" signaling as a "SegWit Willingness" indicator instead. Despite years of development work by Core developers and third-party services, and support from many economic nodes, these miners were blocking activation by refusing to signal—not because of technical concerns, but as political leverage in the broader "blocksize wars."

This created an unprecedented situation: many participants in the Bitcoin ecosystem supported an upgrade they believed would benefit the network, but a group of miners could indefinitely block progress through coordinated non-signaling.

**BIP 148** represented a proposed solution to this governance deadlock. BIP 148 **changed consensus rules for participating nodes by rejecting any non-signaling (bit-1) blocks after August 1st, 2017**. While it leveraged the existing BIP 141 deployment, this "reject non-signaling blocks" rule was new and could have caused a chain split if not widely adopted.

The mechanism was straightforward: **BIP 148 nodes would reject any block that failed to signal SegWit support after the flag day**. This created economic pressure by making non-signaling blocks invalid for BIP 148 nodes, potentially forcing miners to choose between signaling support or mining a chain that some economic actors would reject.

If enough economic nodes (exchanges, services, businesses) ran BIP 148, miners faced a stark choice: signal SegWit support and get paid in bitcoin that the broader economy would accept, or mine a chain that major economic actors would ignore.

The threat of BIP 148 created powerful economic incentives that ultimately resolved the impasse:

- **BIP 91**: Locked in July 21, 2017 → Activated July 23, 2017 (enforced that miners signal bit-1, enabling BIP 141 to reach its threshold)
- **BIP 148 (UASF)**: Planned August 1, 2017 flag day to reject non-SegWit-signaling blocks  
- **SegWit (BIP 141)**: Locked in August 9, 2017 → Activated August 24, 2017 (block 481,824)

Faced with the credible threat that many economic nodes would enforce SegWit activation regardless of miner preferences, the miners began signaling support. BIP 91 was deployed as an intermediate solution that allowed miners to signal SegWit support before the August 1st UASF deadline.

The SegWit activation demonstrates several crucial principles:

1. **Economic nodes can influence protocol rules** when there's sufficient coordination. Miners must produce blocks that the economic majority will accept and value.

2. **Soft forks can be enforced by users** when there's sufficient economic coordination, even against miner resistance.

3. **Credible threats matter more than actual deployment**. BIP 148 succeeded largely because the threat was believable, not because a majority of nodes actually ran it.

4. **Bitcoin's governance is antifragile**. The system found a way to route around the blockade and activate beneficial upgrades despite coordinated resistance.

While SegWit technically activated via the original miner signaling mechanism (BIP 141), the credible UASF threat (BIP 148) was a significant catalyst that helped resolve the impasse. This demonstrated that Bitcoin users and economic nodes can coordinate to influence protocol governance, even when facing miner resistance.

#### Taproot (2021)

The **Taproot upgrade** significantly improved privacy, efficiency, and smart contract capabilities by combining two key technologies. **Schnorr Signatures** enable key and signature aggregation through schemes like MuSig2, allowing complex multi-party transactions to appear as single signatures on-chain. **Merkleized Abstract Syntax Trees (MAST)** structure complex spending conditions efficiently, where only the condition that's met needs to be revealed.

Together, these features provide major benefits: complex transactions become indistinguishable from simple payments for key-path spends, delivering significant privacy and scalability improvements. When script-path spends are used, only the revealed branch is disclosed, maintaining privacy for unused conditions.

### Network Standards and Features

#### Child-Pays-for-Parent (CPFP)
Create a new child transaction that spends an output from the stuck parent with a high fee rate, so miners include the package (parent + child) because the combined/ancestor feerate is attractive. Use CPFP when you can’t (or don’t want to) replace the parent but control one of its outputs (sender’s change or the recipient’s output).

#### Replace-by-Fee (RBF)
Sender rebroadcasts a higher-fee replacement of an unconfirmed transaction. Opt-in RBF is defined by BIP-125 (wallets signal replaceability); some nodes also run full-RBF (via mempoolfullrbf), which accepts replacements regardless of opt-in. Use RBF when you control the original tx and it can be replaced.

RBF is a sender-driven replacement while CPFP is a child-driven package mining. Either party with a spendable output can do CPFP. They’re compatible and can be used together if needed.

#### OP_RETURN Data Embedding
The **OP_RETURN opcode** allows embedding small amounts of arbitrary data in transactions. As of Bitcoin Core v30 (2025), the historical 80-byte relay cap has been removed, allowing OP_RETURN outputs up to nearly 4 MB by default (policy, not consensus; operator policies vary).

### Address Types and Formats

Bitcoin addresses have evolved to improve efficiency and enable new features: Legacy (starts with 1) is the oldest and works everywhere but typically incurs slightly higher fees; P2SH (starts with 3) is a broad compatibility wrapper often used for multisig or older SegWit, and addresses starting with 3 are not necessarily multisig; Native SegWit (starts with bc1q) is the modern default with lower fees and all‑lowercase safety; and Taproot (starts with bc1p) is the newest, enabling advanced features with good fee efficiency and broad support across modern wallets (some services are still catching up).

---

## Section IV: Bitcoin Layer 2 and Extensions

### Lightning Network

What if you could make instant Bitcoin payments without waiting for block confirmations or paying high fees? The **Lightning Network** makes this possible through a clever Layer 2 protocol that moves most transactions off the main blockchain.

The concept is elegantly simple: instead of broadcasting every payment to the entire network, two parties can open a private **payment channel** by locking funds in a shared on-chain account (technically a 2-of-2 multisig output).

Once the channel is established, you and your counterparty can transact an unlimited number of times by updating your channel's balance sheet off-chain. All state changes require mutual agreement and are secured by cryptography. When you're finished, you can close the channel by broadcasting the final state to the Bitcoin blockchain. The network can also route your payments across multiple interconnected channels.

Lightning uses **HTLCs** and **onion routing** for private, trust-minimized payments; **watchtowers** help penalize cheating. Channel liquidity is directional (inbound vs outbound) and affects routing success; rebalancing and swap services help manage liquidity for reliable routing.

Think of Lightning as a canal system with locks. You can only send a boat if there’s enough water on your side (outbound capacity), and you can only receive if the other side has room to raise water to meet you (inbound capacity). Multi-hop routes work only when each lock along the path has water oriented the right way. Rebalancing is like shifting barges to move water back without closing the canal. HTLCs are sealed containers that either pass every lock intact or return unopened; onion routing means each lock‑keeper sees only the next hop, not the whole voyage.

---

## Section V: Bitcoin Network Operations and Security Model

### Roles at a Glance

**Users/wallets** create and sign transactions, then broadcast them to the network (you can do this without running your own node). **Full nodes** independently validate and relay transactions and blocks, enforcing consensus rules for themselves (running a node is not the same as mining). **Miners** assemble validated transactions into candidate blocks and perform Proof‑of‑Work to win block production (miners typically run a full node, but mining is the energy‑intensive block creation role).

#### What Miners Do—and Don't—Control

- **Control:** transaction inclusion and ordering; which valid fork they mine on; the possibility of short-term reorganizations and censorship within the rules.
- **Do not control:** the validity rules themselves (as established earlier, full nodes enforce validity rules; hash rate does not). Miners cannot make invalid blocks or rule changes "valid" without the consent of the nodes that verify and the market that values the coin; attempting to do so just creates a different chain that users can ignore.

#### Economic Majority and Social Choice

What the market calls “Bitcoin” is whatever coin users, exchanges, custodians, merchants, and wallets choose to value and transact. Miners are paid in that coin, so they’re strongly incentivized to mine the chain those actors accept. That influence is social/economic, not a protocol role: users still require some aligned hashrate for liveness and security on their chosen rules, and coordinating a true “economic majority” is hard in practice.

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

### Privacy Model

How private are your Bitcoin transactions? Bitcoin is **pseudonymous**, not anonymous. While your addresses are not directly linked to your real-world identity, transaction graph analysis can be used to cluster addresses and track the flow of funds. This risk is significantly increased by address reuse. Furthermore, **KYC/AML** (Know Your Customer/Anti-Money Laundering) regulations at exchanges create links between your on-chain activity and real-world identity, creating privacy gaps.

Common privacy practices include avoiding address reuse and optionally leveraging **CoinJoin-style tools** to reduce heuristic linking.

### Network Economics

At a system level, the miner **security budget** is total revenue paid to block producers over time: subsidy + fees (per block, per day, or per epoch). Expressed in BTC this is straightforward, but for gauging attack resistance the relevant unit is typically **USD per unit time**, since both miners and potential attackers procure hardware, facilities, and energy in fiat terms. As specialized hardware improves, the cost per hash declines; holding "hashes" constant does not hold attacker cost constant. What matters economically is the dollar cost to acquire and operate enough hash rate for long enough to reliably reorg the chain.

This framing underscores a long‑run concern: the subsidy halves roughly every four years (see Monetary Policy above). If transaction fees and/or BTC price do not rise sufficiently to offset successive halvings, the USD‑denominated security budget trends lower. A materially smaller budget can lead to miner exits, weaker competition for blocks, and a lower dollar cost for would‑be attackers to rent or acquire a majority share of hash rate for a window of time. In the limit (around 2140) the subsidy falls to ~0, so durable **fee demand** must carry the full security budget—via payments, L2 settlements, inscriptions, batched rollup data, and other valuable uses of block space. Healthy fee markets over the cycle are therefore not a cosmetic metric; they are the funding mechanism for Bitcoin’s long‑term security.

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