# Chapter X: Hyperliquid

## Section I: Road to Domination

The decentralized perpetuals market evolved through distinct phases, each attempting to solve the speed-decentralization dilemma differently. **Synthetix** pioneered synthetic perps with pooled debt but suffered from oracle latency and lack of adoption. **dYdX** popularized orderbook perps but struggled with retaining market share against competitors.

### The Great Reversal: How Hyperliquid Dethroned dYdX

In one of the most dramatic competitive reversals in DeFi history, **dYdX's share of perp DEX volume fell from 75% in January 2023 to 7% by December 2024**, while newcomer **Hyperliquid rose to nearly 70% in December 2024)**. This transformation occurred despite dYdX's seemingly unassailable position as the established leader with years of market dominance.

**The roots of dYdX's failure can be traced to flawed strategic choices that made it susceptible to being overtaken.** Most critically, the project's tokenomics offered limited value to users. The original v3 version, built on StarkEx, directed all trading fees to dYdX LLC with no direct benefit to token holders. Even after migrating to v4 as a Cosmos-based appchain, the protocol's fee structure remained problematic. Trading and gas fees flowed to validators and DYDX stakers in USDC creating no buy pressure for the native token. When the buyback program finally launched in March 2025 (presumably as a response to Hyperliquid), it only captured 25% of fees and staked the repurchased tokens rather than burning them creating a much weaker value accrual mechanism than traditional buyback-and-burn models.

**Hyperliquid took the opposite approach, aligning incentives from day one.** The platform conducted one of crypto's largest airdrops, distributing 31% of HYPE's total supply to over 90,000 users with zero VC allocation, minimizing sell pressure. The airdrop's initial value exceeded $1B, with HYPE trading around $4 at launch in November 2024 before surging to nearly $60 by September 2025. More importantly, Hyperliquid's tokenomics implement direct value capture through aggressive buybacks, directing approximately 99% of trading fees toward HYPE purchases. This creates an unusually tight link between trading volume and token demand, essentially making HYPE a claim on future protocol cash flows, a mechanism more direct than typical governance tokens, which often struggle to capture value. Fee discounts stem primarily from volume and referral tiers rather than staking requirements alone.

**While Hyperliquid refined its value proposition, dYdX was stumbling through a costly technical transition.** The migration to v4 introduced user friction through complex bridging requirements and increased latency to ~1-second block times, precisely when speed became paramount. The timing proved disastrous, diverting critical resources to the overhaul just as Hyperliquid gained momentum.

**This created an opening that Hyperliquid exploited with superior technology.** Built as a custom L1 using proprietary HotStuff consensus, the platform achieved sub-second transaction finality with a median of 0.2 seconds. Most remarkably, it maintained a fully on-chain order book, something previously thought impossible without sacrificing speed. Unlike dYdX's hybrid approach, every bid, ask, and cancellation was recorded on-chain with transparent depth and zero gas fees for trading.

**The market responded immediately and decisively.** By August 2024, Hyperliquid's monthly volume first overtook dYdX. The gap then widened dramatically: by January 2025, Hyperliquid processed $200B while dYdX managed just $20B. In second half of 2025, Hyperliquid is in the league of its own and frequently surpasses $300B in monthly volumes reaching about 15% of Binance's perp volume.

This reversal demonstrates that in crypto's fast-moving markets, superior user experience combined with aligned tokenomics can rapidly overcome established market positions, even when the incumbent enjoys years of advantage and institutional backing.

## Section III: HyperBFT and EVM

Hyperliquid built **HyperCore**, a bespoke L1 blockchain optimized for maximum speed and developer accessibility. The architecture involves two key decisions that create their own trade-offs.

### Consensus Layer: HyperBFT

**HyperBFT** powers the consensus layer, drawing inspiration from HotStuff to achieve fast finality under standard Byzantine assumptions (more than two-thirds honest validators). The system organizes block production through deterministic leader schedules, with epochs spanning roughly 100,000 rounds (approximately 90 minutes). This design prioritizes consistent, predictable performance over the variable block times common in other chains.

The speed gains come with centralization risks inherent to leader-based systems. If a designated leader misbehaves or goes offline, they can temporarily censor transactions until the next rotation. While validator rotation and monitoring mitigate this risk, it represents a meaningful trade-off compared to leaderless consensus mechanisms.

#### Validator Economics

To become an active validator, each participant must self-delegate at least 10,000 HYPE tokens. Active validators earn the right to produce blocks and receive rewards based on their total delegated stake.

Validators can charge delegators a commission on earned rewards. However, to protect delegators from exploitation, commission increases are strictly limited, validators can only raise their commission if the new rate remains at or below 1%. This prevents validators from attracting large amounts of stake with low commissions, then dramatically increasing fees to take advantage of unsuspecting delegators.

One-day delegation locks and seven-day unstaking periods balance validator commitment with capital liquidity, though these parameters create their own trade-offs between security and flexibility.

### Execution Layer: HyperEVM

