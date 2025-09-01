# Part V: Data Availability & MEV

## Chapter 19: Celestia and the Data Availability Layer

**Celestia** represents a fundamental shift in blockchain architecture, operating as a specialized modular chain focused purely on **consensus** and **Data Availability (DA)**. Unlike traditional monolithic blockchains, it does not handle smart contract execution or settlement. Its primary function is to order transactions and, most importantly, guarantee that the underlying data for those transactions has been published and is accessible to everyone.

### The Data Availability Problem

To understand Celestia's purpose, one must first grasp the **Data Availability Problem**, a critical challenge for rollups. Rollups gain efficiency by processing transactions off-chain, but for security, they must post their transaction data to a reliable layer. This ensures that anyone can independently verify the rollup's state transitions, challenge invalid transactions (via fraud proofs), or reconstruct the entire state if the rollup's operator goes offline.

If this data is withheld, the rollup effectively fails, as its security guarantees collapse. This is not just a theoretical concern; it's a major economic one. For rollups built on Ethereum, the cost of posting transaction data to the L1 can account for **over 90%** of their total operational expenses.

### Celestia's Solution: Data Availability Sampling (DAS)

Celestia was designed from genesis to solve this problem with a novel technology called **Data Availability Sampling (DAS)**. Instead of requiring nodes to download entire blocks to verify data availability, DAS allows even lightweight clients ("light nodes") to confirm it with high statistical certainty by downloading only a few small, random chunks of block data.

This is possible through a technique called **erasure coding**, which reconstructs the full block data from a fraction of its pieces. If a light node can successfully retrieve all of its requested random samples, it gains near-certainty that 100% of the block's data was made available by the producer. This groundbreaking approach allows Celestia's block size to scale directly with the number of light nodes on the network, dramatically increasing data throughput without overburdening individual participants.

Celestia uses **Namespaced Merkle Trees (NMTs)** and **two-dimensional Reed–Solomon encoding** to support per-namespace sampling and efficient proofs. Consensus is provided by **CometBFT** (Tendermint-family).

### How Celestia Works in the Modular Stack

The integration process for a rollup is straightforward:

1. **Data Submission**: A rollup bundles its transaction batches into "blobs" and submits them to Celestia using a native **PayForBlobs transaction**. The fees paid for this, known as **"blob gas,"** constitute the protocol's revenue and incentivize validators to secure the network.

2. **State Commitment**: The rollup then posts a concise cryptographic commitment of its new state (e.g., a Merkle root) to a dedicated settlement layer, such as Ethereum. This commitment includes a pointer referencing the transaction data's location on Celestia.

3. **Verification and Recovery**: With this system, anyone can verify the rollup's integrity. To issue a fraud proof, a challenger simply fetches the relevant transaction data from Celestia and uses it to prove the state commitment on the settlement layer is invalid. Similarly, the full rollup state can be reconstructed using the data from Celestia and the commitments from the settlement layer.

The security of this model hinges on two core assumptions: the consensus layer is secured by validators staking Celestia's native token (**TIA**), and the DAS guarantee relies on an **honest majority of light nodes** sampling data. An attacker would need to compromise a significant portion of both validators and light nodes to undermine the system's integrity.

Celestia also enables **sovereign rollups** that rely on Celestia purely for DA while maintaining their own settlement and execution rules.

### Celestia in Context: A Comparison of DA Solutions

Celestia is not the only solution for data availability, and understanding the alternatives is key to knowing when to use it.

- **Ethereum (EIP-4844)**: *See Chapter 8 for a detailed explanation of blob-carrying transactions and costs*; Ethereum's native blob space reduces DA costs but does not offer Celestia's dynamic scaling.

- **EigenDA**: This solution from EigenLayer offers high-throughput DA by leveraging Ethereum's "restaking" model, but it operates under a different set of trust assumptions tied to the value staked in its system.

- **Validiums**: This approach keeps data off-chain entirely, relying on a **Data Availability Committee** or other trusted setup. While potentially cheaper, it offers weaker security guarantees, as data availability is not enforced by on-chain crypto-economic mechanisms.

- **Avail**: A specialized DA chain with NMTs and KZG commitments, offering DA sampling with a distinct validator/security model.

---

## Chapter 20: The Complex World of MEV

