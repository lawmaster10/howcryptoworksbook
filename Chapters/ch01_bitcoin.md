# Chapter I: A Comprehensive Introduction to Bitcoin

## Section I: Bitcoin Core Concepts

Bitcoin emerged from the ashes of the 2008 global financial crisis. On January 3rd, 2009, its anonymous creator, Satoshi Nakamoto, inscribed a telling message into Bitcoin's **genesis block**, the first block in its blockchain. The headline from *The Times* read: "Chancellor on brink of second bailout for banks." It served as a permanent statement of purpose, a critique embedded in code against centralized financial systems that had failed the world.

Bitcoin's design draws from the cypherpunk movement, which championed using cryptography to protect individual freedom and financial sovereignty. Rather than relying on banks or governments, Bitcoin functions as a peer-to-peer electronic cash system with no trusted intermediaries.

Its monetary policy is transparent, predictable, and enforced by mathematics rather than central bankers. It's perhaps the only asset in the world with a limited supply that can be independently verified. This programmed scarcity stands in stark contrast to fiat currencies, which can be printed without limit, and to hard assets like gold, which has a theoretically finite supply but no one actually knows the total amount in existence.

But this vision raised a fundamental question: How could thousands of computers scattered across the globe reach consensus on who owns what, without any central authority to settle disputes?

### Mining and Proof of Work

Bitcoin's Proof of Work system enables miners to prove they've expended enormous computational effort in a way that anyone can quickly verify. At the heart of this process is a **hash function**: a mathematical operation that takes any input data and transforms it into a fixed-length string of characters. What makes hash functions special is that they're one-way: you can't recover the input from the output, and even the tiniest change to the input produces a completely different, unpredictable result.

Miners bundle transactions into a block and then try to solve a computational puzzle. Think of it like rolling dice with astronomical odds, trying to get a number below a certain threshold. Except miners are "rolling" trillions of times per second. They do this by repeatedly running the block data through the SHA-256 hashing algorithm. SHA-256 is a cryptographic hash function standardized by the U.S. government, and Bitcoin applies it twice for additional security. Each run produces a random-looking output.

Each attempt uses a different number called a **nonce**, essentially just a counter that increments from zero to about 4 billion. Each nonce generates a different, unpredictable hash result. When a miner finally finds an output below the network's target threshold, they've solved the puzzle and can add their block to the blockchain.

But modern mining hardware is so fast it can exhaust all 4 billion nonce values in seconds. When that happens, miners need another way to vary their input. This is where the coinbase transaction comes in. Every block contains a special coinbase transaction that pays the miner their block reward plus any transaction fees, effectively "creating" new bitcoin. This transaction is unrelated to the exchange of the same name. Miners can modify a field within this coinbase transaction called the extra nonce, or they can increment the block's timestamp. Either change alters the block header hash and resets their search space.

The speed at which miners make these attempts is called hash rate, measured in terahashes or exahashes per second. It shows how many hashes a miner or the entire network can try each second. You might think a higher network hash rate would make blocks come faster, but the network automatically adjusts the difficulty to compensate. Every 2,016 blocks, roughly every two weeks, the network performs a difficulty retarget. It measures how long those blocks actually took and adjusts the target accordingly. To prevent wild swings, these adjustments are capped between one-quarter and four times the previous difficulty, keeping the average block time stable at 10 minutes.

Miners use specialized chips called **ASICs**, designed specifically for SHA-256 proof-of-work. These chips are thousands of times more efficient than regular computers for this task. Even with the best hardware, solo mining is like playing a massive lottery where you might wait years without finding a single block. To smooth out this variance, miners join **mining pools**. These pools use a communication standard called Stratum to coordinate work between miners. The pool combines everyone's computing power and shares rewards proportionally based on each miner's contribution. This provides steady, predictable payouts instead of long dry spells.

The newly created coins from a block's coinbase transaction can't be spent immediately. They must wait until 100 more blocks have been added on top, which takes about 16 to 17 hours. This delay makes it much harder for miners to profit from attempting to rewrite recent blockchain history.

### Consensus and Chain Selection

Now that we understand how mining works, we can explore how the network reaches agreement on which chain is valid.

Bitcoin's network is composed of nodes, which are computers running Bitcoin software that independently verify every transaction and block to ensure they follow the rules. These nodes maintain a complete copy of the blockchain and relay valid information to other participants. Miners typically run nodes themselves to verify the blocks they build, but many participants run nodes without mining, simply to validate Bitcoin's state independently and contribute to the network's decentralization. When people refer to "nodes" in Bitcoin discussions, they usually mean these non-mining participants who verify but don't produce blocks.

Bitcoin solves consensus through a robust mechanism called **Nakamoto Consensus**, which is often simplified as the "longest chain rule" but is more accurately described as the chain with the most cumulative work. Think of two hikers taking different routes: one takes 1,000 easy steps, the other 600 hard steps. The system doesn't score by steps (block count) but by energy required (a stand in for work), so the steeper, harder route can "weigh" more even with fewer steps. Nodes follow the same principle, choosing whichever chain required the most cumulative computational work to produce. An attacker can't rewrite history by simply creating more blocks; they must produce at least as much total work as the honest chain, and then some.

Occasionally, two miners find valid blocks at nearly the same time, creating temporary forks in the blockchain. Different parts of the network will initially follow different blocks depending on which one they heard about first. The tie is broken when the next block is found. Whichever fork gets extended first becomes longer and automatically wins. At that point, all nodes on the network switch to follow the longer chain, abandoning the shorter one. The block on the losing fork becomes stale, meaning it's discarded and not included in the final blockchain, and its transactions go back to being unconfirmed. This whole process usually resolves within minutes.

These chain reorganizations (or "reorgs") are a normal and expected part of Bitcoin's operation. One-block reorgs occur occasionally, two-block reorgs are rare, three or more are extremely rare absent an attack or severe network partition. This probabilistic behavior is why confirmations matter: the probability that a transaction is affected by a reorg falls exponentially with each additional block. Merchants typically wait for multiple confirmations (often six) before considering large payments final.