**HyperEVM** addresses the accessibility challenge by providing full EVM compatibility, using **HYPE** as the native gas token. This allows existing Ethereum wallets, tools, and developer workflows to integrate seamlessly, a crucial factor for adoption.

#### Collateral System

**USDC serves as collateral on Hyperliquid.** All perpetual positions use USDC as collateral, creating a unified margin system that simplifies risk management and capital efficiency. The platform's dominance in attracting capital is evident in its nearly $6 billion in bridged USDC from Arbitrum.

In Settember 2025, Circle announced it is launching a native version of USDC on Hyperliquid, starting with the HyperEVM network and expanding to HyperCore later. Circle also invested in HYPE tokens, making it a direct stakeholder in the platform. This development comes shortly after Hyperliquid held a competition to select an issuer for its native USDH stablecoin, which was won by Native Markets.

### Tradable Products

Hyperliquid offers three main trading products: **perps** (standard perpetual futures), **hyperps** (pre-launch perps that use internal pricing instead of external oracles), and **spot** trading on fully on-chain order books. The platform also has upcoming features like premissionlessly deployed perps (HIP-3).

**Listing mechanisms vary by product type.** Spot listings require winning Dutch auctions to deploy HIP-1 tokens on HyperCore, then creating trading pairs through additional auctions. Perp listings are currently curated by the team with community input, though they're moving toward permissionless deployments via HIP-3. Hyperps remain curated and are specifically designed for assets without reliable external price feeds.

**All spot assets trade as HIP-1 tokens** on HyperCore's L1, regardless of their origin. This includes bridged assets like Bitcoin, when you deposit BTC or SOL, it becomes a HIP-1 representation that trades on the on-chain orderbook, then can be withdrawn back to the Bitcoin or Solana blockchain

Non-EVM assets like Bitcoin and Solana use **Unit's lock-and-mint bridge**, while EVM-based assets like USDC from Arbitrum use Hyperliquid's native validator-signed bridge. For Bitcoin, users send native BTC to a deposit address monitored by Unit. Once confirmed on the Bitcoin blockchain, Unit mints the corresponding HIP-1 token representation on HyperCore that can be traded. Withdrawals work in reverse. The HIP-1 token is burned and Unit releases the native BTC back to the user's address. 

Hyperps are used primarily for trading perps of tokens before they are launched, either to speculate or hedge price of farmed proceeds. Hyperp prices remain more stable and resist manipulation compared to standard pre-launch futures. The system also provides greater flexibility, the underlying asset or index only needs to exist when the contract settles or converts, not throughout the entire trading period.

Funding rates play a crucial role in hyperp trading. When prices move strongly in one direction, the funding mechanism will heavily incentivize positions in the opposite direction for the following eight hours. This creates both opportunities and risks that traders must account for.

In August 2025, four coordinated whales executed market manipulation on Hyperliquid's XPL hyperps, profiting approximately $47M while causing over $60M in trader losses and wiping out $130M in open interest. The attack exploited Hyperliquid's reliance on a thin, isolated spot price feed by using just $184k to artificially inflate XPL's spot price nearly eightfold, which caused the futures price to spike from $0.60 to $1.80 in minutes and triggered cascading liquidations of short positions. While technically not an exploit since it operated within the protocol's design, the attack exposed critical vulnerabilities in hyperps. This prompted Hyperliquid to implement emergency safeguards including 10x price caps. 

Full on-chain verifiability means positions and liquidation thresholds can sometimes be inferred from public state and trading behavior. That visibility improves auditability and market integrity, but it also makes clustered liquidations easier to target: adversaries can strategically push mark prices through known liquidity-light levels to trigger cascades, and impose outsized losses on passive participants (including HLP) during stress. Mitigations include tighter per-asset risk limits and position caps, anti-manipulation bands around liquidation prices, staggered or batched liquidation flows, and circuit breakers. 

## Section IV: The HLP Design

Fast execution means little without deep liquidity. Traders need tight spreads, minimal slippage, and reliable liquidation mechanisms, requirements that have historically favored centralized exchanges with dedicated market makers. Hyperliquid's solution creates new trade-offs between liquidity provision and risk concentration.

**The Hyperliquidity Provider (HLP)** represents Hyperliquid's most innovative design choice: a community-owned vault that simultaneously provides market-making services and handles liquidations. Depositors contribute capital to HLP and share in its profit and loss, creating a decentralized market-making system that doesn't rely on external firms.

This design solves several problems at once. HLP provides consistent liquidity across all markets, handles liquidations efficiently (crucial for leveraged trading), and distributes market-making profits to the community rather than extracting them to external firms. The system internalizes much of the trading flow, reducing the need for external counterparties.

However, this concentration creates meaningful risks. During extreme volatility, HLP depositors bear the losses from adverse selection and liquidation cascades. While HLP isn't the sole counterparty on the CLOB (anyone can post liquidity), it provides core baseline liquidity across markets and performs liquidations, creating concentration risk that traditional market-making structures distribute across multiple firms.

