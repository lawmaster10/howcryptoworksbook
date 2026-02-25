# Chapter II: The Ethereum Ecosystem

## Section I: Core Concepts

Chapter I introduced Bitcoin's breakthrough: digital scarcity without centralized control. Ethereum extends this concept by making computation itself programmable and decentralized.

This shift unlocked possibilities that didn't exist before. Decentralized exchanges let people trade tokens without intermediaries. Lending protocols let users earn interest or borrow money using only programs called **smart contracts**. NFT marketplaces create new forms of digital ownership. Notably, these applications work together seamlessly. A lending protocol can automatically interact with an exchange, creating financial products that emerge organically from the platform itself.

But power requires complexity. Bitcoin prioritized simplicity and security above all else. Ethereum chose a different path. It replaced Bitcoin's straightforward transaction model with an account system that tracks complex application state. It developed a dynamic fee system to manage computational resources. It underwent a technical transition from proof-of-work to **proof-of-stake**. And it spawned an entire ecosystem of scaling solutions to handle real-world usage.

Understanding Ethereum means grasping how these pieces fit together: how the fee system incentivizes efficient resource use, how proof-of-stake secures the network, and how Layer 2 solutions make the platform practical for everyday applications. This chapter will guide readers through these core mechanics, showing the engineering decisions that power today's significant experiment in decentralized computation.

### The Ethereum Virtual Machine

At Ethereum's core lies the Ethereum Virtual Machine (EVM), a computational engine that executes code across thousands of computers (called nodes) simultaneously. Unlike Bitcoin, which primarily transfers value, Ethereum runs smart contracts, transforming the network from a simple payment system into a programmable "world computer."

The EVM operates as a stack-based virtual machine, processing instructions like a stack of plates where you can only add or remove from the top. It uses low-level instructions called opcodes. These include operations like ADD, MULTIPLY, STORE, and CALL. When developers write smart contracts in high-level languages like Solidity or Vyper, compilers translate that code into EVM bytecode (a series of opcodes) that every Ethereum node can execute. This standardization ensures contracts behave identically whether running in New York, Singapore, or Dubai.

What distinguishes the EVM is its combination of deterministic execution with persistent state management. Every smart contract maintains its own storage space where it saves data between transactions. When someone interacts with a contract, like swapping tokens on Uniswap or borrowing from Aave, the EVM executes the relevant bytecode, reads and writes to storage, and updates account balances. Every node independently performs these same computations and verifies they reach identical final states. This process creates **decentralized consensus**: Ethereum becomes trustworthy without requiring trust in any single party, since thousands of independently run nodes all verify the same results.

Each operation consumes **gas**, a fee measured in computational work. Gas serves two critical purposes: it compensates node operators for executing computations and prevents spam by making every operation cost something. More complex operations require more gas, which explains why simple transfers cost less than deploying intricate smart contracts. This metering ensures no transaction runs indefinitely, mitigating resource-exhaustion attacks.

The gas mechanism aims to price operations roughly in line with their actual resource usage. Early attacks exploited underpriced operations, prompting Ethereum to adjust opcode costs over time. These adjustments increased prices for operations that proved too cheap relative to their computational demands, reducing opportunities for denial-of-service attacks and better reflecting underlying resource costs.

The EVM has evolved into a de facto standard extending far beyond Ethereum itself. Most **rollups** (Arbitrum, Optimism, Base) and many alternative L1s have adopted EVM compatibility, meaning they execute the same bytecode. This compatibility creates enormous value: applications like Uniswap and Aave deploy to these networks with minimal changes, while the entire infrastructure ecosystem (wallets like MetaMask, block explorers, developer tools, indexers) functions almost identically across EVM chains. New blockchains can bootstrap activity by inheriting Ethereum's mature tooling and attracting existing users and developers without requiring them to learn new paradigms. These network effects reinforce Ethereum's dominance.

This computational model explains Ethereum's scaling challenges. Since every full node replays every transaction in order, Ethereum functions as a globally replicated computer. Protocol parameters like gas limits and block times must remain conservative enough for ordinary machines to keep up. Pushing more computation on-chain risks raising hardware requirements and eroding the decentralization that makes the network secure.

Rollups and other scaling solutions address this constraint by moving most execution off Ethereum while using the base layer primarily for data availability and final settlement. They batch many off-chain transactions together, posting only compressed data and (in some designs) validity proofs back to Ethereum. This allows many users to share the gas cost of a single L1 transaction, dramatically lowering fees and increasing effective throughput while still inheriting Ethereum's security.

Understanding the EVM reveals both Ethereum's power (arbitrary programmable logic secured by neutral consensus) and its limitations. The base layer remains a fully replicated machine where every computation is verified everywhere, making raw throughput fundamentally scarce. Higher scale must therefore come from layering and smarter use of that scarce resource.