Beyond natural forks, Bitcoin faces other potential attacks. Eclipse attacks involve isolating a node's network connections to feed it a distorted view of the blockchain. Selfish mining involves withholding found blocks to mine privately and publish strategically for a revenue advantage. Diversity of peers, network-level protections, and monitoring help mitigate these risks.

### Monetary Policy

Bitcoin has a predictable, algorithmic monetary policy with a fixed issuance schedule. The block reward, or subsidy, is cut in half every 210,000 blocks, an event known as the "**halving**" that occurs roughly every four years. The subsidy began at 50 BTC and has since been reduced to 25, 12.5, 6.25, and most recently to 3.125 BTC after the 2024 halving.

This mechanism makes Bitcoin a disinflationary asset, as its inflation rate trends toward zero. Around the year 2140, the subsidy will cease, and miners will be compensated solely by transaction fees. Due to integer rounding in halvings, the terminal supply converges to \~20,999,999.9769 BTC. As of early 2026, roughly 95% of the eventual 21 million BTC has already been mined and is in circulation.

Miners earn revenue from two sources: the block subsidy (new issuance of BTC) and transaction fees paid by users. The vast majority of miner revenue comes from the block subsidy. In 2024, the block subsidy accounted for approximately 94% of total earnings. This combined revenue, known as the **security budget**, determines the cost of attacking the network, explored in detail in Section IV.

Bitcoin's predictable scarcity forms a cornerstone of its store of value proposition. However, scarcity alone doesn't guarantee price appreciation as price ultimately depends on sustained demand from buyers. Decreasing issuance creates favorable supply dynamics, but this only translates to price appreciation if accompanied by buying pressure that exceeds selling pressure in the market.

## Section II: Bitcoin Technical Architecture

Understanding Bitcoin's core concepts (mining, consensus, and monetary policy) provides the foundation. But to truly grasp how Bitcoin works, we need to examine the technical architecture that makes these concepts operational: how ownership is represented, how transactions are structured, and how the system maintains privacy and security at the protocol level.

### UTXO Model

Bitcoin tracks ownership differently than traditional banks through its Unspent Transaction Output (UTXO) model. The best way to understand this is through a cash analogy.

Imagine physical cash in your wallet: not a single account balance, but individual bills of different denominations like a $20, two $5s, and some $1s. When you buy something for $7, you hand over a $5 and two $1s, getting change back if needed. You can't split a single bill, you use the denominations you have and receive new ones in return.

Bitcoin operates on the same principle. Your wallet holds a collection of UTXOs, individual digital "coins" of varying amounts. When you send bitcoin, your wallet selects which UTXOs to spend (a process called coin selection that involves privacy and fee tradeoffs), consumes them entirely, and creates new UTXOs: one for the recipient and one as "change" back to you. This design elegantly prevents double-spending because once a UTXO appears in a confirmed transaction, it's permanently removed from the spendable set and cannot be used again.

Every full node independently maintains its own view of this global UTXO set, the complete collection of all spendable outputs, by validating the entire blockchain. Ownership of these UTXOs is controlled by **private keys**, extremely large random numbers (roughly between 1 and 2²⁵⁶, about 10⁷⁷ possibilities) that function as the cryptographic secret proving control over funds. Your wallet generates these from high-quality randomness, similar to flipping a fair coin 256 times and treating the sequence of heads and tails as a 256-bit number. The private key is the core secret in Bitcoin: it lets your wallet produce digital signatures that satisfy the spending rules on your UTXOs.

Put simply: you “own” bitcoin if you control the private keys needed to spend specific UTXOs. If you lose those keys, those coins are effectively gone. If you keep them safe, only you can move those coins.

The rules for spending these UTXOs are defined by **Bitcoin Script**, a simple programming language. Each output includes a locking script that sets the spending conditions. Think of it as a lock that specifies what key is needed. When someone wants to spend that output, they provide unlocking data (essentially the key) to satisfy those conditions. The Bitcoin network verifies that the key fits the lock before allowing the transaction.

Bitcoin Script also supports timelocks, which keep transactions invalid until a specified time or block height is reached. These enable sophisticated contracts like Lightning channels, vaults, and escrow arrangements. For example, you could create a transaction that can only be spent after a certain date, or one that requires multiple signatures but allows a backup key after a timeout period.

### Address Types and Formats

Bitcoin addresses have evolved over time, and you'll encounter several formats. Don't worry about memorizing the technical details. What matters is understanding that each generation improved on the last in terms of efficiency, privacy, or features. Modern wallets handle the complexity for you.

The key concept is that an address is not the same as a public key. Instead, an address is typically a shorter, encoded version of a public key hash or script hash, like a nickname that's easier to share than the full cryptographic data it represents.

The relationship between private keys, public keys, and addresses follows a specific cryptographic chain. From your private key, Bitcoin derives a public key using **elliptic curve cryptography**. Think of this as a one-way mathematical function: your private key transforms into a public key that's mathematically linked but computationally impossible to reverse. This public key then gets hashed (compressed through a one-way function) to create your Bitcoin address. The hashing keeps your public key hidden until you spend and makes addresses shorter and easier to share.

The address formats you'll encounter reflect this evolution. Legacy addresses, which start with 1, are the original format and work everywhere but typically incur slightly higher fees. P2SH addresses start with 3 and serve as a wrapper format often used for multisig setups or older SegWit compatibility. Native SegWit addresses start with bc1q and represent the modern default, offering lower fees and all-lowercase characters for easier error checking. Taproot addresses start with bc1p and represent the newest format. Unlike earlier types that hash the public key, Taproot encodes a version of the public key directly, enabling more flexible and private spending conditions where complex scripts can hide behind what looks like a simple single-key payment. Taproot has broad support across modern wallets, though some older services are still catching up.

For most users, simply use whatever address type your wallet generates by default. It will typically be Native SegWit or Taproot, both of which offer good fee efficiency and security.