The **JELLY manipulation** in March 2025 demonstrated how vault-based systems can suffer losses from coordinated attacks. Attackers opened large leveraged positions ($4.5M short, two $2.5M longs) on a low-liquidity token JELLY, then manipulated the liquidation process while simultaneously pumping the token's price 250% on Solana. This created a $12 million unrealized loss that threatened the protocol's solvency. Validators had to make an emergency intervention, overriding the oracle price to prevent collapse, while the team quickly implemented fixes including better position size limits, improved liquidation mechanisms, and enhanced governance controls. All traders were compensated, but the incident exposed significant vulnerabilities in the platform's risk management architecture.

## Section VI: The Governance Balance

As Hyperliquid matured, it faced a classic DeFi dilemma: how to balance permissionlessness while maintaining quality and managing risk. While initially starting off relatively centralized, the protocol now relies on a governance system centered around voting on proposals.

**Hyperliquid Improvement Proposals (HIPs)** govern platform evolution, with each proposal addressing specific aspects of permissionless expansion:

**HIP-1** established a native token standard with a 31-hour Dutch auction mechanism, allowing anyone to list spot tokens. This democratizes token launches while using a 31-hour Dutch auction to set deployment gas/ticker costs, which raises the bar for drive-by launches since the auction format naturally selects for tokens with genuine demand.

**HIP-2** introduced automated "Hyperliquidity" for spot pairs against USDC, ensuring baseline liquidity for newly listed HIP-1 tokens. This solves the chicken-and-egg problem where tokens need liquidity to attract traders, but need traders to justify liquidity provision.

**HIP-3** (only live on testnet) aims to make perpetual markets permissionless, subject to a 1 million HYPE staked requirement by the deployer. Builders receive a share of fees in return. This creates strong incentives for responsible listings while generating meaningful cost for spam or low-quality markets.

The 1 million HYPE requirement effectively limits perpetual launches to serious participants while aligning their incentives with market success. However, builders face **validator-driven delisting** and potential **stake slashing** for malicious or unsafe operation, effective for quality control but can discourage experimentation.

This governance structure reflects a sophisticated understanding of platform dynamics: pure permissionlessness can lead to spam and poor user experience, while excessive gatekeeping stifles innovation. The stake-based approach creates market-driven quality control.

## Section VII: Road to Decentralization 

Building in DeFi is fundamentally about balancing performance and decentralization, a tradeoff where you can rarely optimize for both simultaneously. Generally, successful protocols start off more centralized to achieve the speed and reliability needed for adoption, then gradually decentralize over time as they mature and their infrastructure becomes more robust.

Hyperliquid faces persistent criticism around several centralization vectors that critics argue undermine its decentralized positioning. The most prominent concern centers on validator control, where the Hyper Foundation reportedly controls approximately 81% of staked HYPE through its own validators. This concentration could theoretically allow a single entity to halt or steer the chain, raising questions about the protocol's resistance to censorship or coordinated control.

The validator experience itself has drawn significant scrutiny. The protocol relies on closed-source node software, forcing validators to run what critics describe as a "single binary" with limited documentation. Validators have publicly complained that this arrangement creates a "blind signing" scenario where they cannot inspect the code they're running, leading to frequent jailing incidents and making it difficult to assess risks independently.

The validator selection process has also faced criticism for being opaque, with reports of low rewards relative to self-bonding requirements and the emergence of a testnet HYPE black market. These dynamics raise questions about equitable access to validator seats and whether the system privileges insiders over independent operators.

Infrastructure dependencies present additional centralization risks that have manifested in real-world disruptions. Hyperliquid's architecture relies heavily on centralized APIs for both validator operations and user access. Validators reportedly need to call Hyperliquid-operated APIs to recover from jailing, while users depend on these same API servers to submit transactions and access market data.

This dependency became acutely apparent during a July 2025 incident when API traffic spikes caused 37 minutes of trading disruption. The outage effectively froze user interactions despite the underlying blockchain continuing to produce blocks, highlighting how centralized infrastructure can create single points of failure even when the consensus layer remains operational.

The bridge architecture adds another layer of centralization concerns. Withdrawals depend on permissioned 4-validator sets on Arbitrum (commonly summarized as 3-of-4 for the hot set), concentrating withdrawal authority in a small group of designated actors rather than being secured by the broader L1 staking consensus. This arrangement creates potential risks around fund security and withdrawal censorship if those permissioned validators were to collude or become unavailable.

Critics point to the JELLY token incident as evidence of discretionary control, where validators overrode market outcomes by delisting the token and forcing settlement. While this may have protected users from a problematic asset, it demonstrated that the protocol retains significant interventionist capabilities that run counter to decentralized ideals.

Hyperliquid has acknowledged these concerns and indicated plans to open-source code and decentralize infrastructure over time. However, critics argue that the current centralized dependencies create meaningful risks around censorship, single points of failure, and discretionary control that users should understand when evaluating the protocol's trustworthiness and long-term viability.