### Ethereum's Fee System

We've seen how the EVM measures computational work in gas. Now let's examine how Ethereum's fee system actually prices that gas and how it evolved to become more user-friendly.

Gas powers Ethereum's computational engine like fuel powers a car. Every operation, from sending ETH to a friend to executing a complex smart contract, consumes a specific amount of this computational fuel. A simple ETH transfer between regular wallets burns through 21,000 units of gas, while interacting with smart contracts requires proportionally more. Swapping tokens on Uniswap might use 150,000 gas, while deploying a new smart contract could consume millions.

When discussing fees, Ethereum users work with specific denominations (unit sizes). While wei represents the smallest possible unit of ether (1 ETH equals 1,000,000,000,000,000,000 wei), fee discussions typically happen in **gwei** (1 gwei equals 1,000,000,000 wei, or one billionth of an ether). This makes gas prices easier to discuss. Instead of saying "the gas price is 50,000,000,000 wei," people say "50 gwei."

A key development came with EIP-1559, which radically transformed Ethereum's protocol-level fee market. Before this August 2021 upgrade, users participated in a chaotic auction system, constantly trying to outbid each other for block space: you guessed a single gas price and hoped it was neither too low nor unnecessarily high. EIP-1559 introduced a new, more predictable default fee mechanism with two components: a dynamically adjusting **base fee** and a user-set tip. Most modern wallets use this mechanism by default. Legacy type-0 "gasPrice" transactions are still supported and behave more like the old auction, so the extra predictability is available but not strictly mandatory for all transactions.