### Transaction Structure and Prioritization

A Bitcoin transaction consists of inputs (the UTXOs being spent) and outputs (the new UTXOs being created). The transaction fee equals the sum of inputs minus the sum of outputs. Once broadcast, transactions enter each node's **mempool**, which is a pool of unconfirmed transactions waiting to be included in a block.

Here's where economics comes into play. Since blocks have limited space, miners must choose which transactions to include from the mempool. They naturally prioritize transactions that maximize their revenue. However, transactions vary in size. A simple payment might be small while a complex transaction consolidating dozens of small inputs or batching payments to many recipients could be much larger. This is why miners look at fee rate (fee per unit of size) rather than absolute fee. A small transaction paying 10 sats might have a higher rate than a large transaction paying 100 sats. Fee rate is measured in satoshis per virtual byte (sats/vB), where a satoshi is the smallest unit of bitcoin (100 million satoshis equal one bitcoin).

This creates a fee market where users essentially bid for block space. Users needing quick confirmation during network congestion pay higher fee rates. Those who can wait pay less and wait for a quieter period. If a transaction gets stuck, users can use **Replace by Fee (RBF)** to broadcast a higher fee replacement, or **Child Pays for Parent (CPFP)** to create a high fee child transaction that incentivizes miners to include the parent. CPFP is used when the sender can't (or doesn't want to) replace the parent but controls one of its outputs (sender's change or the recipient's output). RBF is used when the sender controls the original transaction and it can be replaced.

### Privacy Model

Bitcoin is **pseudonymous**, not anonymous. While addresses are not directly linked to real-world identity, transaction graph analysis can be used to cluster addresses and track the flow of funds. This risk is significantly increased by address reuse, which is why using a fresh address for each transaction is considered a best practice. Furthermore, KYC/AML regulations at crypto exchanges create links between on-chain activity and real-world identity, creating privacy gaps. Companies like Chainalysis have built billion dollar businesses on de-anonymizing blockchains.

At the transaction level, this pseudonymity has specific implications. When you receive bitcoin, only your address (the hash of your public key) appears on the blockchain. But when you spend bitcoin, you must reveal your actual public key along with a digital signature that proves you know the corresponding private key. This is a critical detail: the signature proves ownership without exposing the private key itself. Anyone can verify the signature matches the public key, and that the public key hashes to the address that received the funds, but they can't derive your private key from this information. This revelation of the public key at spending time is why the double-hashing that creates addresses provides an extra security layer, keeping your public key private until the moment you choose to spend.

The coin selection process mentioned earlier in the UTXO section has direct privacy implications. When your wallet chooses which UTXOs to spend, it's creating on-chain patterns that analysts use to cluster addresses. Spending multiple UTXOs together in one transaction strongly suggests they belong to the same owner. Similarly, the change output returning to your wallet can be identified through various heuristics, further linking your addresses.

To address these privacy limitations, various techniques have emerged. Common privacy practices include avoiding address reuse and optionally leveraging CoinJoin-style tools to reduce heuristic linking. **CoinJoin** combines inputs from many users into a single transaction that produces many outputs of identical (or near identical) denominations. Because all inputs sign the same transaction, on-chain observers cannot reliably determine which input funded which output. This breaks common heuristics like "multi-inputs belong to the same owner" and "change output detection," creating an anonymity set where each coin could plausibly belong to any participant. Modern implementations add features like input registration over Tor, output blinding, equal output denominations, and multi-round mixing to further resist clustering and improve plausible deniability.

## Section III: Bitcoin Upgrades and Scaling

Bitcoin's technical architecture provides a robust foundation, but no system is perfect from inception. The question becomes: how does a decentralized network evolve without central authority? This section explores Bitcoin's governance model, the mechanisms for upgrading the protocol, and the major improvements that have been deployed over its history.

### Bitcoin Core

The Bitcoin protocol is the set of rules that define how Bitcoin works: what makes a block valid, how transactions are structured, how much new bitcoin is created, and so on. It can be thought of as the "specification" for Bitcoin.

Bitcoin Core is software that implements these rules. It's the most widely used Bitcoin node software, originally written by Satoshi Nakamoto and now maintained by a global community of developers. When running a Bitcoin node, one is most likely running Bitcoin Core.

Here's where it gets interesting: Bitcoin has no formal written specification separate from the code. Instead, Bitcoin Core's consensus code has become the de facto reference that defines the rules. Other node implementations exist, like btcd or libbitcoin, but they maintain compatibility by matching Core's behavior. This means Core holds significant influence not because it controls Bitcoin, but because the economic majority has chosen to run it.

### Consensus Rules vs. Policy Rules

Understanding Bitcoin requires distinguishing between two types of rules that nodes enforce. Consensus rules are the fundamental laws that define what makes a block or transaction valid on the blockchain itself. These rules are enforced by all full nodes when validating blocks, and any violation results in permanent rejection. Examples include blocks not exceeding 4,000,000 weight units, outputs not exceeding inputs plus the coinbase reward, and signatures being cryptographically valid. Breaking a consensus rule means a transaction or block is invalid and will never be accepted into the blockchain, regardless of miner support.

Policy rules, also called mempool policy or relay policy, represent a different layer entirely. These are optional standards that individual nodes use to decide which unconfirmed transactions they'll accept into their mempool and relay to peers. Working on top of Bitcoin's mandatory consensus rules, these additional local preferences help nodes filter spam, prioritize valuable transactions, and manage resources. Examples include minimum relay fee rates, transaction size limits for relay that are far below the block limit, and standardness restrictions on which types of scripts nodes will relay, favoring common patterns even though more exotic consensus-valid scripts exist.

The distinction between these rule types creates an important dynamic. A transaction can violate standard policy yet remain perfectly valid under consensus rules. When a transaction uses a non-standard script, for instance, most nodes won't relay it and it won't appear in most mempools. However, if a miner receives it directly, perhaps because the user contacted them, the miner can include it in a block. Once included, all nodes will accept that block as valid because policy rules don't govern what belongs in blocks, only what gets relayed beforehand. This has happened with various non-standard transactions throughout Bitcoin's history.

