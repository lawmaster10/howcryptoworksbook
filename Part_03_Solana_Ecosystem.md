# Part III: The Solana Ecosystem

## Chapter 10: Architecture and Execution

- Solana uses an account-based model where programs are stateless BPF executables and state lives in separate data accounts owned by programs.
- Same-slot atomic composability across the single shard allows applications to compose synchronously without cross-domain bridging.
- Transactions declare all read and write accounts up front, enabling Sealevel to execute non-overlapping transactions in parallel across CPU cores.
- Accounts can be rent-exempt by holding minimum lamports; otherwise they may pay rent, though most production accounts target rent-exempt status.
- Addresses are base58-encoded Ed25519 public keys. Program Derived Addresses (PDAs) are off-curve, have no private key, and let programs assert authority without custodial keys.
- Versioned transactions support Address Lookup Tables (ALTs) to compress long account lists for complex cross-program interactions.

## Chapter 11: Transactions, Fees, and UX

- A small base fee is charged per signature; additional priority fees are optional and based on requested compute units (CUs) via the compute budget.
- A transaction includes a message (account list, instructions, recent blockhash) and the required Ed25519 signatures; durable nonces allow long-lived submissions.
- Compute units cap per transaction; users can attach a compute budget and pay a priority fee per compute unit to improve inclusion under load.
- After SIMD-0096, 100% of priority fees flow to validators, while base fees are partially burned; local fee markets price congestion at the account level to reduce hotspots.
- Account locks prevent conflicting writes inside a block; conflicting transactions are retried or delayed by the scheduler.
- Preflight simulation and program logs provide strong developer ergonomics and safer UX before on-chain execution.

## Chapter 12: Consensus, Scheduling, and Networking

- Sub-second slots and a deterministic leader schedule enable rapid confirmations.
- Solana operates without a global public mempool; transactions are forwarded to current and upcoming leaders (Gulf Stream).
- Turbine propagates blocks as shreds with erasure coding for reliable reconstruction; data availability is integrated at L1 rather than via separate blobs.
- Proof of History provides a verifiable cryptographic clock; Tower BFT (stake-weighted PBFT) finalizes blocks using PoH as a source of ordering.
- Leaders are pre-scheduled for short slots; an epoch (~2-3 days) fixes the leader schedule. Stake delegation, commissions, and warmup/cooldown govern staking dynamics.
- Gulf Stream forwards transactions directly to upcoming leaders, reducing mempool latency and improving cache locality.
- QUIC underpins transport with stake-weighted QoS; Turbine shards block propagation to reduce bandwidth and curb spam.

## Chapter 13: MEV and Block Building

- Jito enables sidecar block building with bundle auctions; searchers submit bundles with tips, and validators integrate tips into blocks for additional revenue.
- Bundle simulation and private order flow reduce sandwich risk; priority fees and bundle tips jointly determine ordering and inclusion latency.
- Liquid staking derivatives (e.g., JitoSOL) share block-building revenue with stakers, similar in spirit to Ethereum's MEV-Boost but within Solana's monolithic design.

## Chapter 14: Developer Stack and Standards

- Token-2022 supports features like transfer hooks in addition to transfer fees, interest-bearing mints, and metadata pointers.
- Programs are typically written in Rust and compiled to BPF; the Anchor framework supplies IDLs, account validation, PDAs, and ergonomic cross-program invocations (CPIs).
- The Upgradeable Loader supports controlled program upgrades; sysvars (e.g., clock, rent, instructions) expose read-only protocol state.
- Tokens use SPL Token mints and token accounts; Associated Token Accounts standardize ownership. Token-2022 adds extensions such as transfer fees, interest-bearing mints, metadata pointers, and permanent delegates; confidential transfers are under active development.
- Metaplex standards define NFT metadata and verified collections. State compression uses concurrent Merkle trees with off-chain storage to make large asset sets economical.

## Chapter 15: Performance, Clients, and Tradeoffs

- Sealevel's parallel runtime scales with core count when account conflicts are minimized, favoring high throughput and low latency.
- Client diversity is improving via Firedancer (Jump), an independent, high-performance validator client targeting major throughput gains and resiliency.
- Recommended validator hardware (e.g., 256 GB RAM, high-end networking) raises entry costs; the leader schedule and builder markets introduce centralization pressure.
- Historical outages have been mitigated by networking upgrades (QUIC, Turbine), runtime fixes, and the push for client diversity; bridges such as Wormhole and Circle CCTP connect Solana to EVM ecosystems and introduce cross-chain risk.

## Chapter 16: Use-Case Fit

- Choose Solana for low-latency, high-throughput apps needing chain-wide, same-slot atomic composability (e.g., CLOB DEXs, real-time payments, on-chain gaming).
- Design around explicit account access, compute budgets, and priority fees for predictable performance under load.

## Key Takeaways

- Solana is a monolithic, high-throughput L1 that combines PoH + Tower BFT with Sealevel parallelism for low-latency execution.
- Programs are stateless executables; state lives in accounts. PDAs enable authority without private keys and make composition via CPIs straightforward.
- Transactions declare read/write sets up front, enabling concurrency; fees combine a base component with priority pricing per compute unit and local fee markets.
- The networking stack (QUIC, Turbine, Gulf Stream) reduces latency and improves propagation; Jito's builder market captures MEV while sharing revenue with validators and stakers.
- Performance is strong, but hardware demands and builder dynamics create centralization risks; client diversity and ongoing network upgrades aim to improve robustness.