**Maximal Extractable Value (MEV)** is the profit block producers can capture by strategically ordering, including, or excluding transactions within the blocks they create. This concept, originally called **"Miner Extractable Value"** during Ethereum's proof-of-work era, represents revenue extracted beyond standard block rewards and transaction fees. The process begins when users submit transactions to a public **"mempool,"** a waiting area where block producers can observe pending trades and leverage this advance knowledge for profit.

This has fostered a sophisticated ecosystem with distinct roles. **Searchers** scan the mempool for profitable opportunities, **builders** construct optimized blocks to capture this value, and **proposers** (validators) select the most profitable blocks to add to the chain. This relationship has been formalized by systems like **MEV-Boost**, which creates a liquid market for block space.

### Common MEV Strategies

- **Arbitrage**: Profiting from price differences for the same asset across different exchanges.
- **Liquidations**: Claiming rewards for closing undercollateralized positions in DeFi protocols.
- **Front-running**: Copying a profitable user transaction and paying a higher fee to have it executed first.
- **Sandwich Attacks**: Placing trades before and after a user's large trade to manipulate the price and extract value.

**Frequent batch auctions** and **intent-based settlement** (e.g., CoW Swap, Uniswap X) mitigate sandwiching by removing continuous-time priority.

### MEV's Centralizing Pressure and Proposed Solutions

While MEV activities like arbitrage can enhance market efficiency and liquidations are a necessary function, the overall impact presents a fundamental tension between market mechanics and user fairness. MEV competition inflates gas prices for all users as bots bid aggressively for transaction priority. Furthermore, users often receive worse execution prices from front-running and sandwich attacks, effectively paying an **"invisible tax"** to sophisticated actors.

This dynamic creates significant **centralization pressures**, as success requires substantial capital and technical expertise. On Ethereum, this has led to concentration among builders, with recent research showing **Titan was ~32% of blocks with TC interactions**, and **~19% of blocks were produced by sanction-enforcing producers** (as of 2024-2025, methodologies vary).

To counter this, a decentralized block-building network called **BuilderNet** was announced in 2024 by Flashbots, Beaverbuild, and Nethermind. BuilderNet uses **Trusted Execution Environments (TEEs)** to allow multiple operators to share transaction order flow and coordinate block building while keeping the contents private until finalized. This architecture aims to create a more transparent and permissionless system for MEV distribution, moving away from the opaque, custom deals that define the current landscape. Beaverbuild is already in the process of transitioning its centralized builder to this new network, with more permissionless features planned for future releases.

**Order flow auctions (OFAs)** and **private orderflow** (e.g., MEV-Share, SUAVE, private relays, encrypted mempools) seek to return value to users and reduce harmful MEV. **Time-bandit attacks** (reorgs to capture MEV) are constrained by fast finality; research explores **MEV-smoothing** and **enshrined PBS**.

### Emerging Challenges: Cross-Domain MEV

A new frontier of value extraction, **Cross-Domain MEV**, is also emerging. This refers to arbitrage and other strategies executed across different blockchain networks, exploiting price differences between on-chain exchanges on separate chains. Researchers warn this could pose an **"existential risk"** to decentralization if sophisticated actors gain control over transaction ordering across multiple domains. The timing and latency of blockchain bridges are critical factors, enabling complex, multi-block MEV strategies that are even harder to mitigate. This highlights that as the blockchain ecosystem grows, the challenges of ensuring fair and decentralized value extraction will only become more complex.

Mitigations under study include **shared sequencing** across domains, **cross-domain batch auctions**, and **routing intents through OFAs**.


## Key Takeaways
- Data Availability is the core bottleneck for rollups; posting data dominates costs.
- Celestia separates DA/consensus with DAS + erasure coding, enabling light-client verification at scale.
- Rollups post blobs to DA layers and state commitments to settlement layers; trust splits across both.
- Alternatives: Ethereum blobs (EIP-4844), EigenDA (restaking), Validiums/DA committees, Avail.
- MEV arises from transaction ordering; roles split into searchers, builders, proposers via PBS/MEV-Boost.
- Harmful MEV (sandwiching) increases user costs; mitigations include batch auctions, intents, OFAs, and private orderflow.
- Centralization pressures in building spurred designs like BuilderNet and research into enshrined PBS.
- Cross-domain MEV is growing; shared sequencing and cross-chain auctions are active mitigation areas.