This separation serves several important functions. Nodes can reject uneconomical transactions before they waste network bandwidth or blockchain space without requiring network-wide coordination. Different node operators can choose stricter or looser policies based on their needs, hardware capabilities, or philosophies. Policy can be adjusted through Bitcoin Core releases without the coordination challenges of consensus changes, allowing new transaction types to be made consensus-valid while policy rules gradually adopt them over time.

### How Changes Happen

Changes to Bitcoin are proposed through **BIPs (Bitcoin Improvement Proposals)**. Policy changes happen regularly through Bitcoin Core releases and don't require extensive coordination. Node operators can upgrade at their convenience, and the network continues functioning even with mixed policy versions. Recent releases have focused primarily on mempool policy improvements, adjusting things like fee rate minimums and transaction relay rules.

Consensus changes are far rarer and more significant because they modify the fundamental protocol rules about what makes blocks and transactions valid. These require careful coordination since the entire network needs to agree on the rules. When consensus rules do change, it happens through specific upgrade mechanisms explored below.

Bitcoin Core's careful development process, extensive testing, and broad adoption make it the standard reference implementation. Major upgrades like SegWit and Taproot were implemented in Core and activated by the network, demonstrating how protocol evolution works through this widely-adopted software. However, ultimate control rests with users and businesses who decide which software to run and which rules to follow.

### Understanding Fork Types

How can a decentralized network be upgraded when no one's in charge? Bitcoin has two main upgrade mechanisms that allow the protocol to evolve while maintaining consensus.

#### Hard Forks

Hard forks are incompatible upgrades that loosen or change consensus rules. Think of it like changing from left-hand to right-hand driving: if a driver doesn't switch, they simply can't operate safely on the new roads. Everyone has to upgrade or they'll keep driving on the old side, which becomes a separate road network. Bitcoin avoids this because coordinating such a complete transition is risky and can permanently split the network. Hard forks are extremely rare in Bitcoin due to coordination challenges and the risk of permanent network splits.

A notable example is Bitcoin Cash (BCH), created in 2017 by changing rules (notably much larger blocks). In practice, that approach fractured liquidity and community mindshare. Over time, BCH has retained only a small fraction of Bitcoin's adoption, hashpower, and market value. Most users, developers, miners, and exchanges coordinated on the original smaller-block BTC chain as the main “Bitcoin,” largely because it kept it cheaper and easier for ordinary people to run full nodes and verify the chain themselves. Critically, though, deciding what's the "real Bitcoin" isn't something the code can decree since there is no central authority. It's a messy blend of social consensus (what users, exchanges, wallets, and merchants run), economic gravity (where liquidity settles), and security assumptions (what most full nodes enforce). Markets have decidedly treated BTC as the Schelling point, but that outcome is ultimately social, not ordained.

#### Soft Forks

Soft forks are backward compatible protocol upgrades that tighten consensus rules without breaking the network. Think of it like adding a new traffic rule that existing drivers automatically comply with: upgraded nodes enforce stricter rules (like "no right turn on red at this intersection"), while non-upgraded nodes still see all traffic as valid and the network continues functioning normally. Non upgraded Bitcoin nodes still see new blocks as valid but don't enforce the stricter rules themselves, allowing the network to upgrade without splitting into incompatible versions. They require majority support to avoid chain splits, with examples including SegWit and Taproot.

#### Activation Mechanisms

Deciding to implement a soft fork is one thing, but actually activating it across the network requires careful coordination. The network needs a way to measure readiness and ensure enough participants have upgraded before the new rules take effect. This is where activation mechanisms come in. Different methods have been developed to balance miner coordination, economic node participation, and the risk of chain splits.

**Miner Activated Soft Forks (MASF)** rely on hash power signaling; miners indicate readiness by including version bits in block headers. BIP9 was the standard MASF framework, requiring a high threshold (typically 95%) of blocks to signal support during defined time windows. Once the threshold is reached, the soft fork locks in and activates after a grace period. This was used for upgrades like SegWit (eventually) and most historical soft forks.

**User Activated Soft Forks (UASF)** represent an alternative where economic nodes coordinate a "flag day" to start enforcing tighter rules, potentially regardless of miner signaling. If enough economic nodes and service providers participate, miners face a simple incentive: follow the new rules to get paid, or mine a chain most users won't accept.

**Speedy Trial** is a short miner signaling trial with a 90% threshold over 2,016 block windows. If it locks in, activation occurs later at a preset block height; if it times out, no activation occurs and other mechanisms can be considered. This method was successfully used for Taproot activation in 2021\.

#### The Challenge of Change

Despite backward compatibility, getting any soft fork into Bitcoin is intentionally difficult. Many developers prioritize **protocol ossification**, the idea that Bitcoin should become increasingly resistant to change as it matures. This conservative approach recognizes a counter-intuitive strength: Bitcoin's power comes partly from what it *doesn't* do. By changing rarely, Bitcoin becomes predictable. Users can trust that the monetary policy won't be altered. The fewer changes made, the lower the risk of introducing bugs or unintended consequences that could compromise a multi-trillion-dollar asset.

There's also an economic feedback loop at play: as Bitcoin's market cap grows and more economic activity depends on it, the threshold for "this upgrade is worth the risk" rises accordingly. A $100 billion asset might tolerate experimentation; a $2 trillion asset demands extreme conservatism. This isn't a bug, it's a feature that naturally protects the base layer as its importance increases.

This philosophy means proposals undergo years of review, testing, and community debate.

### Bitcoin's Major Upgrades

#### Segregated Witness (SegWit, 2017\)

The SegWit activation saga represents one of the most important case studies in Bitcoin's governance, demonstrating how protocol upgrades work (and sometimes don't work) in a truly decentralized system.