Users set maxFeePerGas (the absolute maximum they'll pay per unit of gas) and maxPriorityFeePerGas (an optional tip to validators for faster inclusion) when submitting transactions. The actual gas price paid is calculated as the minimum of either your maximum fee or the sum of the base fee plus your priority fee. The total transaction cost equals the gas used multiplied by this effective gas price.

Each Ethereum block has a gas limit that defines its capacity: a maximum amount of gas that all transactions in that block can collectively consume. Since EIP-1559, the protocol targets using about half of that limit in each block and treats this target as “100% full” for pricing purposes. When demand spikes, blocks can temporarily expand up to roughly twice the target (up to the gas limit itself), creating so-called elastic blocks.

Historically, Ethereum used a 30 million gas limit (with a 15 million gas target). Since 2024-2025, validators have gradually raised this to around 45 million, and Fusaka’s EIP-7935 standardizes a 60 million default gas limit per block in client configs. The important rule remains the same: the target gas usage is always half the current gas limit, and blocks can stretch up to roughly twice that target during congestion.

The base fee is set algorithmically based on network congestion. When blocks use more than the target amount of gas (more than half the gas limit), the base fee rises by up to 12.5% in the next block. When they use less than the target, it falls by up to the same amount. High demand automatically increases prices; low demand decreases them through this self-balancing mechanism.

The most significant innovation is what happens to fees. Of the total fee paid, the portion covering the base fee (gas used multiplied by the base fee) gets burned, meaning it is destroyed forever and removed from circulation, introducing deflationary pressure on ETH's supply. Only the priority fee (the tip above the base fee) goes to validators. Any unused portion of your maxFeePerGas is refunded, not paid out. This gives users a way to incentivize faster inclusion during busy periods by offering higher tips without permanently overpaying for gas.

During periods of sustained demand, the base fee burn can exceed new ETH issuance from staking rewards, making the overall supply net deflationary (shrinking rather than growing). Higher network usage increases the burn rate, tightening supply and potentially supporting ETH's value. Since The Merge in September 2022, there have been extended periods where ETH supply has been deflationary. However, upgrades like Dencun and EIP-4844 also made L1 gas cheaper, which in turn reduced fee burn. Since 2024 there have been periods where ETH supply has turned net inflationary again despite the burn mechanism.

EIP-1559 reduced fee volatility and dramatically improved user experience by making fees more predictable. Users can set reasonable max fees without worrying about overpaying, and wallets can estimate costs more accurately. Importantly, this change modified how fees work without altering Ethereum's consensus mechanism (the system went through this upgrade during proof-of-work and kept it after transitioning to proof-of-stake). The upgrade introduced new validation rules that all nodes must enforce, including the base fee calculation algorithm and the burning mechanism. However, it didn't address all fee market concerns. Issues like transaction censorship (validators choosing to exclude certain transactions) remain active areas of research, with proposals like inclusion lists (rules forcing validators to include certain transactions) still being developed.

### How Ethereum Identifies Accounts and Assets

While understanding gas helps users manage transaction costs, knowing how Ethereum identifies accounts and assets is equally important for navigating the ecosystem effectively.

Ethereum's account model differs fundamentally from Bitcoin's UTXO model (explained in Chapter I). Bitcoin tracks ownership through chains of unspent transaction outputs that must be consumed and recreated with each transfer. Ethereum maintains persistent accounts with balances that get updated directly. Think of it like the difference between using cash (UTXOs that get exchanged) versus a bank account (a balance that increases and decreases). This architectural choice enables the complex state management that smart contracts require, allowing contracts to store data and maintain balances across multiple transactions without the complexity of tracking individual UTXOs.

Ethereum has two types of accounts. **Externally Owned Accounts (EOAs)** are regular user wallets controlled by private keys (like hot wallets or hardware wallets). Smart contract accounts are programmable accounts that execute code when triggered. Every participant in Ethereum (whether a person or a smart contract) has a unique address that serves as their public identifier.

These addresses look like cryptographic gibberish: a 40 character string of numbers and letters such as 0x742d35Cc6634C0532925a3b844Bc454e4438f44e. Behind this seemingly random sequence lies mathematics. For EOAs, the address represents the last 20 bytes of a cryptographic hash (a one-way mathematical function) of the account's public key. The public key is derived from your private key, so your address is mathematically linked to your key without revealing it.

The Ethereum Name Service (ENS) addresses this usability challenge by allowing users to register human-readable names like `alice.eth` that resolve to these hexadecimal addresses. This naming system works similarly to DNS for websites, making it easier to send funds and interact with accounts without copying and pasting long strings of characters.

Smart contracts also receive addresses when they're deployed, generated deterministically from the deployer's address and other parameters.

This distinction between EOAs and smart contracts is beginning to blur. Account abstraction proposals like EIP-7702 (introduced in Pectra) allow EOAs to temporarily delegate control to smart contract code, enabling features like sponsored transactions, batch operations, and improved key recovery without requiring users to migrate to entirely new account types.

With accounts and addresses established, Ethereum's next key development was creating standards that allowed different applications to work together effectively. The most important example is the ERC-20 token standard, which created a universal language for digital assets.

Before ERC-20, every new token was essentially a unique snowflake, requiring custom code for wallets and exchanges to support it. ERC-20 changed this by establishing a common blueprint: every compliant token must implement the same basic functions like transfer(), approve(), and balanceOf(). This seemingly simple standardization unleashed what many call the "Cambrian explosion" of DeFi.

Suddenly, developers could build applications that worked with thousands of different tokens without writing custom code for each one. A decentralized exchange could list any ERC-20 token, a lending protocol could accept any ERC-20 as collateral, and users could seamlessly move assets between different applications. This **composability** (the ability for different protocols to work together like Lego blocks) became one of Ethereum's defining characteristics, enabling complex multi-step operations that either complete entirely or revert with no partial execution. Chapter VII explores these DeFi applications in detail.

The ecosystem continued to evolve with additional standards: ERC-721 and ERC-1155 for NFTs (which Chapter XI explores), and various other token standards that extended Ethereum's capabilities. But all of this (the EVM, the fee market, the account system, the token standards) depends on thousands of validators agreeing on the state of the network. Ethereum's approach to achieving that agreement transformed fundamentally in 2022\.

## Section II: Ethereum Consensus and Staking

This section explores how Ethereum reaches agreement on the state of its blockchain. While Bitcoin uses Proof of Work to achieve consensus (as explained in Chapter I), Ethereum transitioned to a fundamentally different approach called Proof of Stake. Understanding this shift requires first examining how Ethereum's upgrade process works.

### How Ethereum Evolves: The EIP Process

That 2022 transformation happened through Ethereum's unique governance model. Unlike traditional software where a company decides what features to build, Ethereum evolves through a public, community-driven process centered on **Ethereum Improvement Proposals (EIPs)**. These formal proposals move through stages (Draft, Review, Last Call, and Final) with extensive technical review, security analysis, and testing on networks like Sepolia and Holesky before deployment to mainnet.

Core EIPs modify the protocol itself, requiring coordinated hard forks (backwards-incompatible protocol changes). ERC (Ethereum Request for Comment) proposals define application-level standards like ERC-20 tokens that make different applications compatible. Major upgrades bundle multiple EIPs together with names like Shapella (staking withdrawals), Dencun (blob transactions via EIP-4844), and Pectra (account delegation via EIP-7702).

This process intentionally prioritizes caution over speed. Changes to a system securing hundreds of billions of dollars require widespread coordination among thousands of node operators and thorough vetting to prevent catastrophic bugs. You will see EIP numbers referenced throughout this chapter. They represent the careful evolution that makes Ethereum both stable and capable of major transformations.

### The Great Transition: From Mining to Staking

The most significant transformation to emerge from this process was The Merge. September 15, 2022, marked a watershed moment in Ethereum history. On that day, The Merge was completed, a years-long engineering effort that transitioned the network from energy-intensive mining to a proof-of-stake system. The upgrade represented a reimagining of how Ethereum secures itself.

The transformation was unprecedented in scope. Bitcoin miners race to solve computational puzzles using large amounts of electricity. Ethereum's new system relies instead on **validators** who lock up their own ETH as collateral. These validators earn rewards for honest behavior and face severe penalties for malicious actions. The result? Ethereum reduced its energy consumption by over 99.9% while maintaining comparable security guarantees.

Beyond energy efficiency, The Merge restructured Ethereum's architecture itself: it separated Ethereum's execution layer (which processes transactions) from its consensus layer (which decides on block order and finality). This separation, embodied in the Beacon Chain, created a foundation for future scalability improvements that would have been impossible under the old mining system.

### How Ethereum Achieves Consensus

Ethereum's proof-of-stake system operates like a carefully choreographed dance, with thousands of validators working together in precise intervals to maintain network security.

Time in Ethereum moves in precise intervals: every 12 seconds marks a slot, and every 32 slots (about 6.4 minutes) forms an epoch. In each slot, the protocol randomly selects one validator to propose a new block using a cryptographic seed derived from the previous epoch, while hundreds of others provide attestations, which are cryptographic votes confirming that the proposed block follows all the rules.

The path to **finality** (the point where a transaction becomes irreversible) follows a two step process. First, a block becomes justified when it receives attestations from at least two thirds of validators. Then, in the following epoch, if another supermajority confirms that justification, the block becomes finalized. This process typically takes about 12.8 minutes. After finalization, reversing a transaction would require coordinated attacks triggering severe financial penalties called **slashing**, which scale with the number of validators involved.

Becoming a validator requires staking a minimum of 32 ETH to activate, but since the Pectra hard fork (EIP-7251), validators can now scale their effective balance (the amount of staked ETH that counts toward their voting power and rewards) up to 2048 ETH, reshaping the staking landscape. While 32 ETH remains the activation threshold per validator key, operators can now attach additional ETH to a single validator to increase its attestation weight, rewards, and penalties proportionally. This reduces operational overhead through fewer keys and attestations but concentrates stake and potential slashing risk per validator. The change reduces the incentive to run many 32 ETH validators. Large operators can consolidate into fewer, higher-stake validators, while solo stakers can continue running standard 32 ETH setups.

The system achieves efficiency through advanced cryptographic techniques. Ethereum uses BLS signatures, which allow thousands of individual validator signatures to be compressed into a single, compact proof. Instead of processing thousands of separate attestations, the network can verify the collective opinion of all validators with minimal computational overhead.

Security comes through slashing, the system's mechanism for punishing malicious behavior. Validators who break the rules (like proposing conflicting blocks or making contradictory attestations) face financial penalties. The base penalty is intentionally small: on the order of hundredths of an ETH for a 32 ETH validator and around half an ETH for a fully "scaled-up" 2048 ETH validator under the new Pectra rules. This means isolated mistakes aren't catastrophic. But correlated attacks are punished much more severely. When many validators misbehave together, a correlation penalty scales up with the share of the validator set that's slashed, and large coordinated attacks can destroy a substantial fraction of each participant's stake. The protocol also includes inactivity leaks that gradually drain the balances of offline validators during long network partitions, allowing the remaining active validators to regain a supermajority and finalize the chain.

### Liquid Staking

The capital requirements described above shaped the evolution of Ethereum's staking ecosystem. Stakers face a difficult choice: lock up tokens to help secure the network and earn rewards, or keep them liquid for other uses. Even though withdrawals became possible after the Shapella upgrade, exiting your stake isn't instant. You have to wait in a queue that can take days or even longer when the network is busy. The problem is clear: staked capital becomes locked up and can't be used in the broader decentralized finance (DeFi) ecosystem. You're forced to choose between earning staking yields and having the flexibility to lend, trade, or provide liquidity with your assets.

Liquid staking protocols solve this problem by collecting deposits from many users, staking them with network validators, and issuing tradeable **Liquid Staking Tokens (LSTs)** that represent your share of the staked pool plus earned rewards. This means you earn staking yields while holding a liquid, transferable token usable across DeFi protocols.

Two approaches dominate the space:

Lido is by far the largest LST provider, controlling over 85% of the market as of early 2026 and managing roughly 25% of all staked ETH. It issues stETH, a rebasing token whose balance automatically grows daily as staking rewards accumulate. In other words, the number of tokens in your wallet changes over time rather than each token’s price increasing. Lido uses a curated set of professional node operators (recently expanded to include permissionless participation) and relies on a committee that reports daily balance updates from the beacon chain to power the rebasing mechanism. This approach enabled Lido to scale rapidly and dominate the LST market.

Rocket Pool takes a more decentralized path. It's the second largest protocol with approximately 5% market share as of early 2026, enabling thousands of independent operators to run validators. It issues rETH, which works differently. Your token balance stays constant, but its exchange rate against ETH appreciates as rewards accumulate. The protocol allows operators to create validators with as little as 8 ETH of their own capital, with the rest coming from user deposits, making validator participation more accessible while maintaining permissionless entry.

Liquid staking offers clear advantages, but it also comes with risks you need to understand. Lido's dominance raises serious questions about protocol governance and network resilience. If too much staking power concentrates in one provider, it could threaten the security and decentralization of the underlying network. Smart contract vulnerabilities are another pressing concern. Today, most validator withdrawal credentials are managed off-chain, which limits a protocol bug's ability to directly drain validator balances. However, bugs can still break accounting, misroute rewards, or block withdrawals. If future upgrades shift more withdrawal control on-chain, the blast radius of such bugs could grow further.

Validator penalties from misbehavior or technical failures affect everyone in the pool. Finally, liquidity risk can surface during periods of market stress. LST tokens might trade below their true value (we saw this with stETH discounts in 2022), which creates potential losses if you need to exit your position quickly.

With consensus secured and staking economics established, Ethereum's remaining bottleneck is scale; hence the rise of Layer 2 rollups.

## Section III: Ethereum Scaling and Layer 2 Solutions

### The Rollup Revolution

Recall from the EVM section that every full node must process every transaction. This design choice, essential for decentralization and security, constrains throughput to what a typical node on consumer hardware can verify and propagate within a 12-second slot. The result is on the order of a few dozen simple transactions per second, far too slow for mainstream adoption. A single popular application can congest the entire network, sending gas fees soaring to hundreds of dollars per transaction during periods of extreme demand.

The solution cannot be to simply "make blocks bigger" or "process transactions faster." Raising gas limits or shortening block times would increase bandwidth, CPU, and storage requirements, quietly pushing slower nodes off the network. This would concentrate validation in the hands of fewer, more powerful operators and undermine decentralization. Ethereum's core developers therefore prioritize keeping node requirements low enough that anyone with reasonably affordable consumer hardware and a decent internet connection can participate in securing the network.

Rollups address this constraint by moving most computation off Layer 1 while anchoring security to Ethereum. Transactions execute on a separate Layer 2 chain that runs much faster and cheaper because it doesn't require every Ethereum node to re-run every step. The rollup then posts compressed transaction data (and, depending on the design, proofs or fraud-detection mechanisms) back to Layer 1, which provides data availability, dispute resolution, and final settlement.

This security inheritance only works fully when data availability lives on Ethereum itself. For a rollup to be truly secure, anyone must be able to reconstruct its state from data posted to Layer 1\. If transaction data disappears or becomes unavailable, users can't prove they own their funds or challenge invalid state transitions. Rollups that use external data availability (called validiums, since they validate transactions but store data elsewhere) sacrifice this guarantee and require additional trust assumptions.

A common criticism of the rollup scaling approach claims that L2s extract value from Ethereum by launching their own tokens, pulling investor attention and capital away from ETH. The concern breaks down into two main issues. First, users end up speculating on L2 tokens rather than ETH itself. Second, valuable revenues from **sequencers** (the entities that order and batch transactions on L2s) and transaction fees get captured at the rollup level instead of flowing back to Ethereum's base layer.

However, rollups that post their data to Ethereum still generate L1 fees and contribute to ETH's deflationary burn mechanism, especially as L2 usage grows. The choice of gas token matters here: some rollups denominate user gas in a native L2 token, others in ETH, but in all cases sequencers ultimately need to acquire ETH to pay for L1 data availability. This forces part of the system's revenue back into ETH demand. Additionally, factors like sequencer decentralization and how tightly a rollup's economics couple to Ethereum's settlement layer all determine whether value flows back to ETH holders or gets mostly captured at the L2 level.

The rollup ecosystem has evolved into two primary approaches, each making different compromises:

#### Optimistic Rollups: Trust but Verify

Optimistic rollups, exemplified by Arbitrum and Optimism, embrace an "innocent until proven guilty" philosophy. They optimistically assume all transactions are valid and immediately post new state updates to Layer 1\. This assumption allows for fast execution and low costs, but it comes with an important caveat: a challenge period of roughly seven days during which anyone can submit a **fraud proof** if they detect invalid transactions.

This security model balances speed against finality. While users enjoy fast, cheap transactions on the rollup itself, withdrawing funds back to mainnet requires patience. The seven day waiting period ensures that any fraudulent activity can be detected and reversed, but it means that optimistic rollups aren't ideal for users who need immediate access to their funds on Layer 1\.

However, the market has responded to this friction with third-party fast withdrawal services. Liquidity providers like Hop Protocol and Across Protocol will front users their funds on Layer 1 immediately, charging a fee for the convenience. These providers assume the risk during the challenge period. If a fraud proof invalidates the transaction, they bear the loss. Users who need speed pay a premium; those willing to wait can withdraw for free.

#### ZK Rollups: Mathematical Certainty

ZK rollups, including Starknet, zkSync, and Scroll, take an entirely different approach. Instead of assuming validity and waiting for challenges, they use **validity proofs** (advanced cryptographic techniques that mathematically prove the correctness of every batch of transactions). These rollups first commit transaction data to Layer 1, then submit a proof that validates the entire batch.

These zero-knowledge proofs are advanced mathematical techniques. They allow a rollup to prove that thousands of transactions were processed correctly without requiring Layer 1 to re-execute them. The proof provides strong cryptographic certainty about the validity of an entire batch (though like all cryptography, this relies on certain mathematical assumptions being sound).

Different ZK rollups use different proof systems, each with distinct properties. Scroll uses pure SNARKs, generating tiny proofs of just a few hundred bytes that minimize L1 costs, but requiring a trusted setup where initial parameters must be securely generated and destroyed, like destroying the mold after casting a master key so nobody can secretly mint more keys later. Starknet uses STARKs, producing much larger proofs of hundreds of kilobytes, but offering stronger security properties: no trusted setup, transparency, and better resistance to potential future quantum computers. zkSync takes a hybrid approach, generating STARK proofs internally for security, then wrapping them in a SNARK for cost-efficient on-chain verification. This still requires a trusted setup for the SNARK wrapper.

The advantage over optimistic rollups is compelling. ZK rollups avoid the week long withdrawal delays that plague optimistic systems. Once a validity proof is verified on Layer 1, users can access their funds without any challenge period (though they still wait for proof generation and verification, which typically takes minutes to hours depending on system load). However, this security comes at a cost. The cryptographic machinery required to generate these proofs is more complex and computationally intensive than optimistic approaches.

#### Additional Rollup Considerations

Beyond the core differences between optimistic and ZK approaches, several other dimensions matter when evaluating rollups.

In practice, most rollups currently rely on centralized sequencers to achieve the fast confirmations users expect. Unlike Ethereum mainnet, which distributes block proposal across thousands of validators, these rollups use a single entity to order transactions and produce blocks. While this represents a temporary engineering choice rather than a permanent design, it introduces potential censorship risks and single points of failure. Leading rollups are actively developing solutions to eliminate sequencer centralization while preserving performance. Shared sequencing networks distribute ordering responsibility across multiple parties, creating redundancy without sacrificing speed. Sequencer rotation systems periodically change which entity handles transaction ordering, preventing long-term control by any single party. Inclusion lists require sequencers to include certain transactions within specified timeframes, making censorship more difficult. Preconfirmations allow sequencers to make soft commitments about transaction inclusion before formal consensus, improving user experience while maintaining reversion options through slashing mechanisms and dispute windows.

Proof systems continue to evolve in maturity and coverage. Many ZK-rollups still operate with "training wheels" (additional security mechanisms that can pause or override the system during early phases while the technology matures). Optimistic rollups depend on robust fault proof systems that are still being refined and battle-tested. Fee structures combine L2 execution costs with L1 data availability and inclusion fees. Additionally, rollups operate in different data availability modes. True rollups post all data to Ethereum, while validiums use external data availability or hybrid approaches that trade cost savings against stronger trust requirements.

Not all rollups prioritize decentralization equally. Some projects deliberately embrace centralized architectures to achieve consumer-app-like responsiveness. MegaETH, for example, uses a single active sequencer and 10-millisecond “miniblocks” to target millisecond-level latency and on the order of 100,000 transactions per second. This design accepts risks like single points of failure and potential censorship in exchange for high speed. Such approaches reveal the inherent tensions in blockchain design: decentralization, security, and performance exist in constant competition, with different applications requiring different balances.

### Solving the Data Availability Challenge

With rollups defined, the dominant cost driver becomes data availability. Before March 2024, rollups had to store their data permanently in Ethereum's expensive execution layer, making data availability costs account for 80-95% of total rollup fees.

EIP-4844, implemented in the Dencun upgrade, fundamentally changed this economics by introducing blob-carrying transactions. EIP-4844 introduced **blobs** with a separate fee market and temporary retention (\~18 days), cutting rollup DA costs. These blobs are large packets of data (about 128 KB each) that live temporarily on Ethereum's consensus layer before being automatically pruned, establishing a separate, much cheaper data market specifically designed for rollups.

The system maintains security through KZG commitments, which are cryptographic fingerprints that uniquely identify each blob's contents. Imagine rollups renting billboard space on mainnet: they paste a huge poster (the blob) that stays up for roughly 18 days, then the city takes it down. The city keeps only a sealed, signed thumbnail that uniquely commits to the poster (the KZG commitment). Later, anyone can verify a specific square of that poster with a tiny receipt (a proof) without the city storing the full poster forever.

Through this design, Ethereum created two separate fee markets: blob space operates with its own base fee mechanism (similar to regular gas pricing), while normal transaction fees continue unchanged. With Pectra, EIP-7691 raised blob limits (target 3→6, max 6→9 per block) and made blob fees fall more aggressively when blobs are underused, further reducing costs for rollups while keeping prices responsive without overshooting.

This design is the first step toward full danksharding, Ethereum's long-term vision for massive data availability scaling. KZG commitments enable nodes to verify blob integrity while remaining forward-compatible with future upgrades that will let even resource-constrained devices verify data availability by checking only small samples rather than downloading everything.

#### Alternative Data Availability Solutions

For applications requiring even lower costs than Ethereum's blobs provide, several alternative Data Availability (DA) layers have emerged. Each makes different security compromises to achieve cost reduction. Understanding these design choices is essential for evaluating which rollups to use.

Celestia represents the most ambitious alternative. It's a specialized blockchain that provides consensus and data availability only, without execution. Its key innovation is Data Availability Sampling, which allows even devices with limited resources to gain high confidence that full block data was published by checking only small, random pieces rather than downloading everything. The system also lets different rollups efficiently prove their data was included without downloading irrelevant information from other rollups. Security relies on validators and an honest majority of independent samplers, with full nodes able to produce fraud proofs if data is incorrectly encoded.

EigenDA leverages Ethereum's restaking ecosystem (described in Section IV) to provide high-throughput data availability. A disperser coordinates the encoding and distribution of data across operators who attest to its availability. Throughput can be high, but security depends on the value restaked by operators and the specific quorum assumptions of each deployment.

Validium and committee-based systems take a different approach entirely, keeping data off-chain under the control of a committee or bonded set of operators. This can be cheaper than on-chain alternatives but weakens security guarantees since data availability isn't enforced by Layer 1 protocol rules.

Many rollups operate in hybrid modes, posting state commitments to Ethereum while using external data availability for the bulk of their data, or switching between different DA providers based on market conditions.

The data availability landscape continues to evolve rapidly, with new solutions emerging and existing ones improving their efficiency and security models. As rollups mature and user adoption grows, the choice of data availability solution will likely become as important as the choice of consensus mechanism itself.

## Section IV: Restaking

Rollups multiply Ethereum's transaction capacity by moving computation off-chain. Proof-of-stake enabled a different kind of multiplication: the ability to reuse staked capital across multiple protocols simultaneously. This innovation, called **restaking**, represents a new frontier in capital efficiency with its own set of risks and rewards.

### The Core Mechanism

EigenLayer pioneered this approach by creating a system where validators can opt in to secure **Actively Validated Services (AVSs)**. These are external protocols that need the kind of security that comes from having real money at stake. For native restaking, validators point their withdrawal credentials to an EigenPod and delegate to an operator. Alternatively, liquid staking token holders can deposit their tokens into EigenLayer strategies. Either way, participants commit to follow the rules of their chosen AVSs, and breaking those rules means facing additional slashing penalties on top of any Ethereum-level punishments.

Multiple protocols can now tap into Ethereum's massive validator set and the billions of dollars they have at stake. This provides shared security rather than building separate systems from scratch. AVSs cover a wide range of applications: data availability layers like EigenDA, oracle networks that provide price feeds, cross-chain bridges, rollup sequencers, and automated keeper networks that maintain DeFi protocols. Each AVS defines its own slashing conditions, the specific rules validators must follow to avoid penalties. A data availability service might require validators to prove they're storing certain data, while an oracle network might slash validators who submit price feeds that deviate too far from consensus.

### Technical Architecture

EigenLayer's design reflects careful consideration of how multiple protocols and validators interact. The architecture separates concerns into distinct layers that enable flexible composition while maintaining clear security boundaries.

Strategy contracts handle deposits and withdrawals for ERC-20-based restaking. When users deposit LSTs or other supported tokens, these strategies track ownership and manage the underlying assets. Each strategy represents a different restaked token: one for stETH, another for cbETH, EIGEN, and so on. Native restaking is tracked separately through EigenPods, contract instances that hold validator withdrawal credentials and account for restaked beacon-chain ETH. This modular split lets EigenLayer support both liquid staking derivatives and native staking without one monolithic contract trying to handle every asset type.

Slashing contracts enforce each AVS's specific rules independently. This separation is crucial: it prevents bugs in one AVS's slashing logic from affecting other services or compromising the core deposit/withdrawal mechanisms. When an AVS needs to slash a misbehaving operator, it interacts only with its own slashing contract, which then coordinates with the core system to execute penalties.

The system enables delegation, allowing users who don't want to run validator infrastructure to stake through professional operators. Delegators retain control over their withdrawal rights and can exit and delegate to a different operator after serving the required withdrawal delay, but they also inherit the operator's performance and slashing risks. Operators can signal their commission rates and which AVSs they support, creating a marketplace where delegators can choose based on expertise, fees, and risk profiles.

Different AVSs employ varying proof systems depending on their security needs. Some rely on fraud proofs that assume honest behavior unless challenged. If someone detects invalid behavior during a challenge window, they can submit evidence that triggers slashing. Others use validity proofs based on zero-knowledge cryptography that mathematically guarantee correctness before any state change occurs. Still others depend on committee signatures from trusted parties, which are faster and simpler but introduce trust assumptions about committee honesty and availability.

EigenLayer's security model includes veto committees as an extra layer for critical slashing decisions. Rather than allowing immediate, automated slashing for all violations, some conditions require committee approval. This prevents hasty or incorrect penalty enforcement. Imagine a bug in an AVS that incorrectly flags honest behavior as malicious. The veto committee can pause the slashing, investigate the issue, and prevent unjust penalties. However, this introduces governance risk and potential delays in enforcing legitimate slashing. The exact veto-committee design and implementation have been evolving alongside the rollout of slashing, so details may change over time.

Perhaps most intriguingly, EigenLayer introduces intersubjective slashing, where some violations can’t be proven purely on-chain and instead rely on shared human judgment (social consensus) to decide when to slash. Consider an oracle AVS where validators should report accurate price data. If a validator reports an obviously wrong price (claiming ETH trades at $1 when all exchanges show $3,000), the violation is clear to humans but hard to prove on-chain without introducing centralized price feeds. Intersubjective slashing allows such cases to be resolved through social consensus and governance processes. Token holders or designated committees vote on whether slashing should occur based on off-chain evidence. This flexibility enables the system to handle complex, real-world scenarios that pure algorithmic approaches might miss, but it introduces governance risks and the potential for contentious decisions that divide the community.

### Current Economic Reality

On paper, restaking looks like a clean win: more protocols can "rent" Ethereum's security instead of bootstrapping their own validator sets. In practice, the system is still early and somewhat lopsided. A large amount of ETH and liquid staking tokens has been restaked into EigenLayer and liquid restaking wrappers, but only a subset of AVSs see meaningful real-world demand today. Most of the incremental rewards restakers currently earn come from incentive programs, airdrops, and protocol token emissions rather than durable fee revenue generated by AVSs themselves. For now, restaking behaves less like a mature cash-flow asset class and more like a leveraged bet on the future success of the EigenLayer ecosystem.

This timing mismatch matters significantly. The extra liabilities are live today (additional smart contract risk, governance risk, and correlated slashing exposure across multiple AVSs), while the long-run fee markets that are supposed to compensate restakers are still being designed and battle-tested. When you hear claims about "reusing security" or "unlocking capital efficiency," it's worth remembering that many restakers are currently taking on large tail risks for economics that depend on ongoing incentives and a still-uncertain AVS adoption curve.

### The Risk Landscape

Understanding the technical architecture reveals why restaking carries significant risks. The most pressing concern is correlated slashing risk. When validators secure multiple AVSs simultaneously, a single mistake or malicious action can trigger penalties across all services at once, amplifying potential losses far beyond standard Ethereum staking. This makes AVS risk assessment essential, since each service brings its own slashing conditions, upgrade mechanisms, and governance structures that validators must understand and trust.

Choosing the right operator becomes pivotal in this environment. Most restakers delegate their validation duties to professional operators who must maintain infrastructure for multiple protocols at once. Poor operator performance or malicious behavior doesn't just affect one service; it impacts all delegated stake across every AVS that operator supports.

Withdrawal delays can extend well beyond Ethereum's standard unbonding periods. EigenLayer adds its own roughly two-week escrow period (currently about 14–17 days depending on the contract version) on top of Beacon Chain exit timing. Individual AVSs or LRT (liquid restaking token) protocols may impose additional withdrawal restrictions on top of this.

The liquid restaking ecosystem introduces systemic risks that compound on top of the liquid staking risks discussed earlier. Liquidity cascades could emerge if LRT tokens lose their peg to underlying ETH, potentially forcing mass withdrawals that create destructive feedback loops across the entire restaking ecosystem. There's also basis risk between the underlying ETH staking yields and LRT token prices, adding complexity for users who expect predictable returns. When you layer restaking on top of liquid staking protocols like Lido or Rocket Pool, you're compounding multiple layers of smart contract risk, economic assumptions, and potential failure points.