SegWit was a landmark upgrade that solved multiple critical issues. Before SegWit, Bitcoin had a critical bug: third parties could alter a transaction's signature and change its ID (TXID) before confirmation, without affecting the transaction's validity. This **transaction malleability** made it risky to build dependent transactions or second layer protocols like Lightning.

SegWit moved signature data to a separate "witness" structure, making transaction IDs immutable once created. It also introduced **block weight** (a new measurement system with a 4,000,000 weight unit maximum instead of a simple 1MB limit). This effectively increased block capacity while incentivizing adoption of more efficient SegWit addresses. The weight system counts witness data as one quarter for weight calculation (commonly described as a "75% discount"), creating a backwards compatible blocksize increase.

To understand the political dynamics, it's helpful to think of pre SegWit Bitcoin as "Bitcoin 1.0" (a system with a hard 1MB blocksize limit and transaction malleability issues). SegWit represented "Bitcoin 1.1" (mostly backwards compatible with Bitcoin 1.0, but fixing protocol bugs and enabling second layer networks while providing a one time capacity increase).

The original activation mechanism was a MASF using BIP9 with a 95% threshold: during any 2,016 block difficulty adjustment period within the window from November 15, 2016 to November 15, 2017, if 95% or more of mined blocks signaled support, the upgrade would lock in. After a grace period, SegWit would activate and the network would accept the new transaction types.

To understand what happened next, some context is needed. Bitcoin had been debating how to scale for years. Some factions wanted to increase the block size limit dramatically through a hard fork (which eventually led to the creation of Bitcoin Cash), while others preferred SegWit's approach of fixing transaction malleability and enabling second-layer solutions like Lightning Network. This disagreement became known as the "blocksize wars."

Some large miners opposed SegWit because they preferred simply increasing block sizes. Even though SegWit had widespread support from developers, businesses, and node operators, these miners could block activation by refusing to signal. The BIP9 mechanism had assumed that signaling meant "my software is technically ready," but these miners were treating it as a political vote. This created an unprecedented governance crisis where a coordinated group of miners could indefinitely veto a beneficial upgrade, even though the upgrade didn't require their technical participation to function.

BIP 148 represented a proposed solution to this governance deadlock. BIP 148 changed consensus rules for participating nodes by rejecting any non-signaling blocks after August 1st, 2017\. If enough economic nodes (exchanges, services, businesses) ran BIP 148, miners faced a stark choice: signal SegWit support and get paid in bitcoin that the broader economy would accept, or mine a chain that major economic actors would ignore.

The threat of BIP 148 created powerful economic incentives that ultimately resolved the impasse. BIP 91 locked in on July 21, 2017 and activated two days later, enforcing that miners signal bit 1 and enabling BIP 141 to reach its threshold. With BIP 148's flag day planned for August 1st, the pressure was on. SegWit (BIP 141\) locked in on August 9, 2017 and activated on August 24, 2017 at block 481,824. BIP 91 served as an intermediate solution that allowed miners to signal SegWit support before the UASF deadline, and SegWit successfully activated via the original BIP9 mechanism.

The SegWit activation demonstrates several crucial principles about Bitcoin governance. Economic nodes ultimately enforce protocol rules when sufficiently coordinated, reinforcing the power dynamics between miners and users. Soft forks can be enforced by users when there's sufficient economic coordination, even against miner resistance. Credible threats matter more than actual deployment, as BIP 148 succeeded largely because the threat was believable rather than because a majority of nodes actually ran it. Finally, Bitcoin's governance proved antifragile: the system found a way to route around the blockade and activate beneficial upgrades despite coordinated resistance.

#### Taproot (2021)

The Taproot upgrade significantly improved programmability and confidentiality. Unlike SegWit's contentious activation, Taproot enjoyed broad consensus across miners, developers, and economic nodes. However, even with this agreement, the upgrade still required several years of active community discussion, careful review, and coordination to ensure the changes were thoroughly vetted and safely deployed.

Taproot used the Speedy Trial activation mechanism with a 90% miner signaling threshold. The signaling period began in May 2021, and the threshold was quickly met, with the upgrade locking in during June 2021\. After a predetermined grace period to allow remaining nodes to upgrade, Taproot activated in November 2021 at block 709,632. The smooth activation demonstrated that when there's genuine consensus, Bitcoin can upgrade efficiently while still maintaining its cautious, deliberate approach to protocol changes.

The technical improvements were substantial. **Schnorr Signatures** enable key and signature aggregation, allowing complex multi-party transactions to appear as single signatures on-chain. **Merkleized Abstract Syntax Trees (MAST)** structure complex spending conditions efficiently, where only the condition that's met needs to be revealed.

Together, these features provide major benefits: complex transactions become indistinguishable from simple payments for key path spends, delivering significant privacy and scalability improvements. When script path spends are used, only the revealed branch is disclosed, maintaining privacy for unused conditions.

## Section IV: Bitcoin Network Operations and Security Model

Having examined Bitcoin's technical architecture and upgrade mechanisms, we now turn to how the network itself operates. Understanding the security economics that keep Bitcoin running provides essential context for evaluating Layer 2 solutions and Bitcoin's long-term viability.

We've established that full nodes validate transactions and blocks while miners compete to produce new blocks. Miners almost universally run their own full nodes because they need to independently validate transactions, build upon the latest valid block, and ensure the blocks they produce follow all consensus rules. A miner who builds an invalid block forfeits their reward since the network will reject it.

Not all participants need to run full nodes, however. Pruned nodes provide the same validation security as full nodes but conserve disk space by discarding old block data after verification. **SPV (Simplified Payment Verification)** clients, commonly found in mobile wallets, take a lighter approach by downloading only block headers and relying on full nodes for transaction validation.

Miners wield significant but limited influence. They control transaction inclusion and ordering, determine which valid fork to mine on, and can attempt short-term censorship within existing rules. However, as the SegWit activation saga demonstrated, economic nodes ultimately hold the power. Miners must produce blocks that the broader economy will accept, or they don't get paid.

To find each other, the network maintains its decentralized topology through peer-to-peer discovery mechanisms, primarily using DNS seeds and direct peer-to-peer exchange.

### Block Propagation and Network Synchronization

When a new node joins, it performs an Initial Block Download (IBD) to sync the entire blockchain from its peers. To ensure new blocks propagate quickly and efficiently, the network uses optimized protocols like Compact Block Relay, which minimizes bandwidth by only sending information that nodes don't already have. Nodes also engage in mempool synchronization to share unconfirmed transactions. The network is resilient to partitions (temporary splits), which self heal once connectivity is restored.

### Attack Vectors and Economic Security

Bitcoin's security depends on making attacks too expensive to be profitable for most actors. The most cited threat is a **51% attack**, where an entity controlling a majority of the network's hashpower could attempt to rewrite recent history or double-spend its own coins. For profit-seeking attackers, the immense cost of acquiring and running this hardware, combined with the fact that a successful attack would devalue the asset they're attacking, makes this strategy economically irrational.

In theory, a nation-state or ideological attacker could ignore direct financial losses and attack for political or strategic reasons. But even then, they face substantial practical hurdles: sourcing and operating enough specialized hardware and energy, coordinating the attack without being detected, and sustaining it in the face of defensive responses (exchanges pausing withdrawals, users waiting for more confirmations, miners re-organizing, or even a community-driven change in the mining algorithm). In practice, nation-states have cheaper and more effective tools like regulation, taxation, surveillance, and pressure on exchanges and custodians than trying to permanently dominate Bitcoin's hashpower.

#### The Security Budget

The security budget is the economic foundation that makes attacks prohibitively expensive. As explained in Section I, it consists of the block subsidy plus transaction fees, determining how much hash rate miners deploy to secure the network. While this budget is straightforward to calculate in BTC terms, the relevant metric for gauging attack resistance is USD per unit time, since both miners and potential attackers procure hardware, facilities, and energy in fiat terms.

Understanding Bitcoin's security model requires understanding how it's actually used. Bitcoin functions more like gold than a payment network. Most bitcoin sits passively in wallets for long periods, with large holders rarely touching their funds. This "set and forget" mentality means transaction volume remains relatively low compared to payment networks, creating implications for the long-term security budget.

Bitcoin's halving schedule creates a central security challenge: as the block subsidy declines toward zero by 2140, transaction fees must eventually carry the entire security budget. However, if Bitcoin is primarily held rather than frequently transacted, fee generation may remain modest. This creates a critical tension: if transaction fees and BTC price do not rise sufficiently to offset successive halvings, the USD-denominated security budget will trend lower. A materially smaller budget could lead to miner exits, weaker competition for blocks, and reduced costs for would-be attackers to acquire majority hash rate.

Whether durable fee demand emerges from settlement payments, L2 operations, data inscriptions, rollup commitments, or other block space uses remains an open question critical to Bitcoin's long-term security model.

#### How Security Works

As discussed in Section I, security is achieved through confirmation depth. Each subsequent block exponentially increases the work required to alter a transaction. The system is designed so that economic incentives strongly reward miners for honest behavior, backed by the economic resources represented by the security budget.

Bitcoin is designed to be antifragile, meaning it grows stronger from stress and attacks. Its resilience stems from several factors: geographic distribution of nodes and miners resists localized disruptions, protocol ossification or resistance to change enhances stability and predictability, and its design assumes an adversarial environment, built to function despite malicious actors. The network has survived numerous technical, political, and economic challenges, demonstrating its robust and self-healing nature.

## Section V: Bitcoin Layer 2 and Extensions

Having established how Bitcoin's network operates and maintains security, we can now explore how these foundational mechanisms enable higher-layer innovation. This section examines two distinct categories of extension: scaling solutions that move transactions off-chain for speed and cost efficiency, and data layer applications that leverage Bitcoin's immutability for on-chain use cases. While these serve fundamentally different purposes (one addresses throughput constraints, the other exploits Bitcoin's censorship-resistant storage), both demonstrate how a simple, constrained base layer can enable sophisticated higher-layer functionality.

### Scaling: L2 Classification and Trust Models

Before examining specific scaling solutions, it's essential to understand what actually qualifies as a Layer 2 (L2) and what security guarantees are possible given Bitcoin's current capabilities. Numerous projects claim to offer Bitcoin L2 solutions with different tradeoff profiles, but evaluating these claims requires a clear definitional framework.

The fundamental dilemma centers on a basic limitation: while Bitcoin Script can verify signatures and basic spending conditions, it cannot enforce complex constraints on future transactions or verify claims about external state.

The definitional challenge stems from what constitutes a genuine L2: a scaling solution that inherits the security properties of its base layer without introducing additional trust assumptions. True L2s allow users to unilaterally exit back to the main chain using only cryptographic proofs, no permission needed from any third party. The base layer's consensus mechanism can directly adjudicate disputes and enforce the L2's rules. Most current Bitcoin scaling solutions, however, are more accurately described as sidechains or federated networks with Bitcoin bridges, since they require users to rely on external validators beyond Bitcoin's own consensus.

This creates a security constraint for L2 bridges and rollups. When someone wants to withdraw funds from an L2 back to Bitcoin's main chain, the system needs a way to verify that the withdrawal is legitimate according to the L2's state. However, Bitcoin Script cannot practically check things like "this withdrawal matches an entry in the L2's state tree" or "these outputs correspond to a valid Merkle proof." Script lacks the needed covenant and introspection primitives to make this practical without reliance on intermediaries.

As a result, today's Bitcoin L2 solutions fall back on third-party validators, federations of signers, multisig arrangements, or programmatic attesters, to validate and co-sign withdrawals. This is exactly what systems like Stacks' sBTC do with their "decentralized network of signers." While these signers may be distributed across multiple parties, they still represent a fundamental custody risk: if they collude, get compromised, or their software has bugs, user funds can be censored or stolen. The "trustless" promise of cryptocurrency gets reduced to relying on this federation model.

#### Potential Solutions: Covenants and Alternatives

Developers have proposed several ways to fix Bitcoin's L2 limitations. Each approach offers different tradeoffs between how soon it could work and how secure it would be.

The most straightforward solution involves upgrading Bitcoin itself. Developers have proposed adding new opcodes to Bitcoin's programming language through a soft fork. The leading candidates include re-enabling something called OP\_CAT and adding new tools like CTV and CSFS. Together, these would let Bitcoin scripts create custom messages, verify signatures, and set rules about how coins can be spent later.

For L2 bridges, this would be transformative. Right now, you have to trust a group of signers to approve withdrawals. With **covenants**, Bitcoin's blockchain could check the math itself and enforce the exit rules automatically. You could withdraw your funds using only cryptographic proofs, and no federation could stop you. The debate now focuses on figuring out the smallest set of new opcodes that would enable this safely. None of these proposals are active yet, and they would need broad agreement from the Bitcoin community to implement.

While covenant opcodes might take years to activate, BitVM takes a different approach. It works with Bitcoin exactly as it exists today, without any upgrades needed. BitVM and its newer versions (BitVM2 and BitVM3) use what's called an optimistic model.

Here's how it works: an operator makes a claim about what's happening on the L2. If they're lying, anyone can challenge them on the Bitcoin blockchain within a certain window (usually a few days to two weeks). If the challenge succeeds, the operator loses the money they put up as collateral. Recent research claims BitVM3 can reduce the data needed to about 66 kilobytes using something called garbled circuits, but the designs are still changing quickly. In fact, one version from July 2025 had to be pulled back after researchers found a security flaw. These approaches are still experimental rather than ready for real use.

BitVM systems have important limitations. They're complicated to run and require active participation. Someone has to actually watch for fraud and challenge it within the time window. The security depends on at least one honest person being willing and able to raise the alarm. This is fundamentally different from covenant-based systems, where Bitcoin itself checks the proofs directly without needing anyone to file a dispute.

The key distinction comes down to who enforces the rules. Today's federation-based systems ask you to trust that most signers will be honest. Covenant-enabled systems would move that enforcement into Bitcoin's consensus rules themselves, making invalid withdrawals literally impossible to include in the blockchain regardless of what any federation tries to do. This would be a major security upgrade.

Whether Bitcoin will actually adopt these changes, and when, is still an open question in the development community.

### Lightning Network

Bitcoin's base layer is optimized for high-assurance settlement, which makes small everyday payments economically inefficient. High fees and limited block space mean buying coffee with an on-chain transaction doesn't make sense. The Lightning Network attempts to solve this by moving small, frequent payments off the main blockchain.

The basic concept is straightforward. Instead of broadcasting every payment to the entire network, two parties can open a private **payment channel** by locking funds in a special on-chain transaction that requires both signatures to spend. Once the channel is open, they can update their balances off-chain by creating new versions of how the funds could be split, along with cryptographic penalties that punish anyone who tries to cheat by broadcasting an old state. When they're done transacting, they can close the channel and settle the final balance back to the main blockchain.

The network becomes more powerful through routing. Users don't need direct channels with everyone they want to pay. If Alice has a channel with Bob, and Bob has a channel with Carol, Alice can pay Carol through Bob. The network uses routing techniques that hide the full payment path from intermediate nodes, providing better privacy than repeatedly using the same on-chain addresses. However, the privacy isn't perfect. Careful analysis of payment amounts, timing, and network probing can still reveal information.

#### Lightning's Strengths

When Lightning works well, it delivers compelling advantages. Payments settle in seconds rather than waiting for block confirmations, making it viable for point-of-sale transactions and interactive applications. Transaction costs drop to negligible amounts, often just a few satoshis, enabling microtransactions that would be completely impractical on the base layer. The off-chain nature of payments provides better privacy than repeatedly using the same on-chain addresses, as intermediate routing nodes only see encrypted payment data. For users who establish well-connected channels with sufficient liquidity in both directions, Lightning can provide a smooth payment experience that approaches the convenience of traditional payment systems while maintaining non-custodial control of funds.

#### The Liquidity Challenge

Lightning users can only send payments if there's enough balance on their side (outbound capacity), and they can only receive payments if the other side has enough room (inbound capacity). This liquidity constraint is Lightning's biggest practical limitation.

When channels lack sufficient liquidity in the right direction, payments fail or must be split across multiple routes. Some technical improvements help: payments can be automatically split across several paths to improve success rates, and specialized service providers can help users acquire the inbound capacity needed to receive payments. Channel rebalancing can redistribute liquidity, but it costs fees and takes time. Even with these tools, the fundamental challenge of having liquidity in the right place at the right time remains.

#### Operational Realities

Lightning faces several hurdles to adoption. Unlike Bitcoin's base layer where payments arrive automatically even when the recipient is offline, Lightning typically requires users to be online to receive payments. Some services can monitor channels for cheating attempts while you're offline, keeping your funds safe, but they don't enable offline receiving itself.

Some wallet providers offer workarounds that allow payments to arrive when you're offline, but these often involve trusting the service provider with some custody or control. For users, managing channels is complex. They must acquire inbound capacity to receive payments, stay online or use trusted services, and navigate the separation between L1 and L2. This operational overhead is difficult for non-technical users.

Higher base layer fees create additional challenges. Opening and closing channels becomes more expensive, and during fee spikes, time-sensitive transactions may need to be confirmed quickly or risk forcing channels to close. Modern improvements allow channels to be resized without fully closing them and enable better fee management, but the operational complexity remains.

For merchants, integration complexity is compounded by Bitcoin's price volatility, which creates accounting and pricing challenges regardless of whether payments arrive on-chain or through Lightning.

#### The Custodial Trade-off

These limitations have led many users toward custodial or semi-custodial Lightning wallet services that manage channels and liquidity on their behalf. While this dramatically improves user experience and payment reliability, it reintroduces the trust requirements and vulnerabilities that Bitcoin was designed to eliminate. Users face custodial risk: funds can be frozen, accounts can be closed, services can fail, and providers must be trusted not to mismanage or steal funds. This represents a fundamental tension between usability and the self-sovereignty that attracted many to Bitcoin in the first place.

### Beyond Payments: Bitcoin as a Data Layer

Having explored scaling solutions aimed at transaction throughput and smart contracts, we now turn to an entirely different category of Bitcoin extension. While Lightning and L2s attempt to reduce on-chain activity, Ordinals and inscription-based systems embrace it, using Bitcoin's immutability and censorship resistance to anchor arbitrary data permanently on the blockchain. This represents a philosophical shift from "Bitcoin as payment rail" to "Bitcoin as permanent storage layer."

#### Ordinal Theory

Ordinal theory is a way of treating individual satoshis as unique, collectible units rather than interchangeable currency. The core idea is simple: assign every satoshi a serial number based on when it was mined. This numbering system allows specific satoshis to be tracked as they move through transactions, similar to how you might track a dollar bill by its serial number.

This tracking system enables a practice called **inscriptions**, where users attach arbitrary data (images, text, or other content) to specific satoshis. The inscribed satoshi becomes a carrier of that digital content, creating something analogous to digital collectibles or NFTs directly on the Bitcoin blockchain.

Inscriptions use a two-step process. First, a transaction commits to what will be inscribed. Then, a second transaction reveals the actual content by including it in the transaction's witness data. This stores the content directly on the blockchain rather than just storing a reference to external data.

This approach differs from earlier methods of embedding data in Bitcoin. The inscription data lives in witness space, which can be pruned by nodes that don't want to store it after validation. Archive nodes and specialized indexers maintain the full inscription history, allowing users to retrieve the content even if many nodes have pruned it.

#### Bitcoin-Native NFTs

An inscribed satoshi functions like a Bitcoin-native NFT: a unique token with on-chain content and provenance that transfers by moving that specific satoshi. The architectural difference from Ethereum's NFTs is notable. Ethereum relies on smart contract standards like ERC-721, often with media stored off-chain on services like IPFS. Bitcoin achieves uniqueness through ordinal numbering, with the media bytes embedded directly in the blockchain's witness data. The result is a digital artifact whose uniqueness is enforced by Bitcoin's transaction model combined with off-chain indexers that follow ordinal conventions.

Transferring an inscription requires careful control of which satoshis are being spent. Users must ensure their transaction's input and output ordering moves the target inscribed sat and not the surrounding ones. Purpose-built wallets and specialized tooling provide this precise sat selection capability. Experts recommend keeping inscribed sats in separate addresses to avoid accidental merges or spends, while marketplaces often use partially signed transactions so users can verify exactly which inscription is being transferred before signing.

#### BRC-20: Experimental Fungible Tokens

While Ordinals create unique digital artifacts, BRC-20 extends the concept to fungible tokens on Bitcoin. Rather than using smart contracts, BRC-20 uses small JSON inscriptions that describe three fundamental actions: deploy (create a new token), mint (create new units), and transfer (send tokens to someone else). Community-run indexers reconstruct token balances by reading the ordered history of these inscriptions, creating a system of "rules by convention" rather than enforcement by Bitcoin's scripting language.

The system works like this: a deploy inscription initializes a token ticker (typically four letters) and sets parameters like maximum supply. Mint inscriptions create new units and credit them to whoever owns the mint inscription. Transfer inscriptions earmark amounts to send. Unlike Ethereum tokens where a smart contract enforces all the rules, BRC-20 validity depends on indexers agreeing on the interpretation of these JSON messages.

#### The Transfer Process

A BRC-20 transfer follows a two-step process. Think of it like writing a check: First, you create the "check" by making a transfer inscription. This earmarks the funds you want to send. Then, you must physically hand the check to the recipient by sending them the transaction output containing that inscription.

The technical mechanics work as follows: users first inscribe a JSON object declaring their intent to transfer a specific number of tokens, receiving this transfer inscription in the same wallet that holds their BRC-20 balance. This step moves tokens from an "available" balance to a "transferable" pool in the eyes of indexers. Then, the transfer inscription itself must be sent to the recipient's address. When that transaction confirms, indexers debit the sender's balance and credit the recipient.

This creates an important distinction from Ordinals: sending an Ordinal inscription resembles moving a unique physical object, while BRC-20 transfers operate more like managing ledger entries with a paper trail.

#### The Debate

The emergence of Ordinals and inscriptions has sparked significant debate within the Bitcoin community. Critics argue that storing arbitrary data consumes valuable block space that should be reserved for financial transactions, creates sustained fee pressure that prices out smaller users, and represents a misuse of Bitcoin's design as peer-to-peer electronic cash. Proponents counter that all consensus-valid transactions are legitimate uses of the network, that inscription activity generates fee revenue crucial for long-term miner sustainability as the block subsidy declines, and that preventing users from embedding data would require contentious changes that conflict with Bitcoin's permissionless ethos.

This tension reflects deeper questions about Bitcoin's purpose and evolution: is it purely a payment and settlement layer, or can it accommodate diverse use cases that leverage its unique properties of immutability and censorship resistance?

#### Strengths and Limitations

Ordinals and BRC-20 demonstrate how Bitcoin's base layer can support digital asset systems through creative use of existing features without requiring new opcodes or consensus changes. They use Taproot's witness space and Bitcoin's transaction model to create application-layer conventions. The blockchain itself remains unchanged.

However, this approach has inherent limitations. Collection-wide rules, royalties, and token supply enforcement exist outside Bitcoin's scripting language and depend on indexers and community conventions rather than cryptographic guarantees. BRC-20 in particular remains explicitly experimental, with even its original creator pointing to alternative systems as more purpose-built solutions. Both systems work across multiple wallets and marketplaces today, but they're best understood as social conventions anchored to real Bitcoin transactions rather than protocol-enforced mechanisms.